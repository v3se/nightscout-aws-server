resource "aws_route53_zone" "main" {
  name = var.route53_hosted_zone
}

resource "aws_route53_record" "nightscout-a-record" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.route53_dns_record
  type    = "A"
  ttl     = 300
  records = [aws_instance.nightscout-aws-app.public_ip]
}