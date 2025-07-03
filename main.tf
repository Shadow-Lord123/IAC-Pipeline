
module "app_functions" {
  source = "./app_functions" 
  rg_name = var.rg_name
  location_name = var.location_name     
}

module "kubernetes_services" {
  source = "./kubernetes_services" 
  dev_rg_name = module.app_functions.resource_group_name
  location_name = var.location_name
  
}

module "mssql_server" {
  source = "./mssql_server" 
  dev_rg_name = module.app_functions.resource_group_name
  location_name = var.location_name
  object_id     = var.object_id      
}

module "data_factory" {
  source = "./data_factory" 
  dev_rg_name = module.app_functions.resource_group_name
  location_name = var.location_name     
}

module "logic_apps" {
  source = "./logic_apps" 
  rg_name = var.rg_name
  location_name = var.location_name
  dev_rg_name = module.app_functions.resource_group_name    
}
