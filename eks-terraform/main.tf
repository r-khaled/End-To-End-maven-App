provider "aws" {
  region = var.aws_region
}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.21.0"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "22.2.0"

  cluster_name    = [var.cluster_name]
  cluster_version = "1.28"

  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  # worker nodes
  node_groups = {
    app_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_type = "t3.medium"

      key_name = var.key_pair_name
    }
  }

  tags = {
    Environment = "prod"
    Project     = "maven-app-deployment"
  }
}
