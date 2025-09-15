resource "azurerm_kubernetes_cluster" "aks" {
  name                = "my-terraform-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "my-terraform-aks-dns"

  default_node_pool {
    name       = "default"
    node_count = var.instance_count
    vm_size    = var.instance_size
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = "azure"
    docker_bridge_cidr = "172.17.0.1/16"
  }
}