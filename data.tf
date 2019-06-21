data "template_file" "cert_manager" {
  count    = "${var.enabled == "true" && var.chart_enabled_cert_manager == "true" ? 1 : 0}"
  template = "${file("${path.module}/templates/chart_values_cert_manager.yml")}"
}

data "template_file" "external_dns" {
  count    = "${var.enabled == "true" && var.chart_enabled_external_dns == "true" ? 1 : 0}"
  template = "${file("${path.module}/templates/chart_values_external_dns.yml")}"
}

data "template_file" "kubernetes_dashboard" {
  count    = "${var.enabled == "true" && var.chart_enabled_kubernetes_dashboard == "true" ? 1 : 0}"
  template = "${file("${path.module}/templates/chart_values_kubernetes_dashboard.yml")}"
}

data "template_file" "metrics_server" {
  count    = "${var.enabled == "true" && var.chart_enabled_metrics_server == "true" ? 1 : 0}"
  template = "${file("${path.module}/templates/chart_values_metrics_server.yml")}"
}

data "template_file" "nginx_ingress" {
  count    = "${var.enabled == "true" && var.chart_enabled_nginx_ingress == "true" ? 1 : 0}"
  template = "${file("${path.module}/templates/chart_values_nginx_ingress.yml")}"
}
