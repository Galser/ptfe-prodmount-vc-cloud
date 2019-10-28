module "dns_godaddy" {
  source = "./modules/dns_godaddy"

  host      = var.site_record
  domain    = var.site_domain
  record_ip = "192.168.1.3"
}

module "sslcert_letsencrypt" {
  source = "./modules/sslcert_letsencrypt"

  host   = var.site_record
  domain = var.site_domain
}

resource "aws_key_pair" "ptfe-key" {
  key_name   = "ptfe-key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}


resource "aws_instance" "ptfe" {
  ami                    = var.amis[var.region]
  instance_type          = "${var.instance_type}"
  subnet_id              = var.subnet_ids[var.region]
  vpc_security_group_ids = [var.vpc_security_group_ids[var.region]]
  key_name               = "${aws_key_pair.ptfe-key.id}"

  ebs_block_device {
    device_name = "/dev/sdg"
    volume_size = 41
    delete_on_termination = false
  }

  tags = {
    "Name"      = "ptfe-prodmount-andrii",
    "andriitag" = "true",
    "learntag"  = "${var.learntag}"
  }

  volume_tags = {
    "Name" = "ptfe-prodmount-andrii",
    "andriitag" = "true",
  }

  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = "${file("~/.ssh/id_rsa")}"
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y curl wget",
    ]
  }
}