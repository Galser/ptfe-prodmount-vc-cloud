variable "site_domain" {
  default = "guselietov.com"
}

variable "site_record" {
  default = "ptfe-pm-1"
}

variable "region" {
  default = "eu-central-1"
}

variable "availabilityZone" {
  default = "eu-central-1a"
}

variable "vpc_tag" {
  default = "ag_ptfe_pm"
}

variable "subnet_ids" {
  type = "map"
  default = {
    "eu-central-1" = "subnet-7282ce1a"
  }
}

variable "amis" {
  type = "map"
  default = {
    "us-east-2"    = "ami-00f03cfdc90a7a4dd",
    "eu-central-1" = "ami-08a162fe1419adb2a"
  }
}

variable "vpc_security_group_ids" {
  type = "map"
  default = {
    "us-east-2"    = "sg-435345ce45e345343" # sg not tested 
    "eu-central-1" = "sg-04c059aea335d8f69" # sg tested
  }
}

variable "instance_type" {
  default = "m5.large"
}

variable "learntag" {
  type    = "string"
  default = "200tf"
}

