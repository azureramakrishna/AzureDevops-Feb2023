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
  client_secret   = "XYn"
  tenant_id       = "459865f1-a8aa-450a-baec-8b47a9e5c904"
  subscription_id = "6e4924ab-b00c-468f-ae01-e5d33e8786f8"
}

terraform {
backend "azurerm" {
    resource_group_name  = "cloud-shell-storage-centralindia"
    storage_account_name = "csg10032000825eeb72"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}

module "prod" {
    source = "../"

    resource_group_name = "prod-rg"
    location = "WestUS"
    storage_account_name = "saanvikitprod2023"
    virtual_network_name = "prod-vnet"
    virtual_network_address = ["192.168.0.0/24"]
    subnet_name = "prod-snet"
    subnet_address = ["192.168.0.0/24"]
    nsg_name = "prod-nsg"
    publicip_name = "prod-pubip"
    nic_name = "prod-nic"
    vm_name = "prod-vm"
    vm_size = "Standard_Ds1_v2"
    adminuser = "azureuser"
    adminPassword = "Azuredevops@12345"

}

