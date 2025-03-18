output "route53_primary_zone_id" {
  value = aws_route53_record.failover_primary.zone_id
}

output "route53_primary_zone_name" {
  value = aws_route53_record.failover_primary.name
}

output "route53_primary_record_id" {
  value = aws_route53_record.failover_primary.id
}

output "route53_primary_record_name" {
  value = aws_route53_record.failover_primary.name
}

output "route53_primary_record_type" {
  value = aws_route53_record.failover_primary.type
}

output "route53_primary_record_ttl" {
  value = aws_route53_record.failover_primary.ttl
}

output "route53_primary_record_set_identifier" {
  value = aws_route53_record.failover_primary.set_identifier
}

output "route53_primary_record_failover_routing_policy" {
  value = aws_route53_record.failover_primary.failover_routing_policy
}

# output "route53_secondary_zone_id" {
#   value = aws_route53_record.failover_secondary.zone_id
# }

# output "route53_secondary_zone_name" {
#   value = aws_route53_record.failover_secondary.name
# }

# output "route53_secondary_record_id" {
#   value = aws_route53_record.failover_secondary.id
# }

# output "route53_secondary_record_name" {
#   value = aws_route53_record.failover_secondary.name
# }

# output "route53_secondary_record_type" {
#   value = aws_route53_record.failover_secondary.type
# }

# output "route53_secondary_record_ttl" {
#   value = aws_route53_record.failover_secondary.ttl
# }

# output "route53_secondary_record_set_identifier" {
#   value = aws_route53_record.failover_secondary.set_identifier
# }
