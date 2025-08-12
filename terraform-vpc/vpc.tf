# vpc.tf
data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  # you can pin a version here if you want, e.g. version = ">= 3.0.0"
  name = "${var.env}-vpc"
  cidr = var.vpc_cidr

  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway = true
  single_nat_gateway = false

  tags = {
    Environment = var.env
    ManagedBy   = "Terraform"
  }
}
