variable "ec2_instance_type" {
  type        = string
  default     = "t3.medium"
  description = "Nightscout server EC2 instance type"
}

variable "ec2_ami_id" {
  type        = string
  description = "Nightscout server EC2 AMI ID"
}

variable "aws_region" {
  type        = string
  description = "AWS Region for all the resources"
}

variable "ec2_management_source_ip" {
  type        = string
  description = "Source IP Address to be added to the security group for allowing ssh connection. Preferrably defined using TF_VAR environment variable"
}

variable "project_common_tag" {
  type        = string
  description = "Common tag for all nightscout resources"
}

variable "ec2_db_volume_size" {
  type        = number
  description = "DB Root volume size"
}

variable "route53_hosted_zone" {
  type        = string
}

variable "route53_dns_record" {
  type        = string
}