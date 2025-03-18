resource "aws_globalaccelerator_accelerator" "dr_accelerator" {
  name            = "dr-accelerator"
  enabled         = true
  ip_address_type = "IPV4"
}

resource "aws_globalaccelerator_listener" "dr_listener" {
  accelerator_arn = aws_globalaccelerator_accelerator.dr_accelerator.arn
  protocol        = "TCP"

  port_range {
    from_port = 80
    to_port   = 443
  }
}

resource "aws_globalaccelerator_endpoint_group" "eu_west_endpoint" {
  listener_arn = aws_globalaccelerator_listener.dr_listener.arn
  endpoint_group_region = "eu-west-1"

  endpoint_configuration {
    endpoint_id                    = var.alb_arn
    weight                         = 100
    client_ip_preservation_enabled = true
  }
}

# resource "aws_globalaccelerator_endpoint_group" "eu_central_endpoint" {
#   listener_arn = aws_globalaccelerator_listener.dr_listener.arn
#   endpoint_group_region = "eu-central-1"

#   endpoint_configuration {
#     endpoint_id                    = var.alb_arn
#     weight                         = 50
#     client_ip_preservation_enabled = true
#   }
# }
