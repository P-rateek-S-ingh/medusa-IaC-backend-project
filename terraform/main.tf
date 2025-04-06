provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"

  name                 = "medusa-vpc"
  cidr                = "10.0.0.0/16"
  azs                 = ["ap-south-1a", "ap-south-1b"]
  public_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
  enable_dns_support  = true
  enable_dns_hostnames = true
}

module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "4.1.3"

  cluster_name = "medusa-cluster"
}
