variable "cluster_name" {
  description = "A name to provide for the Talos cluster"
  type        = string
  default     = "k8s-talos"
}
variable "cluster_endpoint" {
  description = "The endpoint for the Talos cluster"
  type        = string
  default     = "https://192.168.1.10:6443"
}
variable "vip" {
  type        = string
  description = "VIP For the Master Nodes"
  default     = "192.168.1.10"
}
variable "ntp_server" {
  type        = string
  description = "NTP Server to configure on all the nodes"
}
variable "controlplane_ips" {
  description = "List of IPv4 of the controlplanes"
  type        = list(string)
}
variable "workers_ips" {
  description = "List of IPv4 of the workers nodes"
  type        = list(string)
}
variable "worker_longhorn" {
  description = "IPv4 of the Longhorn node"
  type        = string
}

variable "longhorn_extra_disk_path" {
  description = "The ful path of the second block device on the host that will be used for storage"
  default     = "/dev/sda"
}

variable "cilium_version" {
  description = "The version of the Cilium Helm chart"
  default     = "1.17.0"
}

variable "longhorn_version" {
  description = "The version of the Longhorn Helm chart"
  default     = "1.8.0"
}