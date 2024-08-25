# Resource group name: cmaz-945e234b-mod4-rg
# VNet name: cmaz-945e234b-mod4-vnet
# Subnet name: frontend
# Network interface name: cmaz-945e234b-mod4-nic
# NSG Name: cmaz-945e234b-mod4-nsg
# NSG inbound HTTP rule: AllowHTTP
# NSG inbound SSH rule: AllowSSH
# Public IP name: cmaz-945e234b-mod4-pip
# DNS name label: cmaz-945e234b-mod4-nginx
# VM name: cmaz-945e234b-mod4-vm
# VM OS Version ubuntu-24_04-lts
# VM SKU: Standard_F2s_v2
# Tags: Creator = ersin_mutlu@epam.com
variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}
variable "vnet_name" {
  description = "VNet name"
  type        = string
}
variable "subnet_name" {
  description = "Subnet name"
  type        = string
}
variable "nic_name" {
  description = "Network interface name"
  type        = string
}
variable "nsg_name" {
  description = "NSG Name"
  type        = string
}
variable "nsg_inbound_http_rule" {
  description = "NSG inbound HTTP rule"
  type        = string
}
variable "nsg_inbound_ssh_rule" {
  description = "NSG inbound SSH rule"
  type        = string
}
variable "pip_name" {
  description = "Public IP name"
  type        = string
}
variable "dns_name_label" {
  description = "DNS name label"
  type        = string
}
variable "vm_name" {
  description = "VM name"
  type        = string
}
variable "vm_os_version" {
  description = "VM OS Version"
  type        = string
}
variable "vm_sku" {
  description = "VM SKU"
  type        = string
}
variable "tags" {
  description = "Tags"
  type        = map(string)
}
