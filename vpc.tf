module "vpc" {
  source = "terraform-aws-modules/vpc/aws" # use aws vpc module
  version = "3.14.3"

  name = "eks-vpc"
  cidr = "10.0.0.0/16" # VPC CIDR

  azs             = ["eu-central-1a", "eu-central-1b"] # we need at leas 2 AZs for EKS
  private_subnets = ["10.0.0.0/19", "10.0.32.0/19"] # private subnets for EKS workers
  public_subnets  = ["10.0.64.0/19", "10.0.96.0/19"] # public subnets for EKS workers when expose the service to the internet
  
  enable_nat_gateway = true # we need NAT Gateways to provide internet access for our workers
  single_nat_gateway = true # we want all subnets to use the same NAT Gateway. then allocate elastic IP
  one_nat_gateway_per_az = false # prevent to create NAT Gateways per AZ

  enable_dns_hostnames = true # use dns hostnames
  enable_dns_support   = true # enable dns support

  # set up tags
  tags = {
    Environment = "staging"
  }

}