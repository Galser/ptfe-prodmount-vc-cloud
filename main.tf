module "dns_godaddy" {
  source = "./modules/dns_godaddy"

  host      = var.site_record
  domain    = var.site_domain
  record_ip = "192.168.1.3"
}

module "sslcert_letsencrypt" {
  source = "./modules/sslcert_letsencrypt"

  host      = var.site_record
  domain    = var.site_domain
} 