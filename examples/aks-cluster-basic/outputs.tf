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
