variable "create_resource_group" {
  description = "Controla se o grupo de recursos deve ser criado (true) ou usar um existente (false)"
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "Nome do grupo de recursos"
  type        = string
}

variable "location" {
  description = "Localização do Azure onde os recursos serão criados"
  type        = string
}

variable "tags" {
  description = "Tags a serem aplicadas aos recursos"
  type        = map(string)
  default     = {}
}

variable "aks_name" {
  description = "Nome do cluster AKS"
  type        = string
}


variable "dns_prefix" {
  description = "Prefixo DNS para o cluster AKS"
  type        = string
}

variable "default_node_pool_name" {
  description = "Nome do pool de nós padrão"
  type        = string
}

variable "default_node_pool_count" {
  description = "Número de nós no pool padrão"
  type        = number
}

variable "default_node_pool_vm_size" {
  description = "Tamanho da VM do pool padrão"
  type        = string
}

variable "identity_type" {
  description = "Tipo de identidade do cluster AKS"
  type        = string
}
