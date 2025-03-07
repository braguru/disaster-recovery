output "deployment_group_name" {
  description = "The name of the deployment group"
  value       = aws_codedeploy_deployment_group.amt-global-website.deployment_group_name
}

output "app_name" {
  description = "The name of the application"
  value       = aws_codedeploy_app.amt-global-website.name
}




