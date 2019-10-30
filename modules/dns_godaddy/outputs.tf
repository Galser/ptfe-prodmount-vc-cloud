# dns_goddayd outputs
output "backend_fqdn" {
  value = "${local.backend}.${var.domain}"
}