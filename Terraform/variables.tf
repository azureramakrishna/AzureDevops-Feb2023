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
