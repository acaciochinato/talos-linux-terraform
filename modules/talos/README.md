# talos

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | 1.19.0 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | 0.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.17.0 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | 1.19.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.35.1 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.2 |
| <a name="provider_talos"></a> [talos](#provider\_talos) | 0.7.0 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.12.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.cilium](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.longhorn](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.metallb](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.IPAddressPool](https://registry.terraform.io/providers/gavinbunney/kubectl/1.19.0/docs/resources/manifest) | resource |
| [kubectl_manifest.L2Advertisement](https://registry.terraform.io/providers/gavinbunney/kubectl/1.19.0/docs/resources/manifest) | resource |
| [kubernetes_namespace.longhorn-system](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.metallb-system](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [local_file.kubeconfig](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.talosconfig](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [talos_cluster_kubeconfig.kubeconfig](https://registry.terraform.io/providers/siderolabs/talos/0.7.0/docs/resources/cluster_kubeconfig) | resource |
| [talos_machine_bootstrap.bootstrap](https://registry.terraform.io/providers/siderolabs/talos/0.7.0/docs/resources/machine_bootstrap) | resource |
| [talos_machine_configuration_apply.controlplane_config_apply](https://registry.terraform.io/providers/siderolabs/talos/0.7.0/docs/resources/machine_configuration_apply) | resource |
| [talos_machine_configuration_apply.worker_longhorn_config_apply](https://registry.terraform.io/providers/siderolabs/talos/0.7.0/docs/resources/machine_configuration_apply) | resource |
| [talos_machine_configuration_apply.workers_config_apply](https://registry.terraform.io/providers/siderolabs/talos/0.7.0/docs/resources/machine_configuration_apply) | resource |
| [talos_machine_secrets.machine_secrets](https://registry.terraform.io/providers/siderolabs/talos/0.7.0/docs/resources/machine_secrets) | resource |
| [time_sleep.wait_230_seconds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [talos_client_configuration.talosconfig](https://registry.terraform.io/providers/siderolabs/talos/0.7.0/docs/data-sources/client_configuration) | data source |
| [talos_cluster_health.health](https://registry.terraform.io/providers/siderolabs/talos/0.7.0/docs/data-sources/cluster_health) | data source |
| [talos_machine_configuration.controlplane](https://registry.terraform.io/providers/siderolabs/talos/0.7.0/docs/data-sources/machine_configuration) | data source |
| [talos_machine_configuration.worker](https://registry.terraform.io/providers/siderolabs/talos/0.7.0/docs/data-sources/machine_configuration) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cilium_version"></a> [cilium\_version](#input\_cilium\_version) | The version of the Cilium Helm chart | `string` | `"1.17.0"` | no |
| <a name="input_cluster_endpoint"></a> [cluster\_endpoint](#input\_cluster\_endpoint) | The endpoint for the Talos cluster | `string` | `"https://192.168.1.10:6443"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | A name to provide for the Talos cluster | `string` | `"k8s-talos"` | no |
| <a name="input_controlplane_ips"></a> [controlplane\_ips](#input\_controlplane\_ips) | List of IPv4 of the controlplanes | `list(string)` | n/a | yes |
| <a name="input_longhorn_extra_disk_path"></a> [longhorn\_extra\_disk\_path](#input\_longhorn\_extra\_disk\_path) | The ful path of the second block device on the host that will be used for storage | `string` | `"/dev/sda"` | no |
| <a name="input_longhorn_version"></a> [longhorn\_version](#input\_longhorn\_version) | The version of the Longhorn Helm chart | `string` | `"1.8.0"` | no |
| <a name="input_ntp_server"></a> [ntp\_server](#input\_ntp\_server) | NTP Server to configure on all the nodes | `string` | n/a | yes |
| <a name="input_vip"></a> [vip](#input\_vip) | VIP For the Master Nodes and Address for Metallb to expose a LoadBalancer IP | `string` | `"192.168.1.10"` | no |
| <a name="input_worker_longhorn"></a> [worker\_longhorn](#input\_worker\_longhorn) | IPv4 of the Longhorn node | `string` | n/a | yes |
| <a name="input_workers_ips"></a> [workers\_ips](#input\_workers\_ips) | List of IPv4 of the workers nodes | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | n/a |
| <a name="output_cluster_client_certificate"></a> [cluster\_client\_certificate](#output\_cluster\_client\_certificate) | n/a |
| <a name="output_cluster_client_key"></a> [cluster\_client\_key](#output\_cluster\_client\_key) | n/a |
| <a name="output_cluster_host"></a> [cluster\_host](#output\_cluster\_host) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
