variable "server_name" {
  description = "The server_name used for the label"
  type        = string
  validation {
    condition     = length(var.server_name) > 0
    error_message = "The server_name value must be a non empty string."
  }
}

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

variable "admin_username" {
  description = "The admin_username to access the server"
  type        = string
  validation {
    condition     = length(var.admin_username) > 0
    error_message = "The admin_username value must be a non empty string."
  }
}

variable "admin_password" {
  description = "The admin_password to access the server"
  type        = string
  validation {
    condition     = length(var.admin_password) > 0
    error_message = "The admin_password value must be a non empty string."
  }
}

variable "size" {
  description = "The OS disk size"
  type        = string
  validation {
    condition     = length(var.size) > 0
    error_message = "The size value must be a non empty string."
  }
}

variable "caching" {
  description = "The caching type: Read/Write/ReadWrite"
  type        = string
  validation {
    condition     = length(var.caching) > 0
    error_message = "The caching value must be a non empty string."
  }
}

variable "storage_account_type" {
  description = "The storage type: SSD, HDD, Standard_LRS"
  type        = string
  validation {
    condition     = length(var.storage_account_type) > 0
    error_message = "The storage_account_type value must be a non empty string."
  }
}

variable "network_security_group_id" {
  description = "The network_security_group_id of all the servers"
  type = string
}

variable "amount" {
  description = "The amount of servers"
  type = number
}

variable "virtual_network_name" {
  description = "The virtual_network_name of all the servers"
  type = string
}
