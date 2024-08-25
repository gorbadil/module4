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

variable "adminpass" {
  description = "value for the admin password"
  type        = string
  sensitive   = true
  default     = "dummPass123"
}
