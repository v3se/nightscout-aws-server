output "instance_ip_addr" {
  value = aws_instance.nightscout-aws-app.public_ip
}