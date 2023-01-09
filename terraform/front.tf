resource "aws_instance" "nightscout-aws-grafana" {
  ami                         = var.ec2_ami_id
  instance_type               = var.ec2_instance_type
  associate_public_ip_address = true
  key_name                    = aws_key_pair.nightscout-aws-grafana.key_name
  tags = {
    Name = "nightscout-aws-grafana-app"
    Role = "nightscout-app"
  }
  lifecycle {
    ignore_changes = [associate_public_ip_address]
  }
  vpc_security_group_ids = [aws_security_group.nightscout-aws-grafana.id]
}

resource "aws_security_group" "nightscout-aws-grafana" {
  name        = "nightscout-aws-grafana"
  description = "Allow nightscout server traffic"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "nightscout-aws-grafana-ec2-ingress-http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nightscout-aws-grafana.id
}

resource "aws_security_group_rule" "nightscout-aws-grafana-ec2-ingress-https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nightscout-aws-grafana.id
}

resource "aws_security_group_rule" "nightscout-ingress-ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.ec2_management_source_ip]
  security_group_id = aws_security_group.nightscout-aws-grafana.id
}

resource "aws_security_group_rule" "nightscout-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.nightscout-aws-grafana.id
}