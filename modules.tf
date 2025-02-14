module "proxmox" {
  source = "./modules/proxmox"
}
module "talos" {
  source           = "./modules/talos"
  controlplane_ips = module.proxmox.controlplane_ips
  workers_ips      = module.proxmox.workers_ips
  worker_longhorn  = module.proxmox.workers_longhorn
  ntp_server       = module.proxmox.ntp_server
}