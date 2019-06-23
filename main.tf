locals {
  crd = [
    "certificates.certmanager.k8s.io",
    "clusterissuers.certmanager.k8s.io",
    "issuers.certmanager.k8s.io",
  ]

  value = join(" ", local.crd)
}

resource "helm_release" "cert_manager" {
  count     = var.enabled && var.chart_enabled_cert_manager ? 1 : 0
  name      = "cert-manager"
  chart     = "stable/cert-manager"
  version   = var.chart_version_cert_manager
  namespace = var.chart_namespace_cert_manager

  values = [
    file("${path.root}/templates/${terraform.workspace}/chart_values_cert_manager.yml"),
  ]

  provisioner "local-exec" {
    command = "kubectl delete crd --context ${var.cluster_name} ${local.value}"
    when    = "destroy"
  }
}

resource "helm_release" "external_dns" {
  count     = var.enabled && var.chart_enabled_external_dns ? 1 : 0
  name      = "external-dns"
  chart     = "stable/external-dns"
  version   = var.chart_version_external_dns
  namespace = var.chart_namespace_external_dns

  values = [
    file("${path.root}/templates/${terraform.workspace}/chart_values_external_dns.yml"),
  ]
}

resource "helm_release" "kubernetes_dashboard" {
  count     = var.enabled && var.chart_enabled_kubernetes_dashboard ? 1 : 0
  name      = "kubernetes-dashboard"
  chart     = "stable/kubernetes-dashboard"
  version   = var.chart_version_kubernetes_dashboard
  namespace = var.chart_namespace_kubernetes_dashboard

  values = [
    file("${path.root}/templates/${terraform.workspace}/chart_values_kubernetes_dashboard.yml"),
  ]
}

resource "helm_release" "metrics_server" {
  count     = var.enabled && var.chart_enabled_metrics_server ? 1 : 0
  name      = "metrics-server"
  chart     = "stable/metrics-server"
  version   = var.chart_version_metrics_server
  namespace = var.chart_namespace_metrics_server

  values = [
    file("${path.root}/templates/${terraform.workspace}/chart_values_metrics_server.yml"),
  ]
}

resource "helm_release" "nginx_ingress" {
  count     = var.enabled && var.chart_enabled_nginx_ingress ? 1 : 0
  name      = "nginx-ingress"
  chart     = "stable/nginx-ingress"
  version   = var.chart_version_nginx_ingress
  namespace = var.chart_namespace_nginx_ingress

  values = [
    file("${path.root}/templates/${terraform.workspace}/chart_values_nginx_ingress.yml"),
  ]
}
