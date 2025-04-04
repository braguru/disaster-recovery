resource "aws_cloudwatch_log_group" "dr-cloudwatch-log-group" {
  name              = "dr-cloudwatch-log-group"
  retention_in_days = 30

  tags = {
    Name = "dr-cloudwatch-log-group"
  }
}

resource "aws_flow_log" "dr-flow-log" {
  iam_role_arn    = var.iam_role_arn
  traffic_type    = var.traffic_type
  vpc_id          = var.vpc_id
  log_destination = aws_cloudwatch_log_group.dr-cloudwatch-log-group.arn

  tags = {
    Name = "dr-flow-log"
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "High-CPU-Utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = 60
  statistic          = "Average"
  threshold          = 80
  alarm_description  = "Triggers when CPU utilization exceeds 80%"
  alarm_actions      = [var.sns_topic_arn]

  dimensions = {
    InstanceId = var.asg_name  # Replace with your EC2 instance ID
  }
}

resource "aws_cloudwatch_dashboard" "dr-cloudwatch-dashboard" {
  dashboard_name = "ASG-ALB-Dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        "type": "metric",
        "x": 0,
        "y": 0,
        "width": 12,
        "height": 6,
        "properties": {
          "title": "DR-CPU Utilization",
          "view": "timeSeries",
          "stacked": false,
          "metrics": [
            [ "AWS/EC2", "CPUUtilization", "AutoScalingGroupName", var.asg_name ]
          ],
          "region": "eu-west-1",
          "period": 300,
          "stat": "Average"
        }
      },
      {
        "type": "metric",
        "x": 0,
        "y": 6,
        "width": 12,
        "height": 6,
        "properties": {
          "title": "ALB Request Count",
          "view": "timeSeries",
          "stacked": false,
          "metrics": [
            [ "AWS/ApplicationELB", "RequestCount", "LoadBalancer", var.alb_name ]
          ],
          "region": "eu-west-1",
          "period": 300,
          "stat": "Sum"
        }
      },
      {
        "type": "metric",
        "x": 0,
        "y": 12,
        "width": 12,
        "height": 6,
        "properties": {
          "title": "ALB Target Response Time",
          "view": "timeSeries",
          "stacked": false,
          "metrics": [
            [ "AWS/ApplicationELB", "TargetResponseTime", "LoadBalancer", var.alb_name ]
          ],
          "region": "us-east-1",
          "period": 300,
          "stat": "Average"
        }
      }
    ]
  })
}








