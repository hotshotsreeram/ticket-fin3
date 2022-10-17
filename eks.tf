
data "terraform_remote_state" "remote" {
  backend = "s3"
  config = {
    bucket = "my-tf-sr-first-bucket"
    key    = "kms/terraform.state"
    region = "us-east-1"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.0"

  cluster_name    = "eks-${var.env_name}-${var.cluster_name}"
  cluster_version = var.eks_version

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  cluster_encryption_config = [{
    provider_key_arn = data.terraform_remote_state.remote.outputs.key_arn
    resources        = ["secrets"]
  }]

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_id


  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    disk_size      = 50
    instance_types = var.nodepool_type
  }

  eks_managed_node_groups = {
    nodepool_1 = {
      min_size     = var.min_no_node
      max_size     = var.max_no_node
      desired_size = 1

      instance_types = var.ovverride_nodepool_type
    #   capacity_type  = "SPOT"
    }
  }


  
  tags = {
    Environment = "${var.env_name}-${var.cluster_name}"
    Terraform   = "true"
  }
}

# output "test" {
#   value = module.eks
# }