variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-2"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"

  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Environment must be one of: development, staging, production."
  }
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "mlops-aws-extension"
}

# ==========================================
# EKS Configuration
# ==========================================

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.27"
}

variable "instance_type" {
  description = "EC2 instance type for EKS nodes"
  type        = string
  default     = "t3.xlarge"
}

variable "min_nodes" {
  description = "Minimum number of nodes"
  type        = number
  default     = 2

  validation {
    condition     = var.min_nodes >= 1
    error_message = "Minimum nodes must be at least 1."
  }
}

variable "max_nodes" {
  description = "Maximum number of nodes"
  type        = number
  default     = 10

  validation {
    condition     = var.max_nodes <= 100
    error_message = "Maximum nodes should not exceed 100."
  }
}

variable "desired_nodes" {
  description = "Desired number of nodes"
  type        = number
  default     = 3

  validation {
    condition     = var.desired_nodes >= 1
    error_message = "Desired nodes must be at least 1."
  }
}

# ==========================================
# RDS Configuration
# ==========================================

variable "postgres_version" {
  description = "PostgreSQL version"
  type        = string
  default     = "15"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.medium"
}

variable "db_allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  default     = 100

  validation {
    condition     = var.db_allocated_storage >= 20
    error_message = "Allocated storage must be at least 20 GB."
  }
}

variable "db_username" {
  description = "Master database username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Master database password"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.db_password) >= 12
    error_message = "Database password must be at least 12 characters long."
  }
}

# ==========================================
# Tags
# ==========================================

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Project   = "mlops-aws-extension"
    ManagedBy = "Terraform"
  }
}
