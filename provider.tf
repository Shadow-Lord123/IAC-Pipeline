

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.66.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "azurerm" {
  features {}

  tenant_id       = "6de1ce30-fe8d-4c84-9bb4-b1e5ab5655cb"
  subscription_id = "2981bf38-3a73-4a81-8373-416f0d45f251" 
}



