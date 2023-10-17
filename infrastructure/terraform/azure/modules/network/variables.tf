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

variable "allowed_ips" {
  description = "The allowed ips for inbound SSH"
  type = list
  validation {
    condition     = length(var.allowed_ips) > 0
    error_message = "The allowed_ips value must be a non empty string."
  }
}
