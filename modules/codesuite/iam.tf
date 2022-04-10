# --- CodeDeploy ---

data "aws_iam_policy_document" "codedeploy_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codedeploy.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codedeploy" {
  name               = "CodeDeploy"
  assume_role_policy = data.aws_iam_policy_document.codedeploy_assume_role.json

  tags = {
    Name = "tf-example-iam-role-codedeploy"
  }
}

resource "aws_iam_role_policy_attachment" "codedeploy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.codedeploy.name
}

# --- CodePipeline ---

data "aws_iam_policy_document" "codepipeline_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "codepipeline_policy" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObjectAcl",
      "s3:PutObject"
    ]
    resources = [
      var.s3_codepipeline_arn,
      "${var.s3_codepipeline_arn}/*"
    ]
  }

  statement {
    actions = [
      "codestar-connections:UseConnection"
    ]
    resources = [
      aws_codestarconnections_connection.github.arn
    ]
  }

  statement {
    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StarBuild"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "codepipeline" {
  name               = "CodePipeline"
  assume_role_policy = data.aws_iam_policy_document.codepipeline_assume_role.json
  inline_policy {
    name   = "codepipeline-policy"
    policy = data.aws_iam_policy_document.codepipeline_policy.json
  }

  tags = {
    Name = "tf-example-iam-role-codepipeline"
  }
}

