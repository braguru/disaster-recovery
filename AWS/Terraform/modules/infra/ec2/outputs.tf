output "instance_name" {
  value = aws_instance.this.tags["Name"]
}
