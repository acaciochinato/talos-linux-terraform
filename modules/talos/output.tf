output "cluster_host" {
  value = talos_cluster_kubeconfig.kubeconfig.kubernetes_client_configuration.host
}
output "cluster_ca_certificate" {
  value = talos_cluster_kubeconfig.kubeconfig.kubernetes_client_configuration.ca_certificate
}
output "cluster_client_certificate" {
  value = talos_cluster_kubeconfig.kubeconfig.kubernetes_client_configuration.client_certificate
}
output "cluster_client_key" {
  value = talos_cluster_kubeconfig.kubeconfig.kubernetes_client_configuration.client_key
}
