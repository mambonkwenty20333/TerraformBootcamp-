module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name = "${eks-nebulance}-vpc"
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    "Name" = "nebulance-vpc"
  }
}


module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.3"

  cluster_name    = var.cluster_name
  cluster_version = "1.28"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  enable_irsa = true  # Important for External Secrets

  eks_managed_node_groups = {
    default = {
      desired_size = 2
      max_size     = 10
      min_size     = 2

      instance_types = ["t3.medium"]

      labels = {
        role = "worker"
      }

      tags = {
        "Name" = "eks-nodegroup"
      }
    }
  }

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {
      resolve_conflicts = "OVERWRITE"
    }
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  tags = {
    "project" = "nebulance"
  }
}
