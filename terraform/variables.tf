variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-2"
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
  default     = "dev-eks-cluster"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_types" {
  description = "Node instance types"
  type        = list(string)
  default     = ["t3.medium"]
}