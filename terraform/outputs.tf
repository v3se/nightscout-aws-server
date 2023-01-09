output "instance_ip_addr" {
  value = aws_instance.nightscout-aws-grafana.public_ip
}

output "database_ip_addr" {
  value = aws_instance.nightscout-aws-grafana.private_ip
}