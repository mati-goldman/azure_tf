resource "azurerm_virtual_network" "this" {
  name                = "general-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_group" "main" {
  name                = "general-security-group"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "ssh_access" {
  name                        = "Allow-SSH-Access"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefixes     = var.allowed_ips
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  description                 = "Allow SSH Access"
  network_security_group_name = azurerm_network_security_group.main.name
}

resource "azurerm_network_security_rule" "allow-outbound-subnet" {
  name                        = "allow-same-subnet-connectivty-outbound"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "10.0.2.0/24"
  resource_group_name         = var.resource_group_name
  description                 = "Allow Outbound Access to servers on the same subnet"
  network_security_group_name = azurerm_network_security_group.main.name
}

resource "azurerm_network_security_rule" "allow-inbound-subnet" {
  name                        = "allow-same-subnet-connectivty-inbound"
  priority                    = 300
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "10.0.2.0/24"
  resource_group_name         = var.resource_group_name
  description                 = "Allow Inbound Access to servers on the same subnet"
  network_security_group_name = azurerm_network_security_group.main.name
}

resource "azurerm_network_security_rule" "deny-outbound-access" {
  name                        = "Deny-Outbound-Access"
  priority                    = 200
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  description                 = "Deny Outbound Access"
  network_security_group_name = azurerm_network_security_group.main.name
}
