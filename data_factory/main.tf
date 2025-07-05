
resource "azurerm_data_factory" "example" {
  name                = "datakrit"
  location            = var.location_name
  resource_group_name = var.dev_rg_name

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "dev"
    managed_by  = "terraform"
    department  = "data-engineering"
  }

  global_parameter {
    name  = "PipelineTimeout"
    type  = "String"
    value = "00:30:00"
  }

  global_parameter {
    name  = "Environment"
    type  = "String"
    value = "dev"
  }
}

