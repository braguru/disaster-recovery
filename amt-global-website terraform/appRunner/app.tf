resource "aws_apprunner_service" "app_service" {
  service_name = "amalitech-global-website"

  source_configuration {
    authentication_configuration {
      access_role_arn = var.app_runner_role_arn
    }

    image_repository {
      image_identifier      = "${var.ecr_repository_url}:latest"
      image_repository_type = "ECR"

      image_configuration {
        port = "3000"
      }
    }
  }

  instance_configuration {
    cpu    = "512"
    memory = "1024"
  }

  auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.auto_scaling.arn
}

resource "aws_apprunner_auto_scaling_configuration_version" "auto_scaling" {
  auto_scaling_configuration_name = "amalitech-web-auto-scaling"

  max_concurrency = 100
  max_size        = 2
  min_size        = 1

}
