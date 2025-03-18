output "aws_lb_target_group_arn" {
  value = aws_lb_target_group.target_group.arn
}

output "aws_lb_target_group_name" {
  value = aws_lb_target_group.target_group.name
}

output "aws_lb_arn" {
  value = aws_lb.DR-cross_zone_load_balancing.arn
}

  output "aws_lb_dns_name" {
    value = aws_lb.DR-cross_zone_load_balancing.dns_name
  }

output "aws_lb_id" {
  value = aws_lb.DR-cross_zone_load_balancing.id
}

output "target_group_arn" {
  value = aws_lb_target_group.target_group.arn
}

output "alb_name" {
  value = aws_lb.DR-cross_zone_load_balancing.name
}

output "alb_zone_id" {
  value = aws_lb.DR-cross_zone_load_balancing.zone_id
}

