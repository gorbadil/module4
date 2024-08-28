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

variable "vm_password" {
  description = "value for the admin password"
  type        = string
  sensitive   = true
}

variable "ip_config_name" {
  description = "IP configuration name"
  type        = string
}
variable "ipconfig_address_allocation" {
  description = "IP configuration address allocation"
  type        = string
}
variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
  sensitive   = true
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDWE8FGspvo8SLPeAqzSrGTCwpHhpjhWQO3pWKNpuv6aH81pmAHJnRemYZcy78YZkhovp+aLJ6XPOvZKre8HQDsLWj69MJs4YUKeD1Wqw0ndsFapBX+m14qoI7e6YOULLBda1FhMPkmbvgyt5mJFMcbzm5xqQWcK1ycPZuij2yMEoDvtNb/mymD8cySCWk4k8McrbfeUpUWrk5FDm3qUnR60JyoPaJT1qXafQ5GX4oZkJ0+7nXa7bLvu/LRFbh5ykW9r1KtxjywlXxdTZpGlLSriW/BOdYrEvT33zXKnWBqyZhvYbA+88CXaBmHXouz9/DlyXAzzMSqH+YZ0zaHcq+nWm5b0q7uO1Tc0Xro3URdyZ3mjEU8KznAsTqNsKkZxeVubdwB7a94b84yOzwR10bKjR7F2kp5PWYuLbdY6qkHS5qvZA3G/8CXp2TstR56zh7EkPeD2lWWnqC6SxRYeb6vGM+/oPGIi102l325aB9ptTVyL/kRar4VoCnN86MVphoYUtVSdpkVOubGtK0VMr0hj3L+Fd4P353/pmieRmycWhtPOEFJd98Wo23J7t9iUZrTYC+lQsRjMFFDe+bTLAgX7GkIW0OTlNlBEsLiABb+cxU4YtR+c8M6p4mxPZ4JbOb6mR5V6E0O0BXwhUzHELUrheC2GbO9XoE3wlXA8Qdznw== adminuser"
}
variable "ssh_private_key" {
  description = "SSH private key"
  type        = string
  sensitive   = true
  default     = <<EOF
-----BEGIN OPENSSH PRIVATE KEY-----
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
NUHTqTLwol4SIwAAAAlhZG1pbnVzZXI=
-----END OPENSSH PRIVATE KEY-----
EOF
}

variable "adminuser" {
  description = "value for the admin username"
  type        = string
  default     = "adminuser"
}

variable "ssh_key_name" {
  description = "SSH key name"
  type        = string
  default     = "mod4_ssh_key"
}
