output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "EKS cluster API endpoint"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_version" {
  description = "EKS cluster version"
  value       = module.eks.cluster_version
}

output "eks_cluster_arn" {
  description = "EKS cluster ARN"
  value       = module.eks.cluster_arn
}

output "eks_cluster_security_group_id" {
  description = "EKS cluster security group ID"
  value       = aws_security_group.eks_cluster_sg.id
}

output "eks_worker_security_group_id" {
  description = "EKS worker nodes security group ID"
  value       = aws_security_group.eks_node_sg.id
}

output "eks_iam_role_arn" {
  description = "IAM role ARN for EKS cluster"
  value       = module.eks.cluster_iam_role_arn
}

output "eks_managed_node_groups" {
  description = "EKS managed node groups"
  value       = module.eks.eks_managed_node_groups
  sensitive   = true
}

# ==========================================
# VPC Outputs
# ==========================================

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "VPC CIDR block"
  value       = module.vpc.vpc_cidr_block
}

output "private_subnets" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnets
}

output "nat_gateway_ips" {
  description = "Elastic IP addresses of NAT gateways"
  value       = module.vpc.natgw_ids
}

# ==========================================
# RDS Outputs
# ==========================================

output "rds_endpoint" {
  description = "RDS database endpoint"
  value       = module.rds.db_instance_endpoint
}

output "rds_address" {
  description = "RDS database address"
  value       = module.rds.db_instance_address
}

output "rds_port" {
  description = "RDS database port"
  value       = module.rds.db_instance_port
}

output "rds_database_name" {
  description = "RDS database name"
  value       = module.rds.db_instance_name
}

output "rds_subnet_group_name" {
  description = "RDS subnet group name"
  value       = module.rds.db_subnet_group_id
}

# ==========================================
# S3 Outputs
# ==========================================

output "data_lake_bucket_name" {
  description = "S3 bucket name for data lake"
  value       = aws_s3_bucket.data_lake.id
}

output "data_lake_bucket_arn" {
  description = "S3 bucket ARN for data lake"
  value       = aws_s3_bucket.data_lake.arn
}

output "terraform_state_bucket_name" {
  description = "S3 bucket name for Terraform state"
  value       = aws_s3_bucket.terraform_state.id
}

# ==========================================
# KMS Outputs
# ==========================================

output "eks_kms_key_id" {
  description = "KMS key ID for EKS encryption"
  value       = aws_kms_key.eks.key_id
}

output "eks_kms_key_arn" {
  description = "KMS key ARN for EKS encryption"
  value       = aws_kms_key.eks.arn
}

output "terraform_state_kms_key_id" {
  description = "KMS key ID for Terraform state encryption"
  value       = aws_kms_key.terraform_state.key_id
}

# ==========================================
# Kubeconfig Command
# ==========================================

output "configure_kubectl" {
  description = "Command to configure kubectl"
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks.cluster_name}"
}
