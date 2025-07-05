terraform {
  backend "azurerm" {
    resource_group_name  = "StorageV2RG"
    storage_account_name = "kritagyastorageacct"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
