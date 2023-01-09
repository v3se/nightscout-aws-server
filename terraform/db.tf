resource "aws_instance" "nightscout-aws-grafana-db" {
  ami                         = var.ec2_ami_id
  instance_type               = var.ec2_instance_type
  associate_public_ip_address = false
  key_name                    = aws_key_pair.nightscout-aws-grafana.key_name
  tags = {
    Name = "nightscout-aws-grafana-database"
    Role = "nightscout-db"
  }
  lifecycle {
    ignore_changes = [associate_public_ip_address]
  }
  root_block_device {
        volume_size = var.ec2_db_volume_size
  }
  vpc_security_group_ids = [aws_security_group.nightscout-aws-grafana-db.id]
}

resource "aws_security_group" "nightscout-aws-grafana-db" {
  name        = "nightscout-aws-grafana-db"
  description = "Allow traffic from nightscout instance"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "nightscout-aws-grafana-db-ec2-ingress-tcp" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  source_security_group_id = aws_security_group.nightscout-aws-grafana.id
  security_group_id = aws_security_group.nightscout-aws-grafana-db.id
}

resource "aws_security_group_rule" "nightscout-aws-grafana-db-ec2-ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.ec2_management_source_ip]
  security_group_id = aws_security_group.nightscout-aws-grafana-db.id
}

resource "aws_security_group_rule" "nightscout-aws-grafana-db-ec2-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.nightscout-aws-grafana-db.id
}


