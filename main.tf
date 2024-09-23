locals {
  name   = "oncourse-eks-cluster"
  region = "us-east-1"

  vpc_cidr = "172.31.0.0/16"
  azs      = ["us-east-1a", "us-east-1b"]

  public_subnets  = ["172.31.0.0/20", "172.31.16.0/20"]
  private_subnets = ["172.31.32.0/20", "172.31.48.0/20"]
  intra_subnets   = ["172.31.64.0/20", "172.31.80.0/20"] 

  tags = {
    name       = local.name
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
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets
  intra_subnets   = local.intra_subnets

  enable_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = local.tags
}
