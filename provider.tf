terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.70.1"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "0.7.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.17.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.19.0"
    }
  }
}
provider "proxmox" {
  endpoint  = var.endpoint
  api_token = var.api_token
  ssh {
    agent       = true
    username    = var.username
    private_key = file(var.ssh_key_file_path)
  }
}

provider "talos" {}
provider "local" {}

provider "kubectl" {
  host                   = module.talos.cluster_host
  client_certificate     = base64decode(module.talos.cluster_client_certificate)
  client_key             = base64decode(module.talos.cluster_client_key)
  cluster_ca_certificate = base64decode(module.talos.cluster_ca_certificate)
}

provider "kubernetes" {
  host                   = module.talos.cluster_host
  client_certificate     = base64decode(module.talos.cluster_client_certificate)
  client_key             = base64decode(module.talos.cluster_client_key)
  cluster_ca_certificate = base64decode(module.talos.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = module.talos.cluster_host
    client_certificate     = base64decode(module.talos.cluster_client_certificate)
    client_key             = base64decode(module.talos.cluster_client_key)
    cluster_ca_certificate = base64decode(module.talos.cluster_ca_certificate)
  }
}