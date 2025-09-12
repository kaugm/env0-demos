output "vm_public_ip" {
  description = "The public IP address of the Linux VM."
  value       = azurerm_public_ip.public_ip.ip_address
}

output "vm_admin_username" {
  description = "The admin username for the Linux VM."
  value       = azurerm_linux_virtual_machine.vm.admin_username
}

output "ansible_inventory_file" {
  description = "The path to the generated private key file for Ansible."
  value       = local_sensitive_file.vm_private_key_file.filename
}

output "ansible_inventory" {
  description = "Ansible inventory content for dynamic use."
  value       = <<-EOT
    [azure_vms]
    ${azurerm_public_ip.public_ip.ip_address} ansible_user=${azurerm_linux_virtual_machine.vm.admin_username} ansible_ssh_private_key_file=${local_sensitive_file.vm_private_key_file.filename}
  EOT
}