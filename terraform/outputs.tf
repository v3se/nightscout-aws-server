output "instance_ip_addr" {
  value = aws_instance.juggluco-aws-grafana.public_ip
}