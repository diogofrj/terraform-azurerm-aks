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
  count               = var.create_resource_group ? 1 : 0
  name                = var.cluster_config.name
  location            = var.cluster_config.location
  resource_group_name = var.cluster_config.resource_group_name
  kubernetes_version  = var.cluster_config.kubernetes_version
  node_resource_group = var.cluster_config.node_resource_group

  dns_prefix_private_cluster          = lower("${var.cluster_config.name}")
  private_cluster_enabled             = var.cluster_config.private_cluster_config.enabled
  private_dns_zone_id                 = var.cluster_config.private_cluster_config.private_dns_zone_id
  private_cluster_public_fqdn_enabled = false

  network_profile {
    network_plugin    = var.cluster_config.network_profile.network_plugin
    network_policy    = var.cluster_config.network_profile.network_policy
    load_balancer_sku = var.cluster_config.network_profile.load_balancer_sku
    outbound_type     = var.cluster_config.network_profile.outbound_type
  }

  default_node_pool {
    name                         = var.cluster_config.system_node_pool.name
    vm_size                      = var.cluster_config.system_node_pool.vm_size
    node_count                   = var.cluster_config.system_node_pool.node_count
    zones                        = var.cluster_config.system_node_pool.zones
    auto_scaling_enabled         = var.cluster_config.system_node_pool.auto_scaling_enabled
    min_count                    = var.cluster_config.system_node_pool.min_count
    max_count                    = var.cluster_config.system_node_pool.max_count
    os_disk_size_gb              = var.cluster_config.system_node_pool.os_disk_size_gb
    os_sku                       = var.cluster_config.system_node_pool.os_sku
    vnet_subnet_id               = var.cluster_config.subnet_id
    only_critical_addons_enabled = var.cluster_config.system_node_pool.only_critical_addons_enabled
    temporary_name_for_rotation  = "tempnpsystem"
  }

  identity {
    type         = var.cluster_config.identity.type
    identity_ids = var.cluster_config.identity.identity_ids
  }

  oms_agent {
    log_analytics_workspace_id = var.cluster_config.log_analytics_id
  }

  key_vault_secrets_provider {
    secret_rotation_enabled  = var.cluster_config.key_vault_config.enable_secret_rotation
    secret_rotation_interval = var.cluster_config.key_vault_config.rotation_poll_interval
  }

  tags = var.tags
}
