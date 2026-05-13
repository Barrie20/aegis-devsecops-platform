# ============================================
# Terraform Variables
# ============================================
# Variables make your infrastructure configurable.
# Different environments (dev/staging/prod) use
# different values for the same variables.
#
# BEST PRACTICE:
# - Always add descriptions (self-documenting)
# - Always add type constraints (catches errors early)
# - Use validation blocks for critical values
# - Provide sensible defaults where appropriate
# ============================================

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"

  validation {
    condition     = can(regex("^(us|eu|ap|sa|ca|me|af)-(north|south|east|west|central|northeast|southeast)-[1-3]$", var.aws_region))
    error_message = "Must be a valid AWS region (e.g., us-east-1, eu-west-2)."
  }
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "aegis"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
