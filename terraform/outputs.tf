output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "ebs_csi_role_arn" {
  value = module.ebs_csi_irsa_role.iam_role_arn
}