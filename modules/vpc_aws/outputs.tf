# Outputs for "sslcert_letsencrypt" module
# note that if you want the full 

output "subnet_id" {
  value = "${aws_subnet.ag_tfe_Subnet.id}"
}

output "security_group_id" {
  value = "${aws_security_group.ag_tfe_Security_Group.id}"
}

output "elb_security_group_id" {
  value = "${aws_security_group.ag_tfe_Security_Group_elb.id}"
}

