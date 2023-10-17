resource "azurerm_storage_account" "default" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "default" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.default.name
  container_access_type = "private"
}

resource "azurerm_network_security_group" "storage" {
  name                = "storage-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Create an outbound rule to allow access to the storage container
resource "azurerm_network_security_rule" "allow-storage" {
  name                        = "Allow-Storage"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "10.0.1.0/24"
  resource_group_name         = var.resource_group_name
  description                 = "Allow Storage"
  network_security_group_name = azurerm_network_security_group.storage.name
}

