locals {
  backend = "${var.host}_backend"
}

resource "godaddy_domain_record" "dns_godaddy_record" {
  domain = var.domain

  #record {
  #  name = var.host
  #  type = "A"
  #  data = var.record_ip
  #  ttl  = 600
  #}

  record {
    data     = var.cname_target
    name     = var.host
    priority = 0
    ttl      = 600
    type     = "CNAME"
  }

  record {
    name = local.backend
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
