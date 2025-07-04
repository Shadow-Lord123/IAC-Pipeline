
resource "azurerm_signalr_service" "example" {
  name                = "kritagya-signalr"
  location            = var.location_name
  resource_group_name = var.dev_rg_name

  sku {
    name     = "Free_F1"
    capacity = 1
  }

  cors {
    allowed_origins = ["http://www.example.com"]
  }

  public_network_access_enabled = false

  connectivity_logs_enabled = true
  messaging_logs_enabled    = true
  service_mode              = "Serverless"

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "dev"
    managed_by  = "terraform"
    owner       = "integration-team"
  }
}
