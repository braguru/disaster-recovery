resource "aws_route53_health_check" "eu_west_health_check" {
  fqdn              = var.alb_dns_name
  port              = 443
  type              = "HTTPS"
  failure_threshold = 3
  request_interval  = 30
  tags = {
    Name = "DR-Health-Check"
  }
}

# resource "aws_route53_health_check" "cloudwatch_health_check" {
#   type                            = "CLOUDWATCH_METRIC"
#   cloudwatch_alarm_name           = var.cloudwatch_alarm_name
#   insufficient_data_health_status = var.insufficient_data_health_status
#   cloudwatch_alarm_region = "eu-west-1"
# }

# resource "aws_route53_health_check" "eu_central_health_check" {
#   fqdn              = var.alb_dns_name
#   port              = 443
#   type              = "HTTPS"
#   failure_threshold = 3
#   request_interval  = 30
# }

resource "aws_route53_record" "failover_primary" {
  zone_id        = var.route53_zone_id
  name           = var.alb_name
  type           = "A"
  set_identifier = "dr-primary"

  failover_routing_policy {
    type = "PRIMARY"
  }

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }

  health_check_id = aws_route53_health_check.eu_west_health_check.id
}

resource "aws_route53_record" "ec2_domain" {
  zone_id = var.route53_zone_id
  name    = "chrisncs.guruworld.click"
  type    = "CNAME"
  ttl     = 60
  records = [var.alb_dns_name]

}

# resource "aws_route53_record" "failover_secondary" {
#   zone_id = var.route53_zone_id
#   name    = var.alb_name
#   type    = "A"

#   set_identifier = "dr-secondary"
#   failover_routing_policy {
#     type = "SECONDARY"
#   }

#   alias {
#     name                   = var.alb_dns_name
#     zone_id                = var.alb_zone_id
#     evaluate_target_health = true
#   }

#   health_check_id = aws_route53_health_check.eu_central_health_check.id
# }
