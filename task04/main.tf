resource "azurerm_resource_group" "mod4_rg" {
  name     = var.resource_group_name
  location = "westus"
  tags     = var.tags
}

resource "azurerm_virtual_network" "mod4_vnet" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.mod4_rg.name
  location            = azurerm_resource_group.mod4_rg.location
  address_space       = ["10.0.0.0/16"]
  tags                = var.tags
}

resource "azurerm_subnet" "mod4_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.mod4_rg.name
  virtual_network_name = azurerm_virtual_network.mod4_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "mod4_pip" {
  name                = var.pip_name
  location            = azurerm_resource_group.mod4_rg.location
  resource_group_name = azurerm_resource_group.mod4_rg.name
  allocation_method   = "Dynamic"
  tags                = var.tags
}

resource "azurerm_network_security_group" "mod4_nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.mod4_rg.location
  resource_group_name = azurerm_resource_group.mod4_rg.name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "mod4_ns_rule_http" {
  name                        = var.nsg_inbound_http_rule
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.mod4_rg.name
  network_security_group_name = azurerm_network_security_group.mod4_nsg.name
}

resource "azurerm_network_security_rule" "mod4_ns_rule_ssh" {
  name                        = var.nsg_inbound_ssh_rule
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.mod4_rg.name
  network_security_group_name = azurerm_network_security_group.mod4_nsg.name
}

resource "azurerm_network_interface" "mod4_nic" {
  name                = var.nic_name
  location            = azurerm_resource_group.mod4_rg.location
  resource_group_name = azurerm_resource_group.mod4_rg.name
  ip_configuration {
    name                          = var.ip_config_name
    subnet_id                     = azurerm_subnet.mod4_subnet.id
    private_ip_address_allocation = var.ipconfig_address_allocation
    public_ip_address_id          = azurerm_public_ip.mod4_pip.id
  }
}

resource "azurerm_network_interface_security_group_association" "mod4_nic_nsg_association" {
  network_interface_id      = azurerm_network_interface.mod4_nic.id
  network_security_group_id = azurerm_network_security_group.mod4_nsg.id

}

resource "azurerm_linux_virtual_machine" "mod4_vm" {
  name                  = var.vm_name
  resource_group_name   = azurerm_resource_group.mod4_rg.name
  location              = azurerm_resource_group.mod4_rg.location
  size                  = var.vm_sku
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.mod4_nic.id]
  admin_ssh_key {
    username   = "adminuser"
    public_key = var.ssh_public_key
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = var.vm_os_version
    sku       = "minimal"
    version   = "24.04.202404230"
  }
  tags = var.tags

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
  }
  connection {
    type        = "ssh"
    user        = "adminuser"
    host        = self.public_ip_address
    private_key = var.ssh_private_key
  }
  depends_on = [azurerm_public_ip.mod4_pip]
}


