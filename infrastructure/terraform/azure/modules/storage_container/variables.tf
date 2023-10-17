variable "resource_group_name" {
  description = "The Resource Group Name on Azure"
  type        = string
  validation {
    condition     = length(var.resource_group_name) > 0
    error_message = "The resource_group_name value must be a non empty string."
  }
}

variable "location" {
  description = "The location on Azure"
  type        = string
  validation {
    condition     = length(var.location) > 0
    error_message = "The location value must be a non empty string."
  }
}

variable "storage_account_name" {
  description = "The storage_account_name on Azure"
  type        = string
  validation {
    condition     = length(var.storage_account_name) > 0
    error_message = "The storage_account_name value must be a non empty string."
  }
}

variable "storage_container_name" {
  description = "The storage_container_name on Azure"
  type        = string
  validation {
    condition     = length(var.storage_container_name) > 0
    error_message = "The storage_container_name value must be a non empty string."
  }
}
