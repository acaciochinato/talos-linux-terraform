# proxmox

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.71.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_download_file.talos-img](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_download_file) | resource |
| [proxmox_virtual_environment_vm.control_plane](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm) | resource |
| [proxmox_virtual_environment_vm.worker_nodes](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_pve"></a> [pve](#input\_pve) | Proxmox-specific configuration (storage pool, domain name, etc.). | <pre>object({<br/>    storage_pool = string<br/>    storage_iso  = string<br/>    domain_name  = string<br/>    gw           = string<br/>    node_name    = string<br/>    vlan_tag     = number<br/>    cpu_type     = string<br/>    ntp_server   = string<br/>  })</pre> | <pre>{<br/>  "cpu_type": "x86-64-v2-AES",<br/>  "domain_name": "example.com.br",<br/>  "gw": "192.168.1.1",<br/>  "node_name": "pve",<br/>  "ntp_server": "ntp.example.com",<br/>  "storage_iso": "local",<br/>  "storage_pool": "local-lvm",<br/>  "vlan_tag": "1"<br/>}</pre> | no |
| <a name="input_talos"></a> [talos](#input\_talos) | Talos configurations (version to be deployed, image URL, checksum of the image and decompression algorithm) | <pre>object({<br/>    version                 = string<br/>    url                     = string<br/>    checksum_algorithm      = string<br/>    sha512                  = string<br/>    decompression_algorithm = string<br/>  })</pre> | <pre>{<br/>  "checksum_algorithm": "sha512",<br/>  "decompression_algorithm": "gz",<br/>  "sha512": "50c76e95f2258a61a0f54dc7dd264608c4cef3cb9f697674a88ec560612f5f4ed0d2c940d52647198fb67b8b26681e83cf456d17af60f536d85ded0088e60708",<br/>  "url": "https://factory.talos.dev/image/88d1f7a5c4f1d3aba7df787c448c1d3d008ed29cfb34af53fa0df4336a56040b/v1.9.3/nocloud-amd64.raw.gz",<br/>  "version": "v1.9.3"<br/>}</pre> | no |
| <a name="input_vm_master"></a> [vm\_master](#input\_vm\_master) | Configuration for master nodes (IP pool, VM IDs, CPU, memory, etc.). | <pre>object({<br/>    ip_range_min    = number<br/>    ip_range_max    = number<br/>    cidr_block      = string<br/>    vm_id_min       = number<br/>    vm_id_max       = number<br/>    number_of_nodes = number<br/>    cpu             = number<br/>    memory          = number<br/>    disk_size       = number<br/>    hostname        = string<br/>    tags            = list(string)<br/>  })</pre> | <pre>{<br/>  "cidr_block": "192.168.1.0/24",<br/>  "cpu": 2,<br/>  "disk_size": "15",<br/>  "hostname": "talos-master",<br/>  "ip_range_max": 9,<br/>  "ip_range_min": 6,<br/>  "memory": "2048",<br/>  "number_of_nodes": 3,<br/>  "tags": [<br/>    "talos-linux",<br/>    "talos-master"<br/>  ],<br/>  "vm_id_max": 210,<br/>  "vm_id_min": 200<br/>}</pre> | no |
| <a name="input_vm_worker"></a> [vm\_worker](#input\_vm\_worker) | Configuration for worker nodes (IP pool, VM IDs, CPU, memory, etc.). | <pre>object({<br/>    ip_range_min       = number<br/>    ip_range_max       = number<br/>    cidr_block         = string<br/>    vm_id_min          = number<br/>    vm_id_max          = number<br/>    hostname           = string<br/>    number_of_nodes    = number<br/>    cpu                = number<br/>    memory             = number<br/>    disk_size          = number<br/>    disk_size_longhorn = number<br/>    tags               = list(string)<br/>  })</pre> | <pre>{<br/>  "cidr_block": "192.168.1.0/24",<br/>  "cpu": "4",<br/>  "disk_size": "15",<br/>  "disk_size_longhorn": "50",<br/>  "hostname": "talos-worker",<br/>  "ip_range_max": 100,<br/>  "ip_range_min": 11,<br/>  "memory": "4096",<br/>  "number_of_nodes": "2",<br/>  "tags": [<br/>    "talos-linux",<br/>    "talos-worker"<br/>  ],<br/>  "vm_id_max": 299,<br/>  "vm_id_min": 210<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_controlplane_ips"></a> [controlplane\_ips](#output\_controlplane\_ips) | Store each IPv4 used for the master nodes |
| <a name="output_ntp_server"></a> [ntp\_server](#output\_ntp\_server) | NTP Server Address |
| <a name="output_workers_ips"></a> [workers\_ips](#output\_workers\_ips) | Store each IPv4 used for the workers nodes |
| <a name="output_workers_longhorn"></a> [workers\_longhorn](#output\_workers\_longhorn) | Store the IPv4 used for the Longhorn node |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
