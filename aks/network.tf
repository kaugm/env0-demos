# Create an Azure Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "my-aks-cluster-rg"
  location = "East US"
}

# Create a virtual network
resource "azurerm_3_1_0_virtual_network" "vnet" {
  name                = "my-aks-vnet"
  address_space       = ["10.17.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create a subnet within the virtual network
resource "azurerm_subnet" "subnet" {
  name                 = "my-aks-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_3_1_0_virtual_network.vnet.name
  address_prefixes     = ["10.17.1.0/24"]
}