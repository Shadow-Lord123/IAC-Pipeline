
resource "azurerm_data_factory" "example" {
  name                = "datakrit"
  location            = var.location_name
  resource_group_name = var.dev_rg_name
}