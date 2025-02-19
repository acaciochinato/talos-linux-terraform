resource "helm_release" "ingress-nginx" {
  depends_on       = [kubectl_manifest.L2Advertisement]
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
}