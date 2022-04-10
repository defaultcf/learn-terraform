data "aws_iam_policy_document" "ec2" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ec2_policy" {
  statement {
    actions = [
      "s3:Get*",
      "s3:List*"
    ]
    resources = [
      "${var.s3_codepipeline_arn}",
      "${var.s3_codepipeline_arn}/*",
      "arn:aws:s3:::aws-codedeploy-${var.region}/*"
    ]
  }
}

resource "aws_iam_role" "ec2" {
  name               = "EC2"
  assume_role_policy = data.aws_iam_policy_document.ec2.json
  inline_policy {
    name   = "ec2-policy"
    policy = data.aws_iam_policy_document.ec2_policy.json
  }

  tags = {
    Name = "tf-example-iam-role-ec2"
  }
}

data "aws_iam_policy" "systems_manager" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

  tags = {
    Name = "tf-example-iam-policy-systems-manager"
  }
}

resource "aws_iam_role_policy_attachment" "default" {
  role       = aws_iam_role.ec2.name
  policy_arn = data.aws_iam_policy.systems_manager.arn
}

resource "aws_iam_instance_profile" "systems_manager" {
  name = "MyInstanceProfile"
  role = aws_iam_role.ec2.name

  tags = {
    Name = "tf-example-iam-instance-profile-system-manager"
  }
}
