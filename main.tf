terraform {
  required_version = ">=1.14.6"

  cloud {
    
    organization = "nagateja-test-org"

    workspaces {
      name = "azure_testing"
    }
  }
}

provider "azurerm" {
  features{}
}


resource "azurerm_resource_group" "this" {
  name     = "rg-blob-policy-test"
  location = "East US"
}

resource "azurerm_storage_account" "this" {
  name                     = "stblobpolicytest001"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false
}

resource "azurerm_storage_container" "this" {
  name                  = "test"
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = "private"
}

