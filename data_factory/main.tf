
resource "azurerm_data_factory" "datakrit_df" {
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

resource "azurerm_storage_account" "datakrit_storage" {
  name                     = "datakritstorage"
  resource_group_name      = var.dev_rg_name
  location                 = var.location_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "blob_link" {
  name              = "blobLinkedService"
  data_factory_id   = azurerm_data_factory.datakrit_df.id
  connection_string = azurerm_storage_account.datakrit_storage.primary_connection_string
}

resource "azurerm_data_factory_dataset_binary" "binary_blob_dataset" {
  name                = "binaryBlobDataset"
  data_factory_id     = azurerm_data_factory.datakrit_df.id
  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.blob_link.name

  azure_blob_storage_location {
    container = "binarydata"
    path      = "raw/"
    filename  = "data.bin"
  }
}

resource "azurerm_mssql_server" "datakrit_sql_server" {
  name                         = "datakritsqlserver"
  resource_group_name          = var.dev_rg_name
  location                     = var.location_name
  version                      = "12.0"
  administrator_login          = "sqladminuser"
  administrator_login_password = "ChangeM3Now123!" 
}

resource "azurerm_mssql_database" "datakrit_sql_db" {
  name                = "datakritdb"
  server_id           = azurerm_mssql_server.datakrit_sql_server.id
  sku_name            = "S0"
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb         = 5
}

resource "azurerm_data_factory_linked_service_azure_sql_database" "sql_link" {
  name              = "sqlLinkedService"
  data_factory_id   = azurerm_data_factory.datakrit_df.id
  connection_string = "Server=tcp:${azurerm_mssql_server.datakrit_sql_server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.datakrit_sql_db.name};User ID=sqladminuser;Password=ChangeM3Now123!;Encrypt=true;Connection Timeout=30;"
}

resource "azurerm_data_factory_dataset_sql_server_table" "sql_table_dataset" {
  name                = "sqlTableDataset"
  data_factory_id     = azurerm_data_factory.datakrit_df.id
  linked_service_name = azurerm_data_factory_linked_service_azure_sql_database.sql_link.name
  table_name          = "MyTargetTable"
}
