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

resource "random_pet" "ssh_key_name" {
  length    = 2
  separator = ""
}

resource "azapi_resource_action" "ssh_public_key_gen" {
  type                   = "Microft.Compute/sshPublicKeys@2022-11-01"
  resource_id            = azapi_resource.ssh_public_key.id
  action                 = "generateKeyPair"
  method                 = "POST"
  response_export_values = ["publicKey", "privateKey"]
}

resource "azapi_resource" "ssh_public_key" {
  type      = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  name      = random_pet.ssh_key_name.id
  location  = azurerm_resource_group.mod4_rg.location
  parent_id = azurerm_resource_group.mod4_rg.id
}

output "key_data" {
  value = azapi_resource_action.ssh_public_key_gen.output.publicKey
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
  allocation_method   = "Static"
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
    public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey
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
    user        = var.adminuser
    host        = self.public_ip_address
    private_key = azapi_resource_action.ssh_public_key_gen.output.private_key
  }
  depends_on = [azurerm_network_interface.mod4_nic, azurerm_network_security_group.mod4_nsg, azurerm_public_ip.mod4_pip]
}
