terraform {
  backend "azurerm" {
    resource_group_name  = "StorageRG"
    storage_account_name = "storagefuncappsa"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
