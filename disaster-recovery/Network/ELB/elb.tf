resource "aws_lb" "DR-cross_zone_load_balancing" {
  name                       = var.elb_name
  subnets                    = var.subnets
  security_groups            = var.security_groups
  internal                   = false
  load_balancer_type         = "application"
  enable_deletion_protection = false
  idle_timeout               = 400

  tags = {
    Name = var.elb_name
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  load_balancing_algorithm_type = "round_robin"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    unhealthy_threshold = 2
    healthy_threshold   = 5
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.DR-cross_zone_load_balancing.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}