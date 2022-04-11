locals {
  deployment_group_name = "tf-example-deploy-group"
}

resource "aws_codedeploy_app" "deploy_app" {
  compute_platform = "Server"
  name             = "tf-example-deploy-app"

  tags = {
    Name = "tf-example-deploy-app"
  }
}

resource "aws_codedeploy_deployment_group" "deploy_group" {
  app_name               = aws_codedeploy_app.deploy_app.name
  deployment_group_name  = local.deployment_group_name
  service_role_arn       = aws_iam_role.codedeploy.arn
  deployment_config_name = "CodeDeployDefault.OneAtATime"

  autoscaling_groups = [var.autoscaling_group]

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }

  load_balancer_info {
    target_group_info {
      name = var.lb_target_group_name
    }
  }

  tags = {
    Name = local.deployment_group_name
  }
}

resource "aws_codestarconnections_connection" "github" {
  name          = "tf-example-connection"
  provider_type = "GitHub"

  tags = {
    Name = "tf-example-connection"
  }
}

resource "aws_codepipeline" "codepipeline" {
  name     = "tf-example-pipeline"
  role_arn = aws_iam_role.codepipeline.arn

  artifact_store {
    location = var.s3_codepipeline
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.github.arn
        FullRepositoryId = "defaultcf/learn-terraform"
        BranchName       = "main"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      input_artifacts = ["source_output"]
      version         = "1"

      configuration = {
        ApplicationName     = aws_codedeploy_app.deploy_app.name
        DeploymentGroupName = local.deployment_group_name
      }
    }
  }

  tags = {
    Name = "tf-example-pipeline"
  }
}
