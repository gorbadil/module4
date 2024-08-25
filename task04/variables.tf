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
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC34JPW7xC+FdMv/JuwplHycGcarfxJeuUKDMugn9u3qJpaCN81Lo8BCNyPqZbjqToU+KnFXuV1w/bRQtO1lWskk0zCHx+CdP9pc1CZyXzcCFydbEU8B/9bTa21bEjqr9bVU+MvFIsK7iOfWwQYqhE0L2XhvdI176Ld3mfENGJEKfemYZXV6qx1Md9SIfm6IzIwwpqv79VfB6XEzz8CeyJDBVUXTF/c897ZK3EJVX8rX6cRioPEacR+R/kE+iqLu+nni46gSQq6uy58Zhuf4I5dQbUFxC1pHRcRww+Q3QxbT8K8rHkDxY8rFffcdcU3bsBcr49dglI165kmrA9iKt/uS2vKz1bZcKvO/DrE8f2BdRk1Qbav9/t16YZtAQWkmUUOkWJBVYbDYiMC5v6LLi0ZAO53Tl1ohklQH/BCL3viF8a1QA7jHR2JPWeQopOO0UVO+yzt75T3AD3zbNJElbhHmSra47ItSObMQVb5mhYpVIvpiiwRtbvUGNtjTWYBPCFm1nwnTjuZiIn3/ZlJ3wruaKBletpJtMjvqQmDGqWKYN1O/BF/orsE/QhmXKJyULa118CCFLr2BjmYaXL/P1CV0voMP4YRFQF7Jn0QpNA4MlQCaFTRk2DXRh7Nh+ZxW4i5r5rY3OWqJNpv4OR9U+PuVgp3w/4DhBgwe1e4oTkzKQ== ersin_mutlu@epam.com"
}
variable "ssh_private_key" {
  description = "SSH private key"
  type        = string
  default     = <<EOF
-----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----
EOF

}
