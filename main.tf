resource "aws_iam_role" "glue_role" {
  name = var.glue_role_name

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "glue.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
  EOF
}

resource "aws_iam_policy_attachment" "glue_policy" {
  name       = "glue-policy-attachment"
  roles      = [aws_iam_role.glue_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess" "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
