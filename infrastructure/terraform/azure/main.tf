terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.46.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

module "container" {
  source                 = "./modules/storage_container"
  resource_group_name    = var.resource_group_name
  location               = var.location
  storage_account_name   = var.storage_account_name
  storage_container_name = var.storage_container_name
}


module "server" {
  source               = "./modules/server"
  server_name          = var.server_name
  resource_group_name  = var.resource_group_name
  location             = var.location
  admin_password       = var.admin_password
  admin_username       = var.admin_username
  caching              = var.caching
  size                 = var.size
  amount = var.amount
  storage_account_type = var.storage_account_type
  network_security_group_id = module.network.azurerm_network_security_group_id
  virtual_network_name = module.network.azurerm_virtual_network_name
  depends_on = [module.network]
}



module "network" {
  source               = "./modules/network"
  resource_group_name  = var.resource_group_name
  location             = var.location
  allowed_ips          = var.allowed_ips
}


