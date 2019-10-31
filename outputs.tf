output "cert_url" {
  value = "${module.sslcert_letsencrypt.cert_url}"
}

output "public_ip" {
  value = "${aws_instance.ptfe.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.ptfe.public_dns}"
}

output "full_site_name" {
  value = "${var.site_record}.${var.site_domain}"
}

output "loadbalancer_fqdn" {
  value       = aws_elb.ptfe_lb.dns_name
  description = "The domain name of the load balancer"
}

output "backend_fqdn" {
  value = "${module.dns_cloudflare.backend_fqdn}"
}

