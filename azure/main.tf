# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# 1. Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "my-terraform-rg"
  location = "East US"
}

# 2. Create a virtual network (VNet)
resource "azurerm_virtual_network" "vnet" {
  name                = "my-terraform-vnet"
  address_space       = ["10.16.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# 2. Create a subnet
resource "azurerm_subnet" "subnet" {
  name                 = "my-terraform-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.16.1.0/24"]
}

# 3. Create a public IP address for the VM
resource "azurerm_public_ip" "public_ip" {
  name                = "my-terraform-public-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"
}

# 3. Create a network interface for the VM
resource "azurerm_network_interface" "nic" {
  name                = "my-terraform-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

# 3. Create a virtual machine (VM)
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "my-terraform-vm"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_B1s"
  admin_username      = "ubuntu"
  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  # Attached storage (data disk)
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "ubuntu"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDS+PXjCRk0tl3hm5dQiTRtn/OkacHncyGDInYR/RX+AB77VA3gVzdQXGkl1P2NREatFSe9TYV5W2+Q48YUe3lG0UkTYr3E3PPF4jxxyz4mXddrX7ZjYciBkptrLykxeGrmrJtcrv9CjBZUYHIT2wLjww1U2Z91oGAqVMw9c6wFtTXBQlYNh8Xv3mIi5VNpa9FVucaC/gQK80LOWPUHNzVRTa9qYVxq/NWZE7M4A0ichtdpW4qe6UqUcpOYzKyimGoWT0xXdDNDIWxdkgCl/V8fkA3c9pOPQA69RXBcPdK0oc5VuyGeCER1zllKm87xYRd6IaFgJe1gPNpFNzjYHIwAPysDXNVc0QtA6dpNQ55LjCACHjYswBX9A4vQwXxbSDN+Ev+rEu0nWFlXdXk5wPbzJxTHlzeem0qeUcf/wGTLO6Agi8FCJUnMUtktFzkhxHCLlEcVYVPJirD568540Kbx882DNSiGQ41oP+QLkpjHjNwy48HoVrsrLD9SSGRzgb1dZfLM/E4ct8crCPokGkKzq7e5ahXQfLhlf5D0xNDv7GhLZFKSdroqxwYto+v/5DZq0KQ5ODEMw9mADNCIYhS7lBo1c0NIGVrC/gCzuqNEOzJO7CD0luhrm70ZxhZqDp78khpcjjGNcF/Mc1weHXmGLkudt1Q0T4nSODcV4AEvxQ== karl.martin@env0.com"
  }
}

# 3. Create a managed disk and attach it to the VM
resource "azurerm_managed_disk" "data_disk" {
  name                 = "my-terraform-data-disk"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}

# 3. Attach the managed disk to the VM
resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attachment" {
  managed_disk_id      = azurerm_managed_disk.data_disk.id
  virtual_machine_id   = azurerm_linux_virtual_machine.vm.id
  lun                  = 10
  caching              = "ReadWrite"
}

# Output the public IP address of the VM
output "public_ip_address" {
  value = azurerm_public_ip.public_ip.ip_address
}