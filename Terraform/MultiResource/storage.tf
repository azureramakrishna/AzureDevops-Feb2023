  terraform {
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = "3.45.0"
      }
    }
  }

  provider "azurerm" {
    features {}

  client_id       = var.client_id
  client_secret   = var.secret_value
  tenant_id       = var.tenannt_id
  subscription_id = var.subscription_id
}

  terraform {
    backend "azurerm" {
      resource_group_name  = "cloud-shell-storage-centralindia"
      storage_account_name = "csg10032000825eeb72"
      container_name       = "tfstate"
      key                  = "multisa.terraform.tfstate"
    }
  }


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