variable "tags" {
  #type        = object
  description = "Name of the tags and their values"
  default     = {
    "createdby": "Ramakrishna",
    "department": "IT",
    "environment": "Dev"
  }
}

variable "rg-name" {
  default     = "dev-resourcegroup"
}

