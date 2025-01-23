data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codedeploy.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_role" "existing_role" {
  name = "aws-code-deploy-role"
}

resource "aws_iam_role" "code_deploy_role" {
  count = length(data.aws_iam_role.existing_role.id) == 0 ? 1 : 0
  name               = "aws-code-deploy-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "codedeploy_policy_attachment" {
  count = length(data.aws_iam_role.existing_role.id) == 0 ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.code_deploy_role[count.index].name

}

resource "aws_sns_topic" "deployment_topic" {
  name = var.deployment_group_sns_topic
}

resource "aws_codedeploy_app" "codedeploy_app" {
  name = var.app_name
}

resource "aws_codedeploy_deployment_group" "codedeploy_group" {
  count                 = length(var.deployment_groups)
  app_name              = aws_codedeploy_app.codedeploy_app.name
  deployment_group_name = var.deployment_groups[count.index]

  # Use the role ARN from the resource if created, otherwise use the data source
  service_role_arn = length(data.aws_iam_role.existing_role.id) == 0 ? aws_iam_role.code_deploy_role[0].arn : data.aws_iam_role.existing_role.arn


  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = var.instance_name
    }
  }

  trigger_configuration {
    trigger_events     = ["DeploymentFailure"]
    trigger_name       = "deployment-failure-trigger"
    trigger_target_arn = aws_sns_topic.deployment_topic.arn
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  alarm_configuration {
    alarms  = [var.alarm_name]
    enabled = true
  }

  outdated_instances_strategy = "UPDATE"
}
