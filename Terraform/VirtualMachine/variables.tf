variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
  default     = "saanvikit-terraform-rg"
}

variable "location" {
  type        = string
  description = "Name of the location"
  default     = "UKSouth"
}

variable "storage_account_name" {
  type        = string
  description = "Name of the storageaccount"
  default     = "terraformsa20230228"
}

variable "tags" {
  #type        = object
  description = "Name of the tags and their values"
  default     = {
    "createdby": "Ramakrishna",
    "department": "IT",
    "environment": "Dev"
  }
}

variable "virtual_network_name" {
  type        = string
  description = "Name of the virtual network"
  default     = "terraform-vnet-01"
}

variable "virtual_network_address" {
  type        = list
  default     = ["172.16.1.0/24", "192.168.1.0/24"]
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
  default     = "terraform-snet-01"
}

variable "nsg_name" {
  type        = string
  description = "Name of the nsg"
  default     = "terraform-nsg-01"
}

variable "publicip_name" {
  type        = string
  description = "Name of the publicip"
  default     = "terraform-pubip-01"
}

variable "nic_name" {
  type        = string
  description = "Name of the nic"
  default     = "terraform-nic-01"
}

variable "vm_name" {
  type        = string
  description = "Name of the vm"
  default     = "terraform-vm-01"
}

variable "vm_size" {
  type        = string
  description = "size of the vm"
  default     = "Standard_Ds1_V2"
}

variable "adminuser" {
  type        = string
  default     = "azureuser"
}

variable "adminPassword" {
  type        = string
  default     = "Azuredevops@12345"
}

