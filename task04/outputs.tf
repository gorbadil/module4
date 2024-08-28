output "vm_public_ip" {
  description = "The public IP address of the VM"
  value       = azurerm_public_ip.mod4_pip.ip_address
}

output "vm_fqdn" {
  description = "The fully qualified domain name of the VM"
  value       = azurerm_linux_virtual_machine.mod4_vm.vm_public_ip_address
}
