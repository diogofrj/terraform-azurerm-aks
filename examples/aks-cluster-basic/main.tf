module "labels" {
  source      = "git::https://github.com/diogofrj/terraform-template-modules.git//examples/azure/labels?ref=v0.0.1"
  project     = "module-aks"
  environment = "dev"
  region      = "eastus2"
}


module "aks" {
  source = "../../"
  # Resource Group
  create_resource_group     = true
  resource_group_name       = module.labels.resource_group_name
  location                  = "eastus2"
  aks_name                  = module.labels.aks_name
  dns_prefix                = trim(module.labels.aks_name, "-")
  default_node_pool_name    = "default"
  default_node_pool_count   = 1
  default_node_pool_vm_size = "Standard_DS2_v2"
  identity_type             = "SystemAssigned"

  tags = {
    "project"     = "module-aks"
    "environment" = "dev"
  }
}
