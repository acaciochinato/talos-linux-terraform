locals {
  vm_master = {
    ip_pool = [for ip in range(var.vm_master.ip_range_min, var.vm_master.ip_range_max) : "${cidrhost(var.vm_master.cidr_block, ip)}/${split("/", var.vm_master.cidr_block)[1]}"]
    vm_id   = [for vmid in range(var.vm_master.vm_id_min, var.vm_master.vm_id_max) : "${vmid}"]
  }
  vm_worker = {
    ip_pool = [for ip in range(var.vm_worker.ip_range_min, var.vm_worker.ip_range_max) : "${cidrhost(var.vm_worker.cidr_block, ip)}/${split("/", var.vm_worker.cidr_block)[1]}"]
    vm_id   = [for vmid in range(var.vm_worker.vm_id_min, var.vm_worker.vm_id_max) : "${vmid}"]
  }
}