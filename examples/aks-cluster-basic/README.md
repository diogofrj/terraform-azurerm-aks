<!-- BEGIN_TF_DOCS -->
<!-- Título do Módulo -->
# 🌐 Terraform AzureRM - Virtual Network

![Banner](../../docs/images/Module-banner.png)

# Como utilizar este módulo

```hcl
# providers.tf
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
```

```hcl
# versions.tf
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.17.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }
  }
  required_version = ">= 1.10.0"
}
```

```hcl
# main.tf
module "labels" {
  source       = "git::https://github.com/diogofrj/templates-tf-modules.git//examples/azure/labels?ref=v0.0.1"
  project      = "myapp"
  environment  = "dev"
  region       = "eastus2"
}


module "aks" {
  source = "../../"
  # Resource Group
  create_resource_group = true
  resource_group_name   = module.labels.resource_group_name
  location              = "eastus2"
  aks_name              = module.labels.aks_name
  dns_prefix            = trim(module.labels.aks_name, "-")
  default_node_pool_name = "default"
  default_node_pool_count = 1
  default_node_pool_vm_size = "Standard_DS2_v2"
  identity_type = "SystemAssigned"

  tags = {
    "project"     = "module-aks"
    "environment" = "dev"

  }
}
```
```hcl
# outputs.tf
output "client_certificate" {
  value     = module.aks.client_certificate
  sensitive = true
}

output "kube_config" {
  value     = module.aks.kube_config
  sensitive = true
}

output "aks_name" {
  value = module.aks.aks_name
}
```

<h2 align="left">Contatos:</h2>
<p align="left">
    <a href="https://linkedin.com/in/diogofernandesrj" target="blank"><img align="center" src="https://raw.githubusercontent.com/diogofrj/misc/main/images/Social/linked-in-alt.svg" alt="diogofernandesrj" height="30" width="40" /></a>
    <a href="mailto:dfs@outlook.com.br" target="blank"><img align="center" src="https://img.icons8.com/?size=48&id=OumT4lIcOllS&format=png" alt="dfs@outlook.com.br" height="30" width="40" /></a>
</p>

Obrigado por utilizar este módulo de Terraform! Se tiver alguma dúvida ou sugestão, não hesite em entrar em contato.

[🔝 Voltar ao topo](#footer)
<!-- END_TF_DOCS -->
