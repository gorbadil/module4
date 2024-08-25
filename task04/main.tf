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
  domain_name_label   = var.dns_name_label
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
  tags = var.tags
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
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDWE8FGspvo8SLPeAqzSrGTCwpHhpjhWQO3pWKNpuv6aH81pmAHJnRemYZcy78YZkhovp+aLJ6XPOvZKre8HQDsLWj69MJs4YUKeD1Wqw0ndsFapBX+m14qoI7e6YOULLBda1FhMPkmbvgyt5mJFMcbzm5xqQWcK1ycPZuij2yMEoDvtNb/mymD8cySCWk4k8McrbfeUpUWrk5FDm3qUnR60JyoPaJT1qXafQ5GX4oZkJ0+7nXa7bLvu/LRFbh5ykW9r1KtxjywlXxdTZpGlLSriW/BOdYrEvT33zXKnWBqyZhvYbA+88CXaBmHXouz9/DlyXAzzMSqH+YZ0zaHcq+nWm5b0q7uO1Tc0Xro3URdyZ3mjEU8KznAsTqNsKkZxeVubdwB7a94b84yOzwR10bKjR7F2kp5PWYuLbdY6qkHS5qvZA3G/8CXp2TstR56zh7EkPeD2lWWnqC6SxRYeb6vGM+/oPGIi102l325aB9ptTVyL/kRar4VoCnN86MVphoYUtVSdpkVOubGtK0VMr0hj3L+Fd4P353/pmieRmycWhtPOEFJd98Wo23J7t9iUZrTYC+lQsRjMFFDe+bTLAgX7GkIW0OTlNlBEsLiABb+cxU4YtR+c8M6p4mxPZ4JbOb6mR5V6E0O0BXwhUzHELUrheC2GbO9XoE3wlXA8Qdznw== adminuser"
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

  provisioner "file" {
    content     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDWE8FGspvo8SLPeAqzSrGTCwpHhpjhWQO3pWKNpuv6aH81pmAHJnRemYZcy78YZkhovp+aLJ6XPOvZKre8HQDsLWj69MJs4YUKeD1Wqw0ndsFapBX+m14qoI7e6YOULLBda1FhMPkmbvgyt5mJFMcbzm5xqQWcK1ycPZuij2yMEoDvtNb/mymD8cySCWk4k8McrbfeUpUWrk5FDm3qUnR60JyoPaJT1qXafQ5GX4oZkJ0+7nXa7bLvu/LRFbh5ykW9r1KtxjywlXxdTZpGlLSriW/BOdYrEvT33zXKnWBqyZhvYbA+88CXaBmHXouz9/DlyXAzzMSqH+YZ0zaHcq+nWm5b0q7uO1Tc0Xro3URdyZ3mjEU8KznAsTqNsKkZxeVubdwB7a94b84yOzwR10bKjR7F2kp5PWYuLbdY6qkHS5qvZA3G/8CXp2TstR56zh7EkPeD2lWWnqC6SxRYeb6vGM+/oPGIi102l325aB9ptTVyL/kRar4VoCnN86MVphoYUtVSdpkVOubGtK0VMr0hj3L+Fd4P353/pmieRmycWhtPOEFJd98Wo23J7t9iUZrTYC+lQsRjMFFDe+bTLAgX7GkIW0OTlNlBEsLiABb+cxU4YtR+c8M6p4mxPZ4JbOb6mR5V6E0O0BXwhUzHELUrheC2GbO9XoE3wlXA8Qdznw== adminuser"
    destination = "/home/adminuser/.ssh/id_rsa.pub"
  }

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
    user        = var.adminuser
    host        = self.public_ip_address
    private_key = var.ssh_private_key
    timeout     = "4m"
  }
  depends_on = [azurerm_network_interface.mod4_nic, azurerm_network_security_group.mod4_nsg, azurerm_public_ip.mod4_pip]
}
