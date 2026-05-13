# ============================================
# Terraform Main Configuration
# ============================================
# This is the entry point for Terraform.
# It defines WHAT infrastructure to create on AWS.
#
# WHY TERRAFORM?
# - Infrastructure as Code (version controlled, reviewable)
# - Reproducible environments (dev = staging = prod)
# - Drift detection (knows if someone changed things manually)
# - Dependency management (creates resources in correct order)
# - Used by 90%+ of cloud engineering teams
# ============================================

terraform {
  # Pin Terraform version to prevent breaking changes
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  # Allow 5.x patches, not 6.0
    }
  }

  # Backend configuration for remote state storage
  # WHY REMOTE STATE?
  # - Team collaboration (everyone sees same state)
  # - State locking (prevents concurrent modifications)
  # - Encrypted at rest (S3 + DynamoDB)
  #
  # UNCOMMENT when you have an S3 bucket ready:
  # backend "s3" {
  #   bucket         = "aegis-terraform-state"
  #   key            = "infrastructure/terraform.tfstate"
  #   region         = "us-east-1"
  #   encrypt        = true
  #   dynamodb_table = "aegis-terraform-locks"
  # }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region

  # Default tags applied to ALL resources
  # WHY: Consistent tagging for cost tracking, ownership, and compliance
  default_tags {
    tags = {
      Project     = "aegis-devsecops-platform"
      Environment = var.environment
      ManagedBy   = "terraform"
      Owner       = "devops-team"
    }
  }
}
