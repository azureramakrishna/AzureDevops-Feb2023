
variable "client_id" {
  type        = string
}

variable "tenannt_id" {
  type        = string
}

variable "secret_value" {
  type        = string
}

variable "subscription_id" {
  type        = string
}

variable "resource_group_name_01" {
  type        = string
  description = "Name of the resource group"
  default     = "saanvikit-terraform-rg-01"
}

variable "resource_group_name_02" {
  type        = string
  description = "Name of the resource group"
  default     = "saanvikit-terraform-rg-02"
}

variable "location" {
  type        = string
  description = "Name of the location"
  default     = "UKSouth"
}

variable "storage_account_name" {
  type        = string
  description = "Name of the storageaccount"
  default     = "TERRAFORM"
}

variable "count_value" {
  type        = number
  default     = 5
}