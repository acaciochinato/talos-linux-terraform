resource "proxmox_virtual_environment_download_file" "talos-img" {
  content_type            = "iso"
  datastore_id            = var.pve.storage_iso
  file_name               = "talos-${var.talos.version}-nocloud-amd64.img"
  node_name               = var.pve.node_name
  url                     = var.talos.url
  checksum                = var.talos.sha512
  checksum_algorithm      = var.talos.checksum_algorithm
  decompression_algorithm = var.talos.decompression_algorithm
  overwrite               = false
}

resource "proxmox_virtual_environment_vm" "control_plane" {
  count     = var.vm_master.number_of_nodes
  name      = "${var.vm_master.hostname}-${count.index}"
  tags      = var.vm_master.tags
  node_name = var.pve.node_name
  vm_id     = local.vm_master.vm_id[count.index]
  agent {
    enabled = true
  }
  startup {
    order      = "3"
    up_delay   = "60"
    down_delay = "60"
  }
  cpu {
    cores = var.vm_master.cpu
    type  = var.pve.cpu_type
  }
  memory {
    dedicated = var.vm_master.memory
  }

  disk {
    datastore_id = var.pve.storage_pool
    file_id      = proxmox_virtual_environment_download_file.talos-img.id
    file_format  = "raw"
    interface    = "virtio0"
    size         = var.vm_master.disk_size
    backup       = true
    ssd          = true
  }
  operating_system {
    type = "l26" # Linux Kernel 2.6 - 5.X.
  }

  network_device {
    vlan_id = var.pve.vlan_tag
  }
  initialization {
    datastore_id = var.pve.storage_pool
    ip_config {
      ipv4 {
        address = local.vm_master.ip_pool[count.index]
        gateway = var.pve.gw
      }
    }
    dns {
      domain  = var.pve.domain_name
      servers = [var.pve.gw]
    }
  }
}

resource "proxmox_virtual_environment_vm" "worker_nodes" {
  count     = var.vm_worker.number_of_nodes
  name      = "${var.vm_worker.hostname}-${count.index}"
  tags      = var.vm_worker.tags
  node_name = var.pve.node_name
  vm_id     = local.vm_worker.vm_id[count.index]
  agent {
    enabled = true
  }
  startup {
    order      = "3"
    up_delay   = "60"
    down_delay = "60"
  }
  cpu {
    cores = var.vm_worker.cpu
    type  = var.pve.cpu_type
  }
  memory {
    dedicated = var.vm_worker.memory
  }
  disk {
    datastore_id = var.pve.storage_pool
    file_id      = proxmox_virtual_environment_download_file.talos-img.id
    file_format  = "raw"
    interface    = "virtio0"
    size         = var.vm_worker.disk_size
    backup       = true
    ssd          = true
  }
  dynamic "disk" {
    for_each = count.index == 0 ? [0] : [] # Here I specify that only the first worker node will have an additional disk because of Longhorn.
    content {
      datastore_id = var.pve.storage_pool
      file_format  = "raw"
      interface    = "sata1"
      size         = var.vm_worker.disk_size_longhorn
      backup       = true
      ssd          = true
    }
  }
  operating_system {
    type = "l26" # Linux Kernel 2.6 - 5.X.
  }
  network_device {
    vlan_id = var.pve.vlan_tag
  }
  initialization {
    datastore_id = var.pve.storage_pool
    ip_config {
      ipv4 {
        address = local.vm_worker.ip_pool[count.index]
        gateway = var.pve.gw
      }
    }
    dns {
      domain  = var.pve.domain_name
      servers = [var.pve.gw]
    }
  }
}
terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
    }
  }
}