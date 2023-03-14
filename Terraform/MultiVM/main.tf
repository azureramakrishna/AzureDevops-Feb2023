terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.10.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

# Azure Terraform backend state
terraform {
  backend "azurerm" {
    resource_group_name  = "cloud-shell-storage-centralindia"
    storage_account_name = "csg1003200202aa28c5"
    container_name       = "tfstate"
    key                  = "vm.terraform.tfstate"
  }
}

# Create a resource group
# resource "azurerm_resource_group" "rg" {
#   name     = var.resource_group_name_01
#   location = var.location
# }

# Access the existing resource group
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name_01
}

# Create a storage account
resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = ["172.16.0.0/24","192.168.0.0/24"]
}

# Create a subnet
resource "azurerm_subnet" "snet" {
  name                 = var.snet_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["172.16.0.0/27"]
}

# Create a publicip
resource "azurerm_public_ip" "pubip" {
  name                = "${var.public_ip_name}${count.index}"
  count               = var.count_value
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"
}

# Create a network security group
resource "azurerm_network_security_group" "nsg" {
  name                = var.network_security_group_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  security_rule {
    name                       = "RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


# Create a network interface
resource "azurerm_network_interface" "nic" {
  name                = "${var.network_interface_name}${count.index}"
  count               = var.count_value
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.snet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = "${azurerm_public_ip.pubip[count.index].id}"
  }
}

# Associate NSG with NIC
resource "azurerm_network_interface_security_group_association" "nsg-nic" {
  network_interface_id      = "${azurerm_network_interface.nic[count.index].id}"
  network_security_group_id = azurerm_network_security_group.nsg.id
  count                     = var.count_value
}

# Access information about an existing Key Vault.
data "azurerm_key_vault" "kv" {
  name                = var.keyvault
  resource_group_name = var.keyvault_rg
}

#access information about an existing Key Vault Secret
data "azurerm_key_vault_secret" "kvsecret" {
  name         = var.secret_name
  key_vault_id = data.azurerm_key_vault.kv.id
}

# Create a virtual machine
resource "azurerm_windows_virtual_machine" "vm" {
  name                = "${var.virtual_machine_name}${count.index}"
  count               = var.count_value
  resource_group_name = data.azurerm_resource_group.rg.name
  computer_name       = "JEWEB26000${count.index}"
  location            = data.azurerm_resource_group.rg.location
  size                = var.virtual_machine_size
  admin_username      = var.adminuser
  admin_password      = data.azurerm_key_vault_secret.kvsecret.value
  network_interface_ids = [
    "${azurerm_network_interface.nic[count.index].id}"
  ]

  os_disk {
    name                 = "${var.virtual_machine_name}-osdisk-${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}