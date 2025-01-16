output "ssm_instance_profile_arn" {
  value       = aws_iam_instance_profile.ssm_instance_profile.arn
  description = "The ARN of the ssm instance profile"
}

output "ssm_instance_profile_name" {
  value       = aws_iam_instance_profile.ssm_instance_profile.name
  description = "Name of the IAM instance profile for SSM"
}

output "ssm_role_arn" {
  value       = aws_iam_role.ssm_role.arn
  description = "The ARN of SSM IAM role"
}
