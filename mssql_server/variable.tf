
variable "location_name" {
  description = "Azure Region"
  type        = string
}

variable "dev_rg_name" {
  description = "The name of the resource group"
  type        = string
}

variable "object_id" {
  description = "The object ID of the Azure AD group or user."
  type        = string
}
