variable "chart_enabled_cert_manager" {
  type    = bool
  default = true
}

variable "chart_enabled_external_dns" {
  type    = bool
  default = true
}

variable "chart_enabled_kubernetes_dashboard" {
  type    = bool
  default = true
}

variable "chart_enabled_metrics_server" {
  type    = bool
  default = true
}

variable "chart_enabled_nginx_ingress" {
  type    = bool
  default = true
}

variable "chart_namespace_cert_manager" {
  type    = bool
  default = "cert-manager"
}

variable "chart_namespace_external_dns" {
  default = "external-dns"
}

variable "chart_namespace_kubernetes_dashboard" {
  default = "kube-system"
}

variable "chart_namespace_metrics_server" {
  default = "kube-system"
}

variable "chart_namespace_nginx_ingress" {
  default = "nginx-ingress"
}

variable "chart_version_cert_manager" {
  default = "v0.5.2"
}

variable "chart_version_external_dns" {
  default = "1.6.0"
}

variable "chart_version_kubernetes_dashboard" {
  default = "1.2.0"
}

variable "chart_version_metrics_server" {
  default = "2.2.0"
}

variable "chart_version_nginx_ingress" {
  default = "1.2.2"
}

variable "enabled" {
  type    = bool
  default = true
}
