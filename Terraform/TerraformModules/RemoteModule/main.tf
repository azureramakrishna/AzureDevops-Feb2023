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

  client_id       = "ce1425fc-f3d9-4afa-a1df-9786245f41fc"
  client_secret   = ""
  tenant_id       = "459865f1-a8aa-450a-baec-8b47a9e5c904"
  subscription_id = "6e4924ab-b00c-468f-ae01-e5d33e8786f8"
}

terraform {
backend "azurerm" {
    resource_group_name  = "cloud-shell-storage-centralindia"
    storage_account_name = "csg10032000825eeb72"
    container_name       = "tfstate"
    key                  = "remotemodule.terraform.tfstate"
  }
}

module "remotemodule" {
  source = "git::https://github.com/azureramakrishna/AzureDevops-Feb2023.git"

  resource_group_name_01 = "remote-module-rg"
  location = "Eastus2"
  storage_account_name = "Remote"
  count_value = 20
}