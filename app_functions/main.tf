
resource "azurerm_resource_group" "example" {
  name     = "DevRG"
  location = var.location_name
}

resource "azurerm_storage_account" "example" {
  name                     = "kritagyafuncappsa"
  resource_group_name      = azurerm_resource_group.example.name   
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "example" {
  name                = "azure-functions-test-service-plan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name        

  sku_name = "S1"
  os_type  = "Windows"
}

resource "azurerm_windows_function_app" "example" {
  name                       = "kritagyafunction"
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name 
  service_plan_id            = azurerm_service_plan.example.id
  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key

  site_config {}
}


