resource "aws_key_pair" "juggluco-aws-grafana" {
  key_name   = "juggluco-aws-grafana"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC5FXLXVkaqUjFNl+TBOFzGiMeu/4TH3q0Ip3GhrRD1dIQVI5W/UIVPYGcRdNGINbIlgK8uDEYayQgme1XbDHUpz08blMGchwH+RRe4Nmoq0r/VOxB7oy7iHkj7qRyGuzOlpMJX6KnR7SyiFfoYMsUMKIFg9s8/Kx2Uqau3tluJ4zpmOKmAO2jDQJlL3be/Z96GhfC/3V8jpkJcanv1f4Y75zVS8rf25RGLbQwr05NksnS5Rm33HFYNLmTpWC4TlLJ9DhXy81ou/nQRGo8wuOaPPnHFHoQ3US3C53bnM8xtjhVjmUr39WTks3qUvGwewaOWJqWyvcOgRI/1X+AtZprJPLldscQSKJi8AO8nRFgxWOi/gIRuSkJ14L2rzyr4n1Xz0zB8lmpcSF64N6os+WGgVxhVdd/OHeysjjj4KxGWnTw3gs/uU7ULuXvYCt9JccItnAWLOhL23RQCheroy5GTE7NYJZ3lCWUJ3aMB4pJnyJJ+hGM2ALWqCPEYw5XDJfs= vese@DESKTOP-IEUVHKH"
}

resource "aws_instance" "juggluco-aws-grafana" {
  ami                         = var.ec2_ami_id
  instance_type               = var.ec2_instance_type
  associate_public_ip_address = true
  key_name                    = aws_key_pair.juggluco-aws-grafana.key_name
  tags = {
    Name = "juggluco-aws-grafana"
  }
  lifecycle {
    ignore_changes = [associate_public_ip_address]
  }
  vpc_security_group_ids = [aws_security_group.juggluco-aws-grafana.id]
}

resource "aws_security_group" "juggluco-aws-grafana" {
  name        = "juggluco-aws-grafana"
  description = "Allow autoec2 server traffic"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "juggluco-aws-grafana-ec2-ingress-tcp" {
  type              = "ingress"
  from_port         = 8795
  to_port           = 8795
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.juggluco-aws-grafana.id
}

resource "aws_security_group_rule" "juggluco-ingress-ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.ec2_management_source_ip]
  security_group_id = aws_security_group.juggluco-aws-grafana.id
}

resource "aws_security_group_rule" "juggluco-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.juggluco-aws-grafana.id
}