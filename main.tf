provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {}

locals {
  name   = "oncourse-sample-eks"
  region = "us-east-1"

### If you have a ready VPC, use the values below 
# azs      = ["us-east-1a", "us-east-1b"]
# public_subnets  = ["10.0.0.0/19", "10.0.32.0/19"]
# private_subnets = ["10.0.64.0/19", "10.0.96.0/19"]
# intra_subnets   = ["10.0.128.0/19", "10.0.160.0/19"]

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    example    = local.name
    team       = "oncourse_cloud_devops"
    owner      = "shavkat.isakov"
  }
}

##############
# VPC section
##############


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 48)]
  intra_subnets   = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 52)]

  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = local.tags
}
