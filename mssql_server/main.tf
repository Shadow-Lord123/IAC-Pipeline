
resource "azurerm_mssql_server" "example" {
  name                         = "kritagyasqlserver"
  resource_group_name          = var.dev_rg_name
  location                     = var.location_name
  version                      = "12.0"
  administrator_login          = "missadministrator"
  administrator_login_password = "thisIsKat11"
  minimum_tls_version          = "1.2"

  public_network_access_enabled        = true
  outbound_network_restriction_enabled = true

  identity {
    type = "SystemAssigned"
  }

  azuread_administrator {
    login_username = "AzureAD Admin"
    object_id      = var.object_id
  }

  tags = {
  Environment        = "Production"
  Team               = "DevOps"
  Project            = "SQL"
  ManagedByTerraform = "true"
  Compliance         = "yes"
  Critical           = "yes"
  PatchRequired      = "yes"
  LastUpdated        = "2025-06-30"
}

}

resource "azurerm_mssql_firewall_rule" "allow_my_ip" {
  name              = "allow-my-ip"
  server_id         = azurerm_mssql_server.example.id
  start_ip_address  = "86.24.253.5"
  end_ip_address    = "86.24.253.5"
}

resource "azurerm_mssql_firewall_rule" "allow_azure" {
  name              = "allow-azure-services"
  server_id         = azurerm_mssql_server.example.id
  start_ip_address  = "0.0.0.0"
  end_ip_address    = "0.0.0.0"

  depends_on = [azurerm_mssql_server.example]
}