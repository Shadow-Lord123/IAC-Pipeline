variable "rg_name" {
  description = "Resource Group for VPC"
  type        = string
}

variable "location_name" {
  description = "Location Name for VPC"
  type        = string
}

variable "object_id" {
  description = "The object ID of the Azure AD group or user."
  type        = string
}

variable "tenant_id" {
  description = "The Azure Active Directory tenant ID"
  type        = string
}

variable "subscription_id" {
  description = "The Azure Subscription ID"
  type        = string
}

