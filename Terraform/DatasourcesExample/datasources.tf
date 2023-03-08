# Use the existing resource group
data "azurerm_resource_group" "example" {
  name = var.resource_group_name
}

# Use the existing virtual network
data "azurerm_virtual_network" "example" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
}

# Use the existing subnet
data "azurerm_subnet" "example" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_key_vault" "example" {
  name                = "saanvikitkv2023"
  resource_group_name = "cloud-shell-storage-centralindia"
}

data "azurerm_key_vault_secret" "example" {
  name         = "WinVMPassword"
  key_vault_id = data.azurerm_key_vault.example.id
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
  default     = "terraform-datasources-rg"
}

variable "virtual_network_name" {
  type        = string
  description = "Name of the virtual network"
  default     = "terraform-vnet-01"
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
  default     = "default"
}