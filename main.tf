# Network : AWS VPC
module "vpc_aws" {
  source = "./modules/vpc_aws"

  region           = var.region
  availabilityZone = var.availabilityZone
  tag              = var.vpc_tag
}

# Network : DNS GoDaddy
module "dns_godaddy" {
  source = "./modules/dns_godaddy"

  host         = var.site_record
  domain       = var.site_domain
  cname_target = aws_elb.ptfe_lb.dns_name
  record_ip    = "${aws_instance.ptfe.public_ip}"
}

# Certificate : SSL from Let'sEncrypt
module "sslcert_letsencrypt" {
  source = "./modules/sslcert_letsencrypt"

  host   = var.site_record
  domain = var.site_domain
}

# Instance  

# SSH key fpor provision
resource "aws_key_pair" "ptfe-key" {
  key_name   = "ptfe-key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

# Instance
resource "aws_instance" "ptfe" {
  ami                    = var.amis[var.region]
  instance_type          = "${var.instance_type}"
  subnet_id              = "${module.vpc_aws.subnet_id}"
  vpc_security_group_ids = ["${module.vpc_aws.security_group_id}"]
  key_name               = "${aws_key_pair.ptfe-key.id}"

  root_block_device {
    volume_size = 40
  }

  ebs_block_device {
    device_name           = "/dev/sdg"
    volume_size           = 41
    delete_on_termination = false
  }

  tags = {
    "Name"      = "ptfe-prodmount-andrii",
    "andriitag" = "true",
    "learntag"  = "${var.learntag}"
  }

  volume_tags = {
    "Name"      = "ptfe-prodmount-andrii",
    "andriitag" = "true",
  }

  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = "${file("~/.ssh/id_rsa")}"
    host        = self.public_ip
  }


  provisioner "remote-exec" {
    script = "scripts/provision.sh"
  }

}

# Load-Balancer, AWS ELB classic  as we terminate SSL
# on instance and no need for new features of ALB
resource "aws_elb" "ptfe_lb" {
  name = "ag-tfe-clb"

  security_groups = ["${module.vpc_aws.elb_security_group_id}"]
  subnets         = ["${module.vpc_aws.subnet_id}"]

  health_check {
    healthy_threshold   = 10
    unhealthy_threshold = 3
    timeout             = 15
    target              = "TCP:8800"
    interval            = 30
  }

  listener {
    lb_port           = "443"
    lb_protocol       = "tcp"
    instance_port     = "443"
    instance_protocol = "tcp"
  }
  listener {
    lb_port           = "8800"
    lb_protocol       = "tcp"
    instance_port     = "8800"
    instance_protocol = "tcp"
  }

  instances                   = ["${aws_instance.ptfe.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    "Name"      = "ptfe-prodmount-andrii",
    "andriitag" = "true",
    "learntag"  = "${var.learntag}"
  }
}
