

variable "tags" {
  #type        = object
  description = "Name of the tags and their values"
  default     = {
    "createdby": "Ramakrishna",
    "department": "IT",
    "environment": "Dev"
  }
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



