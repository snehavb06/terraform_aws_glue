provider "aws" {
  region = var.aws_region
}
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

resource "aws_iam_policy_attachment" "glue_console_access" {
  name       = "glue-console-access"
  roles      = [aws_iam_role.glue_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess"
}

resource "aws_iam_policy_attachment" "s3_full_access" {
  name       = "s3-full-access"
  roles      = [aws_iam_role.glue_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_glue_job" "glue_etl" {
  name     = var.glue_job_name
  role_arn = aws_iam_role.glue_role.arn
  glue_version = "3.0"
  worker_type  = "G.1X"
  number_of_workers = 2
  timeout = 10

  command {
    name            = "gluestudio"
    script_location = ""  # No script needed, Glue Studio manages it
  }

  default_arguments = {
    "--TempDir"                 = "s3://glue-tutor-bucket-practice1/tmp/"
    "--job-bookmark-option"     = "job-bookmark-enable"
    "--enable-glue-datacatalog" = "true"
    "--S3_SOURCE_PATH"          = var.s3_source_path
    "--S3_TARGET_PATH"          = var.s3_target_path
    "--S3_SOURCE_TYPE"          = "s3"
    "--S3_SOURCE_FORMAT"        = "csv"
    "--DELIMITER"               = ","
    "--HAS_HEADER"              = "true"
    "--TRANSFORM_TYPE"          = "dropDuplicates"
    "--MATCH_ENTIRE_ROW"        = "true"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}
