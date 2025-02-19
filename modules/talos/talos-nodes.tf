resource "talos_machine_secrets" "machine_secrets" {}
data "talos_machine_configuration" "controlplane" {
  cluster_name     = var.cluster_name
  cluster_endpoint = var.cluster_endpoint
  machine_type     = "controlplane"
  machine_secrets  = talos_machine_secrets.machine_secrets.machine_secrets
  config_patches = [
    templatefile("${path.module}/templates/control-plane-default.yaml.tmpl", {
      vip        = var.vip
      ntp_server = var.ntp_server
    })
  ]
}
data "talos_machine_configuration" "worker" {
  cluster_name     = var.cluster_name
  cluster_endpoint = var.cluster_endpoint
  machine_type     = "worker"
  machine_secrets  = talos_machine_secrets.machine_secrets.machine_secrets
  config_patches = [
    templatefile("${path.module}/templates/worker-default.yaml.tmpl", {
      ntp_server = var.ntp_server
    })
  ]
}
data "talos_client_configuration" "talosconfig" {
  cluster_name         = var.cluster_name
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  nodes                = [for node in var.controlplane_ips : node]
}
resource "talos_machine_configuration_apply" "controlplane_config_apply" {
  client_configuration        = talos_machine_secrets.machine_secrets.client_configuration
  machine_configuration_input = data.talos_machine_configuration.controlplane.machine_configuration
  for_each                    = toset(var.controlplane_ips)
  node                        = each.key
}
resource "talos_machine_configuration_apply" "workers_config_apply" {
  client_configuration        = talos_machine_secrets.machine_secrets.client_configuration
  machine_configuration_input = data.talos_machine_configuration.worker.machine_configuration
  for_each                    = toset(var.workers_ips)
  node                        = each.key
}
resource "talos_machine_configuration_apply" "worker_longhorn_config_apply" {
  depends_on                  = [talos_machine_configuration_apply.workers_config_apply]
  client_configuration        = talos_machine_secrets.machine_secrets.client_configuration
  machine_configuration_input = data.talos_machine_configuration.worker.machine_configuration
  config_patches = [
    templatefile("${path.module}/templates/worker-longhorn.yaml.tmpl", {
      ntp_server               = var.ntp_server
      longhorn_extra_disk_path = var.longhorn_extra_disk_path
    })
  ]
  node = var.worker_longhorn
}
resource "talos_machine_bootstrap" "bootstrap" {
  depends_on           = [talos_machine_configuration_apply.controlplane_config_apply, talos_machine_configuration_apply.workers_config_apply, talos_machine_configuration_apply.workers_config_apply]
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  node                 = var.controlplane_ips[0]
}

resource "talos_cluster_kubeconfig" "kubeconfig" {
  depends_on           = [talos_machine_bootstrap.bootstrap]
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  node                 = var.controlplane_ips[0]
}
resource "local_file" "kubeconfig" {
  content  = resource.talos_cluster_kubeconfig.kubeconfig.kubeconfig_raw
  filename = "kubeconfig"
}
resource "local_file" "talosconfig" {
  content  = data.talos_client_configuration.talosconfig.talos_config
  filename = "talosconfig"
}

data "talos_cluster_health" "health" {
  depends_on           = [helm_release.cilium]
  client_configuration = data.talos_client_configuration.talosconfig.client_configuration
  control_plane_nodes  = [for cp_nodes in var.controlplane_ips : cp_nodes]
  worker_nodes         = [for workers in var.workers_ips : workers]
  endpoints            = [for cp_nodes in var.controlplane_ips : cp_nodes]
}

terraform {
  required_providers {
    talos = {
      source  = "siderolabs/talos"
      version = "0.7.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.19.0"
    }
  }
}