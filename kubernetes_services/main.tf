
resource "azurerm_kubernetes_cluster" "example" {
  name                = "kritagyaaks3"
  location            = var.location_name
  resource_group_name = var.dev_rg_name
  dns_prefix          = "kritagyadns"
  node_resource_group = "DefaultRG"

  kubernetes_version = "1.33"  

  default_node_pool {
    name                = "default"
    node_count          = 2
    vm_size             = "Standard_D4s_v3"
    os_disk_size_gb     = 100
    type                = "VirtualMachineScaleSets"
    

    node_labels = {
      environment = "production"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control_enabled = true
  azure_policy_enabled              = true

  network_profile {
    network_plugin     = "azure"
    network_policy     = "azure"
    load_balancer_sku  = "standard"
    outbound_type      = "loadBalancer"
  }

  sku_tier = "Standard"

  tags = {
    Environment = "Production"
    Owner       = "Kritagya"
    Purpose     = "Simplified AKS Cluster"
  }
}
