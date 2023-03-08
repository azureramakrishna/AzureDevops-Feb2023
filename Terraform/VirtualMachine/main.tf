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
  }

  terraform {
    backend "azurerm" {
      resource_group_name  = "cloud-shell-storage-centralindia"
      storage_account_name = "csg10032000825eeb72"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
    }
  }


  # Create a resource group
  resource "azurerm_resource_group" "rg" {
    name     = var.resource_group_name
    location = var.location
  }



  # Create a storage account
  resource "azurerm_storage_account" "example" {
    name                     = var.storage_account_name
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = azurerm_resource_group.rg.location
    account_tier             = "Standard"
    account_replication_type = "GRS"
    tags = var.tags
  }

# create a virtual network
resource "azurerm_virtual_network" "example" {
  name                = var.virtual_network_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.virtual_network_address
  tags = var.tags
}

resource "azurerm_subnet" "example" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["172.16.1.0/24"]
}

# Create a NSG
resource "azurerm_network_security_group" "example" {
  name                = var.nsg_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

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

  tags = var.tags
}

# Associates a Network Security Group with a Subnet within a Virtual Network.
resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.example.id
  network_security_group_id = azurerm_network_security_group.example.id
}

# Create a Public IP
resource "azurerm_public_ip" "example" {
  name                = var.publicip_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"

  tags = var.tags
}

# Create a NIC
resource "azurerm_network_interface" "example" {
  depends_on = [
    azurerm_public_ip.example
  ]
  name                = var.nic_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

# Create a Windows Virtual Machine
resource "azurerm_windows_virtual_machine" "example" {
  depends_on = [
    azurerm_network_interface.example
  ]
  name                = var.vm_name
  computer_name       = "UKSDEV253030"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vm_size
  admin_username      = var.adminuser
  admin_password      = var.adminPassword
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  os_disk {
    name                 = "${var.vm_name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}
