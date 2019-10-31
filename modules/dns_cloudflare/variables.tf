# parameters for the dns_cloudflare module
variable "domain" {
  description = "The DOMAIN part of the record"
}

variable "host" {
  description = "The HOST part of the record"
}

variable "record_ip" {
  description = "The IP address for the record"
}

variable "cname_target" {
  description = "The target for CNAME record"
}

