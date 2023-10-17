resource "azurerm_public_ip" "this" {
  count = var.amount
  name                = "${var.server_name}-public-ip-${count.index}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"

  tags = {
    environment = "${var.server_name}-public-ip-${count.index}"
  }
}

resource "azurerm_subnet" "this" {
  name                 = "general-internal-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "main" {
  count = var.amount
  name                = "${var.server_name}-nic-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "${var.server_name}-network-interface-${count.index}"
    subnet_id                     = azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this[count.index].id
  }
  lifecycle {
    create_before_destroy = true
  }
}


resource "azurerm_linux_virtual_machine" "vm" {
  count = var.amount
  name                            = "${var.server_name}-vm-${count.index}"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  network_interface_ids           = [azurerm_network_interface.main[count.index].id]
  disable_password_authentication = false
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  size                            = var.size
  os_disk {
    name                 = "${var.server_name}-disk-${count.index}"
    caching              = var.caching
    storage_account_type = var.storage_account_type
  }
  tags = {
    name = var.server_name
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

resource "azurerm_network_interface_security_group_association" "main" {
  count = var.amount
  network_interface_id      = azurerm_network_interface.main[count.index].id
  network_security_group_id = var.network_security_group_id
}
