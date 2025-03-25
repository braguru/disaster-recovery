# output "code_deploy_role_arn" {
#   description = "The ARN of the service role"
#   value       = aws_iam_role.code_deploy_role.arn
# }

# output "ec2_role_arn" {
#   description = "The ARN of the service role"
#   value       = aws_iam_role.ec2_role.arn
# }

# output "ec2_role_name" {
#   description = "The name of the service role"
#   value       = aws_iam_role.ec2_role.name
# }

# output "ec2_profile_name" {
#   description = "The name of the service role"
#   value       = aws_iam_instance_profile.ec2_profile.name
# }

# output "code_deploy_role_name" {
#   description = "The name of the service role"
#   value       = aws_iam_role.code_deploy_role.name
# }

output "app_runner_role_arn" {
  description = "The ARN of the AppRunner role"
  value       = aws_iam_role.app_runner_role.arn
}










