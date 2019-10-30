# Outputs for "sslcert_letsencrypt" module
output "cert_pem" {
  value = "${module.sslcert_letsencrypt.cert_pem}"
}

output "cert_private_key_pem" {
  value = "${module.sslcert_letsencrypt.cert_private_key_pem}"
}

output "cert_url" {
  value = "${module.sslcert_letsencrypt.cert_url}"
}

output "cert_issuer_pem" {
  value = "${module.sslcert_letsencrypt.cert_issuer_pem}"
}

output "cert_bundle" {
  value = "${module.sslcert_letsencrypt.cert_bundle}"
}

# 

output "public_ip" {
  value = "${aws_instance.ptfe.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.ptfe.public_dns}"
}

output "full_site_name" {
  value = "${var.site_record}.${var.site_domain}"
}

output "clb_dns_name" {
  value       = aws_elb.ptfe_lb.dns_name
  description = "The domain name of the load balancer"
}