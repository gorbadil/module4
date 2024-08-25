resource_group_name   = "cmaz-945e234b-mod4-rg"
vnet_name             = "cmaz-945e234b-mod4-vnet"
subnet_name           = "frontend"
nic_name              = "cmaz-945e234b-mod4-nic"
nsg_name              = "cmaz-945e234b-mod4-nsg"
nsg_inbound_http_rule = "AllowHTTP"
nsg_inbound_ssh_rule  = "AllowSSH"
pip_name              = "cmaz-945e234b-mod4-pip"
dns_name_label        = "cmaz-945e234b-mod4-nginx"
vm_name               = "cmaz-945e234b-mod4-vm"
vm_os_version         = "ubuntu-24_04-lts"
vm_sku                = "Standard_F2s_v2"
tags = {
  Creator = "ersin_mutlu@epam.com"
}
ip_config_name              = "internal"
ipconfig_address_allocation = "Dynamic"

