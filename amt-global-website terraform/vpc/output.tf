output "vpc_id" {
  value = aws_default_vpc.default.id
}

output "vpc_cidr" {
  value = aws_default_vpc.default.cidr_block
}