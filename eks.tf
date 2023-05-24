module "eks" {
  source = "terraform-aws-modules/eks/aws" # use eks module
  version = "18.29.0"

  cluster_version = "1.23"
  cluster_name = "eks-cluster"

  cluster_endpoint_private_access = false # no need for private access
  cluster_endpoint_public_access = true # enable public access

  vpc_id     = module.vpc.vpc_id # use vpc module
  subnet_ids = module.vpc.private_subnets # use private subnets

  enable_irsa = true # enable IAM roles for service accounts

  #TODO: use fargate profile

  # managed node group defaults
  eks_managed_node_group_defaults = {
    disk_size = 50 # 50GB disk size
  }

  # managed nodes
  eks_managed_node_groups = {
    general = { # general node group
      desired_size = 1
      min_size = 1
      max-size = 10

      labels = {
        role = "general"
      }

      instance_types = ["t3.nano"] # instance type
      capacity_type = "ON_DEMAND" # use on-demand instances
    }

    spot = { # spot node group
      desired_size = 1
      min_size     = 1
      max_size     = 10

      labels = {
        role = "spot"
      }

      taints = [{
        key    = "market"
        value  = "spot"
        effect = "NO_SCHEDULE"
      }]

      instance_types = ["t3.nano"]
      capacity_type  = "SPOT"
    }
  }

  tags = {
    Environment = "staging"
  }

}