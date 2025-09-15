output "vm_public_ip" {
  description = "The public IP address of the Linux VM."
  value       = azurerm_public_ip.public_ip.ip_address
}

output "vm_admin_username" {
  description = "The admin username for the Linux VM."
  value       = azurerm_linux_virtual_machine.vm.admin_username
}

output "private_key" {
  description = "The generated private key for the VM."
  value       = tls_private_key.vm_ssh_key.private_key_pem
  # sensitive   = true
}