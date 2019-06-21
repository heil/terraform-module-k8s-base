locals {
  crd = [
    "certificates.certmanager.k8s.io",
    "clusterissuers.certmanager.k8s.io",
    "issuers.certmanager.k8s.io",
  ]

  value = "${join(" ", local.crd)}"
}

resource "helm_release" "cert_manager" {
  count     = "${var.enabled == "true" && var.chart_enabled_cert_manager == "true" ? 1 : 0}"
  name      = "cert-manager"
  chart     = "stable/cert-manager"
  version   = "${var.chart_version_cert_manager}"
  namespace = "${var.chart_namespace_cert_manager}"

  values = [
    "${data.template_file.cert_manager.rendered}",
  ]

  provisioner "local-exec" {
    command = "kubectl delete crd --context ${var.cluster_name} ${local.value}"
    when    = "destroy"
  }
}

resource "helm_release" "external_dns" {
  count     = "${var.enabled == "true" && var.chart_enabled_external_dns == "true" ? 1 : 0}"
  name      = "external-dns"
  chart     = "stable/external-dns"
  version   = "${var.chart_version_external_dns}"
  namespace = "${var.chart_namespace_external_dns}"

  values = [
    "${data.template_file.external_dns.rendered}",
  ]

  set {
    name  = "rbac.create"
    value = "false"
  }
}

resource "helm_release" "kubernetes_dashboard" {
  count     = "${var.enabled == "true" && var.chart_enabled_kubernetes_dashboard == "true" ? 1 : 0}"
  name      = "kubernetes-dashboard"
  chart     = "stable/kubernetes-dashboard"
  version   = "${var.chart_version_kubernetes_dashboard}"
  namespace = "${var.chart_namespace_kubernetes_dashboard}"

  values = [
    "${data.template_file.kubernetes_dashboard.rendered}",
  ]
}

resource "helm_release" "metrics_server" {
  count     = "${var.enabled == "true" && var.chart_enabled_metrics_server == "true" ? 1 : 0}"
  name      = "metrics-server"
  chart     = "stable/metrics-server"
  namespace = "${var.chart_namespace_nginx_ingress}"
  namespace = "${var.chart_namespace_metrics_server}"

  values = [
    "${data.template_file.metrics_server.rendered}",
  ]
}

resource "helm_release" "nginx_ingress" {
  count     = "${var.enabled == "true" && var.chart_enabled_nginx_ingress == "true" ? 1 : 0}"
  name      = "nginx-ingress"
  chart     = "stable/nginx-ingress"
  version   = "${var.chart_version_nginx_ingress}"
  namespace = "${var.chart_namespace_nginx_ingress}"

  values = [
    "${data.template_file.nginx_ingress.rendered}",
  ]
}
