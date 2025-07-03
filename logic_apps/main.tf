
resource "azurerm_storage_account" "storage_account" {
  name                     = "kritagyastorageaccount"
  resource_group_name      = var.dev_rg_name
  location                 = var.location_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  min_tls_version           = "TLS1_2"

  tags = {
    environment = "dev"
    team        = "integration"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_service_plan" "service-plan" {
  name                = "kritagya-service-plan"
  location            = var.location_name
  resource_group_name = var.dev_rg_name

  os_type  = "Windows"
  sku_name = "WS1"

  tags = {
    usage = "logic-app"
  }
}

resource "azurerm_logic_app_standard" "logic_app" {
  name                       = "kritagya-logic-app"
  location                   = var.location_name
  resource_group_name        = var.dev_rg_name
  app_service_plan_id        = azurerm_service_plan.service-plan.id
  storage_account_name       = azurerm_storage_account.storage_account.name
  storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"     = "node",
    "WEBSITE_NODE_DEFAULT_VERSION" = "~18",
    "AzureWebJobsStorage"          = azurerm_storage_account.storage_account.primary_connection_string
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    app_type = "logic"
  }

  depends_on = [
    azurerm_storage_account.storage_account,
    azurerm_service_plan.service-plan
  ]
}
