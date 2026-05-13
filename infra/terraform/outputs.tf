# ============================================
# Terraform Outputs
# ============================================
# Outputs display important values after terraform apply.
# They can also be referenced by other Terraform modules.
#
# WHY OUTPUTS?
# - Show important info (VPC ID, endpoint URLs)
# - Pass values between modules
# - Used by CI/CD pipelines to get resource IDs
# ============================================

# Outputs will be added as we build infrastructure modules
# Example:
# output "vpc_id" {
#   description = "ID of the VPC"
#   value       = module.vpc.vpc_id
# }
