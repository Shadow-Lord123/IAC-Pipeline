
resource "azurerm_storage_account" "example" {
  name                     = "kritagyastorageaccount"
  resource_group_name      = var.dev_rg_name
  location                 = var.location_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "example" {
  name                = "kritagya-service-plan"
  location            = var.location_name
  resource_group_name = var.dev_rg_name

  os_type  = "Windows"
  sku_name = "WS1"
}

resource "azurerm_logic_app_standard" "example" {
  name                       = "kritagya-logic-app"
  location                   = var.location_name
  resource_group_name        = var.dev_rg_name
  app_service_plan_id        = azurerm_service_plan.example.id
  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"     = "node"
    "WEBSITE_NODE_DEFAULT_VERSION" = "~18"
  }
}