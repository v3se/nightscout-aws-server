terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.69.0"
    }
  }
  required_version = ">=1.0.0"
  backend "s3" {
    bucket = "terraform-vesenet"
    key    = "terraform/nightscout-aws-grafana.tfstate"
    region = "eu-north-1"
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      project = var.project_common_tag
    }
  }
}

data "aws_caller_identity" "aws-info" {}

resource "aws_key_pair" "nightscout-aws-grafana" {
  key_name   = "nightscout-aws-grafana"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC5FXLXVkaqUjFNl+TBOFzGiMeu/4TH3q0Ip3GhrRD1dIQVI5W/UIVPYGcRdNGINbIlgK8uDEYayQgme1XbDHUpz08blMGchwH+RRe4Nmoq0r/VOxB7oy7iHkj7qRyGuzOlpMJX6KnR7SyiFfoYMsUMKIFg9s8/Kx2Uqau3tluJ4zpmOKmAO2jDQJlL3be/Z96GhfC/3V8jpkJcanv1f4Y75zVS8rf25RGLbQwr05NksnS5Rm33HFYNLmTpWC4TlLJ9DhXy81ou/nQRGo8wuOaPPnHFHoQ3US3C53bnM8xtjhVjmUr39WTks3qUvGwewaOWJqWyvcOgRI/1X+AtZprJPLldscQSKJi8AO8nRFgxWOi/gIRuSkJ14L2rzyr4n1Xz0zB8lmpcSF64N6os+WGgVxhVdd/OHeysjjj4KxGWnTw3gs/uU7ULuXvYCt9JccItnAWLOhL23RQCheroy5GTE7NYJZ3lCWUJ3aMB4pJnyJJ+hGM2ALWqCPEYw5XDJfs= vese@DESKTOP-IEUVHKH"
}
