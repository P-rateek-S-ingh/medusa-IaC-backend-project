provider "aws" {
  region = var.aws_region
}

resource "aws_ecr_repository" "medusa" {
  name = "medusa-repo"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"

  name                 = "medusa-vpc"
  cidr                = "10.0.0.0/16"
  azs                 = ["us-east-1a", "us-east-1b"]
  public_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
  enable_dns_support  = true
  enable_dns_hostnames = true
}

resource "aws_rds_instance" "medusa_db" {
  identifier           = "medusa-db"
  engine               = "postgres"
  instance_class       = "db.t3.micro"
  username             = var.db_username
  password             = var.db_password
  allocated_storage    = 20
  publicly_accessible  = true
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.ecs_sg.id]
  db_name              = "medusa"
  db_subnet_group_name = aws_db_subnet_group.medusa.name
}

resource "aws_db_subnet_group" "medusa" {
  name       = "medusa-db-subnet-group"
  subnet_ids = module.vpc.public_subnets
}