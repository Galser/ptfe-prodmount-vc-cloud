# parameters for the vpc_aws module
# you MNEED to specify at least
# region and availabilityZone

variable "region" {}
variable "availabilityZone" {}
variable "tag" {}

variable "instanceTenancy" {
  default = "default"
}

variable "dnsSupport" {
  default = true
}

variable "dnsHostNames" {
  default = true
}
variable "vpcCIDRblock" {
  default = "10.0.0.0/16"
}
variable "subnetCIDRblock" {
  default = "10.0.1.0/24"
}
variable "destinationCIDRblock" {
  default = "0.0.0.0/0"
}
variable "ingressCIDRblock" {
  type    = "list"
  default = ["0.0.0.0/0"]
}
variable "mapPublicIP" {
  default = true
}