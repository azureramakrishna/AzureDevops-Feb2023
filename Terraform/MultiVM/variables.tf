variable "subscription_id" {
  type        = string
}

variable "client_id" {
  type        = string
}

variable "client_secret" {
  type        = string  
}

variable "tenant_id" {
  type        = string
}


variable "resource_group_name_01" {
  type        = string
  description = "Name of the resource group 01"
  default     = "terraform-vm-rg"
}

variable "count_value" {
  type        = number
  default     = 4
}

# variable "location" {
#   type        = string
#   description = "location for the deployment"
#   default     = "Japan East"
# }


variable "storage_account_name" {
  type        = string
  description = "Name of the storage account"
  default     = "terraformsa20220621"
}

variable "vnet_name" {
  type        = string
  description = "Name of the virtual network"
  default     = "terraform-vnet-01"
}

variable "snet_name" {
  type        = string
  description = "Name of the subne"
  default     = "terraform-snet-01"
}

variable "public_ip_name" {
  type        = string
  description = "Name of the publicip"
  default     = "terraform-pubip-01"
}

variable "network_security_group_name" {
  type        = string
  default     = "terraform-nsg-01"
}

variable "network_interface_name" {
  type        = string
  default     = "terraform-nic-01"
}

variable "linux_network_interface_name" {
  type        = string
  default     = "terraform-linux-nic-01"
}

variable "virtual_machine_name" {
  type        = string
  default     = "terraform-windows-vm-01"
}

variable "Linux_virtual_machine_name" {
  type        = string
  default     = "terraform-linux-vm-01"
}

variable "virtual_machine_size" {
  type        = string
  default     = "Standard_DS1_v2"
}

variable "adminuser" {
  type        = string
  default     = "azureuser"
}

# variable "adminpassword" {
#   type        = string
#   default     = "P@$$word@12345"
# }

variable "tags" {
  type = map
  default    = {
    createdby  = "azureramakrishna@gmail.com"
    Project    = "SAANVIKIT"
    Department = "IT"
  }
}

variable "keyvault" {
  type        = string
  default     = "kv20220618"
}

variable "keyvault_rg" {
  type        = string
  default     = "test-kv-rg"
}

variable "secret_name" {
  type        = string
  default     = "WinVMPassword"
}