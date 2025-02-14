variable "talos" {
  type = object({
    version                 = string
    url                     = string
    checksum_algorithm      = string
    sha512                  = string
    decompression_algorithm = string
  })
  description = "Talos configurations (version to be deployed, image URL, checksum of the image and decompression algorithm)"
  default = {
    version                 = "v1.9.3"
    url                     = "https://factory.talos.dev/image/88d1f7a5c4f1d3aba7df787c448c1d3d008ed29cfb34af53fa0df4336a56040b/v1.9.3/nocloud-amd64.raw.gz"
    checksum_algorithm      = "sha512"
    sha512                  = "50c76e95f2258a61a0f54dc7dd264608c4cef3cb9f697674a88ec560612f5f4ed0d2c940d52647198fb67b8b26681e83cf456d17af60f536d85ded0088e60708"
    decompression_algorithm = "gz"
  }
}

variable "vm_master" {
  type = object({
    ip_range_min    = number
    ip_range_max    = number
    cidr_block      = string
    vm_id_min       = number
    vm_id_max       = number
    number_of_nodes = number
    cpu             = number
    memory          = number
    disk_size       = number
    hostname        = string
    tags            = list(string)
  })
  description = "Configuration for master nodes (IP pool, VM IDs, CPU, memory, etc.)."
  default = {
    ip_range_min    = 6
    ip_range_max    = 9
    cidr_block      = "192.168.1.0/24"
    vm_id_min       = 200
    vm_id_max       = 210
    number_of_nodes = 3
    cpu             = 2
    memory          = "2048"
    disk_size       = "15"
    hostname        = "talos-master"
    tags = [
      "talos-linux",
      "talos-master"
    ]
  }
}

variable "vm_worker" {
  type = object({
    ip_range_min       = number
    ip_range_max       = number
    cidr_block         = string
    vm_id_min          = number
    vm_id_max          = number
    hostname           = string
    number_of_nodes    = number
    cpu                = number
    memory             = number
    disk_size          = number
    disk_size_longhorn = number
    tags               = list(string)
  })
  description = "Configuration for worker nodes (IP pool, VM IDs, CPU, memory, etc.)."
  default = {
    ip_range_min       = 11
    ip_range_max       = 100
    cidr_block         = "192.168.1.0/24"
    vm_id_min          = 210
    vm_id_max          = 299
    hostname           = "talos-worker"
    number_of_nodes    = "2"
    cpu                = "4"
    memory             = "4096"
    disk_size          = "15"
    disk_size_longhorn = "50"
    tags = [
      "talos-linux",
      "talos-worker"
    ]
  }
}
variable "pve" {
  type = object({
    storage_pool = string
    storage_iso  = string
    domain_name  = string
    gw           = string
    node_name    = string
    vlan_tag     = number
    cpu_type     = string
    ntp_server   = string
  })
  description = "Proxmox-specific configuration (storage pool, domain name, etc.)."
  default = {
    storage_pool = "local-lvm"
    storage_iso  = "local"
    domain_name  = "example.com.br"
    gw           = "192.168.1.1"
    node_name    = "pve"
    vlan_tag     = "1"
    cpu_type     = "x86-64-v2-AES"
    ntp_server   = "ntp.example.com"
  }
}