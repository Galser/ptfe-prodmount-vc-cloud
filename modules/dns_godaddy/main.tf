
resource "godaddy_domain_record" "dns_godaddy_a_record" {
  domain = var.domain

  record {
    name = var.host
    type = "A"
    data = var.record_ip
    ttl  = 600
  }

  # internal values that should be prevented for
  # my domain, due to the implmentation in ACME
  # could be overcomed by "import" in the future
  record {
    data     = "@"
    name     = "www"
    priority = 0
    ttl      = 3600
    type     = "CNAME"
  }

  record {
    data     = "_domainconnect.gd.domaincontrol.com"
    name     = "_domainconnect"
    priority = 0
    ttl      = 3600
    type     = "CNAME"
  }
}