resource "kubernetes_namespace" "longhorn-system" {
  depends_on = [data.talos_cluster_health.health]
  metadata {
    labels = {
      "pod-security.kubernetes.io/enforce" = "privileged"
    }
    name = "longhorn-system"
  }
}

resource "helm_release" "longhorn" {
  depends_on      = [kubernetes_namespace.longhorn-system]
  name            = "longhorn"
  repository      = "https://charts.longhorn.io"
  chart           = "longhorn"
  version         = var.longhorn_version
  namespace       = "longhorn-system"
  timeout         = "500"
  cleanup_on_fail = true

  values = [file("${path.module}/files/longhorn_values.yml")
  ]
}