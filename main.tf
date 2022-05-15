data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "example" {
  name     = "tfsec-example-resources"
  location = "Japan East"
}

resource "azurerm_storage_account" "example" {
  name                     = "stprtexp0515"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "example" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

resource "azurerm_key_vault" "example" {
  name                = "kv-prt-exp-0515"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "Delete"
    ]

    storage_permissions = [
      "Get",
      "List",
      "Set",
      "SetSAS",
      "GetSAS",
      "DeleteSAS",
      "Update",
      "RegenerateKey"
    ]
  }
}