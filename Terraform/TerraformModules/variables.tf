variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Name of the location"
}

variable "storage_account_name" {
  type        = string
  description = "Name of the storageaccount"
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
}

variable "virtual_network_address" {
  type        = list
}

variable "subnet_address" {
  type        = list
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
}

variable "nsg_name" {
  type        = string
  description = "Name of the nsg"
}

variable "publicip_name" {
  type        = string
  description = "Name of the publicip"
}

variable "nic_name" {
  type        = string
  description = "Name of the nic"
}

variable "vm_name" {
  type        = string
  description = "Name of the vm"
}

variable "vm_size" {
  type        = string
  description = "size of the vm"
}

variable "adminuser" {
  type        = string
}

variable "adminPassword" {
  type        = string
}

