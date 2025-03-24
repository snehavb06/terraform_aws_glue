variable "aws_region" {
  default = "ap-southeast-1"
}

variable "glue_job_name" {
  default = "ETL-2"
}

variable "s3_source_path" {
  default = "s3://glue-tutor-bucket-practice1/landing_zone/customer/customers-100.csv"
}

variable "s3_target_path" {
  default = "s3://glue-tutor-bucket-practice1/landing_zone/result/"
}

variable "glue_role_name" {
  default = "glue_role"
}
