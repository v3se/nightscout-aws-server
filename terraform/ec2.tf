resource "aws_instance" "nightscout-aws-app" {
  ami                         = var.ec2_ami_id
  instance_type               = var.ec2_instance_type
  associate_public_ip_address = true
  key_name                    = aws_key_pair.nightscout-aws-app.key_name
  tags = {
    Name = "nightscout-aws-app-app"
    Role = "nightscout-app"
  }
  lifecycle {
    ignore_changes = [associate_public_ip_address]
  }
  root_block_device {
        volume_size = var.ec2_db_volume_size
  }
  vpc_security_group_ids = [aws_security_group.nightscout-aws-app.id]
}

resource "aws_security_group" "nightscout-aws-app" {
  name        = "nightscout-aws-app"
  description = "Allow nightscout server traffic"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "nightscout-aws-app-ec2-ingress-http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nightscout-aws-app.id
}

resource "aws_security_group_rule" "nightscout-aws-app-ec2-ingress-https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nightscout-aws-app.id
}

resource "aws_security_group_rule" "nightscout-ingress-ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.ec2_management_source_ip]
  security_group_id = aws_security_group.nightscout-aws-app.id
}

resource "aws_security_group_rule" "nightscout-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.nightscout-aws-app.id
}