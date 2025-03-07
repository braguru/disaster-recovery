resource "aws_codedeploy_app" "amt-global-website" {
  name = "amt-global-website"
  compute_platform = "Server"

  tags = {
    Name        = "amt-global-website"
    Environment = "Staging"
  }
}

resource "aws_codedeploy_deployment_group" "amt-global-website" {
  app_name = aws_codedeploy_app.amt-global-website.name
  deployment_group_name = "amt-global-website"
  service_role_arn = var.service_role_arn

   ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = var.instance_name
    }
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  outdated_instances_strategy = "UPDATE"

  tags = {
    Name        = "amt-global-website"
    Environment = "Staging"
  }
  
}


