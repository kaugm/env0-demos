# Configure the Azure provider
terraform {
  required_version = ">= 1.0.0"
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



# Generates the private key.
resource "tls_private_key" "vm_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Writes the private key to a local file.
resource "local_sensitive_file" "vm_private_key_file" {
  filename          = "${path.module}/vm_ssh_key.pem"
  content = tls_private_key.vm_ssh_key.private_key_pem
  file_permission   = "0600"
}



# 1. Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "Karl-demo-fiserv"
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



# Security Group
resource "azurerm_network_security_group" "nsg" {
  name                = "Ansible-sg-demo"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_rule" "ssh_rule" {
  name                        = "allow_ssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_interface_security_group_association" "nic_nsg_association" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}



# 3. Create a virtual machine (VM)
resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = var.vm_size
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
    public_key = tls_private_key.vm_ssh_key.public_key_openssh
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
  managed_disk_id    = azurerm_managed_disk.data_disk.id
  virtual_machine_id = azurerm_linux_virtual_machine.vm.id
  lun                = 10
  caching            = "ReadWrite"
}