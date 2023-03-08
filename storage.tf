 # Create a resource group
  resource "azurerm_resource_group" "rg1" {
    name     = var.resource_group_name_01
    location = var.location
  }


  # Create a storage account
  resource "azurerm_storage_account" "example" {
    name                     = "${lower(var.storage_account_name)}saanikit${count.index+1}"
    count                    = var.count_value
    resource_group_name      = azurerm_resource_group.rg1.name
    location                 = azurerm_resource_group.rg1.location
    account_tier             = "Standard"
    account_replication_type = "GRS"
  }
