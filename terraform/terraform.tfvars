### Common #####
project_common_tag = "nightscout-project"
aws_region         = "eu-north-1"

### EC2 ###
ec2_instance_type = "t4g.small"
ec2_ami_id        = "ami-05a5649834e220448" #64-bit ARM
ec2_db_volume_size = 10 #In gigabytes

### DNS ###
route53_hosted_zone = "whado.net"
route53_dns_record = "vesegluco.whado.net"
