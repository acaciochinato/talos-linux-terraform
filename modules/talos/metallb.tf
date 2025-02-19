resource "kubernetes_namespace" "metallb-system" {
  depends_on = [data.talos_cluster_health.health]
  metadata {
    labels = {
      "pod-security.kubernetes.io/enforce" = "privileged"
      "pod-security.kubernetes.io/audit"   = "privileged"
      "pod-security.kubernetes.io/warn"    = "privileged"
    }
    name = "metallb-system"
  }
}

resource "helm_release" "metallb" {
  depends_on = [kubernetes_namespace.metallb-system]
  name       = "metallb"
  repository = "https://metallb.github.io/metallb"
  chart      = "metallb"
  namespace  = "metallb-system"
  set {
    name  = "crds.enabled"
    value = "true"
  }
}

resource "kubectl_manifest" "IPAddressPool" {
  depends_on = [helm_release.metallb]
  yaml_body  = <<YAML
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: default
  namespace: metallb-system
spec:
  addresses:
  - "${var.vip}/32"
  autoAssign: true
YAML
}

resource "kubectl_manifest" "L2Advertisement" {
  depends_on = [kubectl_manifest.IPAddressPool]
  yaml_body  = <<YAML
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: default
  namespace: metallb-system
spec:
  ipAddressPools:
  - default  
YAML
}