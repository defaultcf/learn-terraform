data "aws_iam_policy_document" "ec2" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2" {
  name               = "EC2"
  assume_role_policy = data.aws_iam_policy_document.ec2.json

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
