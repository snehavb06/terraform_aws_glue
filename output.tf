output "glue_job_name" {
  value = aws_glue_job.glue_etl.name
}

output "glue_role_arn" {
  value = aws_iam_role.glue_role.arn
}
