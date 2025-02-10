data "azurerm_resource_group" "rgrp" {
  count = var.create_resource_group == false ? 1 : 0
  name  = var.resource_group_name
}

resource "azurerm_resource_group" "rg" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}




resource "azurerm_kubernetes_cluster" "aks" {
  depends_on          = [azurerm_resource_group.rg]
  count               = var.create_resource_group ? 1 : 0
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = var.default_node_pool_name
    node_count = var.default_node_pool_count
    vm_size    = var.default_node_pool_vm_size
  }

  identity {
    type = var.identity_type
  }

  tags = var.tags
}
