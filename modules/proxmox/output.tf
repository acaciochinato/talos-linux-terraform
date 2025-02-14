output "controlplane_ips" {
  description = "Store each IPv4 used for the master nodes"
  value       = [for vm in proxmox_virtual_environment_vm.control_plane : replace(vm.initialization[0].ip_config[0].ipv4[0].address, "/24", "")]
}
output "ntp_server" {
  description = "NTP Server Address"
  value       = var.pve.ntp_server
}
output "workers_ips" {
  description = "Store each IPv4 used for the workers nodes"
  value       = [for vm in proxmox_virtual_environment_vm.worker_nodes : replace(vm.initialization[0].ip_config[0].ipv4[0].address, "/24", "")]
}
output "workers_longhorn" {
  description = "Store the IPv4 used for the Longhorn node"
  value       = replace(proxmox_virtual_environment_vm.worker_nodes[0].initialization[0].ip_config[0].ipv4[0].address, "/24", "")
}
