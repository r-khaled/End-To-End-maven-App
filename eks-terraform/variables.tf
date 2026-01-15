variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "key_pair_name" {
  description = "Name of AWS key pair for SSH access to nodes"
  default     = "my-eks-key"
}
variable "cluster_name" {
  description = "EKS Cluster Name"
  default     = "app-prod-cluster"
}