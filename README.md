# Kubernetes Cluster Deployment in Proxmox using Talos Linux, Cilium CNI and Longhorn

This Terraform project automates the deployment of a Kubernetes cluster using Talos Linux in a Proxmox virtual environment. The cluster is configured with Cilium CNI for networking and Longhorn for distributed storage. A personal feature of this setup is that the first worker node is provisioned with an additional disk, which is exclusively used by Longhorn for storage.

The project is customizable via variables, allowing users to tailor the cluster to their specific needs. Please take a look at the `variables.tf` of each module and adjust accordingly.

## Overview

This project uses Terraform to:
- Create virtual machines in Proxmox using the Talos Linux image;
- Bootstrap a Kubernetes cluster with Talos Linux;
- Configure the cluster to use Cilium CNI instead of the default CNI provided by Talos;
- Install Longhorn for distributed storage.

## Prerequisites

Before cloning the project, make sure you have the following:

- Proxmox Environment:
    - A running Proxmox server with sufficient resources, depending on the number of nodes that you'll want to create;
    - Valid API token (create a user with appropriate permissions). See: https://registry.terraform.io/providers/bpg/proxmox/latest/docs#api-token-authentication
    - Ensure proper availability of vms ID to be used and adjust the variables accordingly

- Terraform:
    - Terraform installed on your local machine or CI/CD environment.
- Talos Linux Image:
    - A noCloud Talos Linux image URL was generated from https://factory.talos.dev and declared as a variable to be used. If the link goes offline, generate a new image with the following needed extensions and populate the variables accordingly; See https://www.talos.dev/latest/talos-guides/configuration/system-extensions
    - Needed System Extensions:
        - siderolabs/qemu-guest-agent
        - siderolabs/iscsi-tools
        - siderolabs/util-linux-tools

- Network Configuration:
    - Ensure proper network configuration (e.g., static IPs or DHCP pool availability) for the virtual machines and adjust the variables accordingly.

## Features
- Proxmox Integration: Automates the creation of virtual machines using the beloved Proxmox;
- Talos Linux: Uses Talos Linux for a secure, immutable, and minimal Kubernetes OS.
- Cilium CNI: Replaces the default CNI with Cilium for advanced networking features.
- Longhorn Storage: Installs Longhorn for distributed block storage, with the first worker node receiving an additional dedicated disk enforced using the Longhorn configuration flag `createDefaultDiskLabeledNodes`;
- Highly Customizable: All machine configurations are customizable using Terraform variables and template files for the Talos machines.

## Usage

### Step 1: Clone the Repository
```
git clone https://github.com/acaciochinato/talos-linux-terraform
cd talos-linux-terraform
```

### Step 2: Configure the variables
Each module has a `variables.tf` file that you need to configure to meet your needs and your environment.

### Step 3: Initialize Terraform
```
terraform init
```
### Step 4: Apply the Configuration
```
terraform apply
```

### Step 5: Access the Cluster

Once the cluster is deployed, use `talosctl` and `kubectl` to interact with it. The `kubeconfig` and `talosconfig` files will be generated for you at the root folder of the cloned repository:

```
export KUBECONFIG=$(pwd)/kubeconfig
kubectl get nodes
```
```
talosctl --talosconfig ./talosconfig 
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.17.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.17.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.5.2 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 0.70.1 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | 0.7.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_proxmox"></a> [proxmox](#module\_proxmox) | ./modules/proxmox | n/a |
| <a name="module_talos"></a> [talos](#module\_talos) | ./modules/talos | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_token"></a> [api\_token](#input\_api\_token) | API credentials for authentication. See https://registry.terraform.io/providers/bpg/proxmox/latest/docs#api-token-authentication | `string` | n/a | yes |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | Base URL for the Proxmox API Endpoint. Ex: https://pve.example.com | `string` | n/a | yes |
| <a name="input_ssh_key_file_path"></a> [ssh\_key\_file\_path](#input\_ssh\_key\_file\_path) | Full path of the SSH key for the sudo privileged user for authentication | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | Username to authenticate via SSH | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
