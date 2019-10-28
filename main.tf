module "dns_godaddy" {
  source = "./modules/dns_godaddy"

  host      = "ptfe-pm-1"
  domain    = "guselietov.com"
  record_ip = "192.168.1.3"
}