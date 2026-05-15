# 1. Network Layer
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.cluster_name}-vpc"
  cidr = var.vpc_cidr

  azs             = ["${var.region}a", "${var.region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
}

# 2. Compute Layer (EKS)
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.31"

  # --- FIX 1: Enable OIDC Provider ---
  # This creates the Identity Provider so K8s can use IAM roles
  enable_irsa = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Core Add-ons
  cluster_addons = {
    aws-ebs-csi-driver = {
      # --- FIX 2: Add Permissions to the Driver ---
      most_recent              = true
      attach_ebs_csi_policy    = true 
    }
    coredns    = {}
    vpc-cni    = {}
    kube-proxy = {}
  }

  eks_managed_node_groups = {
    main = {
      instance_types = var.instance_types
      min_size       = 1
      max_size       = 2
      desired_size   = 2
    }
  }

  # Gives the IAM entity running Terraform (Jenkins) admin rights in K8s
  enable_cluster_creator_admin_permissions = true
}