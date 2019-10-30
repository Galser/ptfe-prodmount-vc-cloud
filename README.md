# ptfe-prodmount-vc-cloud
Install Prod Mount disk PTFE version with Valid Certificate - cloud

# Purpose
This repo contains all the code and instruction on how to install PTFE (Prod) version with Valid Certificate in cloud environment in mounted disk mode.

# Requirements

TFE Overview: https://www.terraform.io/docs/enterprise/index.html

Pre-Install checklist: https://www.terraform.io/docs/enterprise/before-installing/index.html

This repository assumes general knowledge about Terraform, if not, please get yourself accustomed first by going through [getting started guide for Terraform](https://learn.hashicorp.com/terraform?track=getting-started#getting-started). We also going to use Vagrant with VirtualBox.

To learn more about the mentioned above tools and technologies -  please check section [Technologies near the end of the README](#technologies)

You also will need to prepare valid SSL certificate.

# How-to
- clone repo
- run TF init
- run TF apply
( possible problems - GoDaddy stuck with DNS update..how to avoid?) 
Theoretically we could specify timeout : 
```terraform
  timeouts {
    create = "5m"
    delete = "5m"
  }
```
but, ACME resource does not support timeouts. I don't see any immediate solution right now except for running apply once more. Sleep in `local-exec` is not going to help in this case, it's the response that is slow.

- Output example
  ```bash
  Outputs:

  backend_fqdn = ptfe-pm-1_backend.guselietov.com
  cert_url = https://acme-v02.api.letsencrypt.org/acme/cert/035a5ed202a09ab4f926a4d99ae50f9bdfb5
  full_site_name = ptfe-pm-1.guselietov.com
  loadbalancer_fqdn = ag-tfe-clb-493767462.eu-central-1.elb.amazonaws.com
  public_dns = ec2-18-184-220-142.eu-central-1.compute.amazonaws.com
  public_ip = 18.184.220.142
  ```
- Login to instance
- Run TFE install
```bash
curl https://install.terraform.io/ptfe/stable | sudo bash
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  118k  100  118k    0     0  48967      0  0:00:02  0:00:02 --:--:-- 48967
Determining local address
The installer will use network interface 'ens5' (with IP address '172.31.2.88')
Determining service address
The installer will use service address '52.59.146.33' (discovered from EC2 metadata service)
The installer has automatically detected the service IP address of this machine as 52.59.146.33.
Do you want to:
[0] default: use 52.59.146.33
[1] enter new address
Enter desired number (0-1): 0
Does this machine require a proxy to access the Internet? (y/N) n
Installing docker version 18.09.2 from https://get.replicated.com/docker-install.sh
# Executing docker install script, commit: UNKNOWN 
...
+ sh -c apt-get update -qq >/dev/null
+ sh -c apt-get install -y -qq apt-transport-https ca-certificates curl >/dev/null...
Operator installation successful

To continue the installation, visit the following URL in your browser:

  http://52.59.146.33:8800

```
- Web-portion : 
...
...

  - Save settings, ..TFE starting

# Run-log 
## Disk making (manual test)
- Find and make the disk : 
  - Determine the disk : 
  ```bash
  root@ip-172-31-2-88:~# lsblk
  NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
  loop0         7:0    0 88.7M  1 loop /snap/core/7396
  loop1         7:1    0   18M  1 loop /snap/amazon-ssm-agent/1455
  nvme1n1     259:0    0   40G  0 disk
  └─nvme1n1p1 259:1    0   40G  0 part /
  nvme0n1     259:2    0   41G  0 disk
  root@ip-172-31-2-88:~# sudo file -s /dev/nvme0n1
  /dev/nvme0n1: data
  ```
  Okay, so the `/dev/nvme0n1` contains no files system, and not mounted.  Let's fix this ;
  - Create file-system :
  ```bash
  sudo mkfs -t xfs /dev/nvme0n1
  meta-data=/dev/nvme0n1           isize=512    agcount=4, agsize=2686976 blks
          =                       sectsz=512   attr=2, projid32bit=1
          =                       crc=1        finobt=1, sparse=0, rmapbt=0, reflink=0
  data     =                       bsize=4096   blocks=10747904, imaxpct=25
          =                       sunit=0      swidth=0 blks
  naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
  log      =internal log           bsize=4096   blocks=5248, version=2
          =                       sectsz=512   sunit=0 blks, lazy-count=1
  realtime =none                   extsz=4096   blocks=0, rtextents=0
  ```
  - Create mount-point :
  ```bash
  sudo mkdir /tfe-data
  ```
  - Find out UUID of the block device *( Ubuntu 18.04+ speciifc) :
  ```bash
  lsblk /dev/nvme0n1 -o +UUID
  NAME    MAJ:MIN RM SIZE RO TYPE MOUNTPOINT UUID
  nvme0n1 259:2    0  41G  0 disk            f144a81f-144c-4975-9701-6c9d0692a4a9
  ```
  - Modify fstab (with making backup copy)
  ```bash
  cp /etc/fstab /etc/fstab.original
  ```
  add to /etc/fstab line : 
  ```bash  
  UUID=f144a81f-144c-4975-9701-6c9d0692a4a9  /tfe-data  xfs  defaults,nofail  0  2
  ```
  > Note : If you ever boot your instance without this volume attached (for example, after moving the volume to another instance), the nofail mount option enables the instance to boot even if there are errors mounting the volume.
  - Mount it (using `/etc/fstab` ): 
  ```bash
  mount -a
  ```
  - Let's check : 
  ```bash
  NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
  loop0         7:0    0 88.7M  1 loop /snap/core/7396
  loop1         7:1    0   18M  1 loop /snap/amazon-ssm-agent/1455
  nvme1n1     259:0    0   40G  0 disk
  └─nvme1n1p1 259:1    0   40G  0 part /
  nvme0n1     259:2    0   41G  0 disk /tfe-data  
  ```
  - And we provide that path to installation 

## DSN module tests : 
- Created code [modules/dns_godaddy](modules/dns_godaddy)
- Test code : 
```terraform
module "dns_godaddy" {
  source = "./modules/dns_godaddy"

  host      = "ptfe-pm-1"
  domain    = "guselietov.com"
  record_ip = "192.168.1.3"
}
```
- Terraform init 
- Terraform apply : 
```zsh
terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.dns_godaddy.godaddy_domain_record.dns_godaddy_a_record will be created
  + resource "godaddy_domain_record" "dns_godaddy_a_record" {
      + domain = "guselietov.com"
      + id     = (known after apply)

      + record {
          + data     = "192.168.1.3"
          + name     = "ptfe-pm-1"
          + priority = 0
          + ttl      = 600
          + type     = "A"
        }
      + record {
          + data     = "@"
          + name     = "www"
          + priority = 0
          + ttl      = 3600
          + type     = "CNAME"
        }
      + record {
          + data     = "_domainconnect.gd.domaincontrol.com"
          + name     = "_domainconnect"
          + priority = 0
          + ttl      = 3600
          + type     = "CNAME"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

module.dns_godaddy.godaddy_domain_record.dns_godaddy_a_record: Creating...
module.dns_godaddy.godaddy_domain_record.dns_godaddy_a_record: Creation complete after 6s [id=266392926]
```

## SSL Module test 
- Code of module here : [modules/sslcert_letsencrypt](modules/sslcert_letsencrypt) 
- Test code : 
```terraform
module "sslcert_letsencrypt" {
  source = "./modules/sslcert_letsencrypt"

  host      = var.site_record
  domain    = var.site_domain
} 
```
- Output of apply : 
```zsh
module.dns_godaddy.godaddy_domain_record.dns_godaddy_a_record: Modifying... [id=266392926]
module.sslcert_letsencrypt.acme_certificate.certificate: Creating...
module.dns_godaddy.godaddy_domain_record.dns_godaddy_a_record: Modifications complete after 5s [id=266392926]
module.sslcert_letsencrypt.acme_certificate.certificate: Still creating... [10s elapsed]
module.sslcert_letsencrypt.acme_certificate.certificate: Still creating... [20s elapsed]
module.sslcert_letsencrypt.acme_certificate.certificate: Still creating... [30s elapsed]
module.sslcert_letsencrypt.acme_certificate.certificate: Creation complete after 38s [id=https://acme-v02.api.letsencrypt.org/acme/cert/035a5ed202a09ab4f926a4d99ae50f9bdfb5]

Apply complete! Resources: 1 added, 1 changed, 0 destroyed.

Outputs:

cert_bundle = -----BEGIN CERTIFICATE-----
MIIFajCCBFKgAwIBAgISA1pe0gKgmrT5JqTZmuUPm9+1MA0GCSqGSIb3DQEBCwUA
MEoxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1MZXQncyBFbmNyeXB0MSMwIQYDVQQD
```

## Instance/EBS

- Added code : 
```terraform
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
```
- Apply : 
```bash
module.dns_godaddy.godaddy_domain_record.dns_godaddy_a_record: Modifying... [id=266392926]
aws_instance.ptfe: Destroying... [id=i-0c18602c552c592b5]
module.dns_godaddy.godaddy_domain_record.dns_godaddy_a_record: Still modifying... [id=266392926, 10s elapsed]
aws_instance.ptfe: Still destroying... [id=i-0c18602c552c592b5, 10s elapsed]
module.dns_godaddy.godaddy_domain_record.dns_godaddy_a_record: Still modifying... [id=266392926, 20s elapsed]
aws_instance.ptfe: Still destroying... [id=i-0c18602c552c592b5, 20s elapsed]
module.dns_godaddy.godaddy_domain_record.dns_godaddy_a_record: Modifications complete after 23s [id=266392926]
aws_instance.ptfe: Still destroying... [id=i-0c18602c552c592b5, 30s elapsed]
aws_instance.ptfe: Destruction complete after 30s
aws_instance.ptfe: Creating...
aws_instance.ptfe: Still creating... [10s elapsed]
aws_instance.ptfe: Still creating... [20s elapsed]
aws_instance.ptfe: Still creating... [30s elapsed]
aws_instance.ptfe: Provisioning with 'remote-exec'...
...
aws_instance.ptfe (remote-exec): 0 upgraded, 0 newly installed, 0 to remove and 16 not upgraded.
aws_instance.ptfe: Creation complete after 58s [id=i-0c77aab60aee2a3ca]

Apply complete! Resources: 1 added, 1 changed, 1 destroyed.

Outputs:

cert_bundle = -----BEGIN CERTIFICATE-----
MIIFajCCBFKgAwIBAgISA1pe0gKgmrT5JqTZmuUPm9+1MA0GCSqGSIb3DQEBCwUA
...
cert_url = https://acme-v02.api.letsencrypt.org/acme/cert/asasdasdasdsad
public_dns = ec2-18-194-53-88.eu-central-1.compute.amazonaws.com
public_ip = 18.194.53.88
```

## Main code

- The one thing that is left - is to save Certfificate and Private Key locally. but, to exclude private key from Git repo 
- Added code : 
```terraform
# to make life easier when installing
resource "local_file" "ssl_private_key_file" {
  sensitive_content           = "${module.sslcert_letsencrypt.cert_private_key_pem}"
  filename          = "./site_ssl_private_key.pem"
}

resource "local_file" "ssl_cert_file" {
  sensitive_content           = "${module.sslcert_letsencrypt.cert_pem}"
  filename          = "./site_ssl_cert.pem"
}

resource "local_file" "ssl_cert_bundle_file" {
  sensitive_content           = "${module.sslcert_letsencrypt.cert_bundle}"
  filename          = "./site_ssl_cert_bundle.pem"
}
```
- Modified [.gitgnore](.gitgnore) : 
```
.terraform
terraform.tfstate
terraform.tfstate*
site_ssl_private_key.pem
```
- Applied code, let's  check :
```bash
../ptfe-prodmount-vc-cloud # ls -la
total 272
...
-rwxr-xr-x   1 andrii  staff   1939 Oct 28 15:38 site_ssl_cert.pem
-rwxr-xr-x   1 andrii  staff   3589 Oct 28 15:38 site_ssl_cert_bundle.pem
-rwxr-xr-x   1 andrii  staff   1675 Oct 28 15:38 site_ssl_private_key.pem
...
```
OKay we have certs and keys

## Test
- Create PTFE User Token and add it into config `~/.terraformrc` : 
```terraform
credentials "ptfe-pm-1.guselietov.com" {
  token = "j.........tM" # <-- your token here >
}
```
- Cd to `tf-test` 
- There is code, pre-populated in there for test : 
```terraform
terraform {
  backend "remote" {
    hostname     = "ptfe-pm-1.guselietov.com"
    organization = "acme"

    workspaces {
      name = "playground"
    }
  }
}

resource "null_resource" "helloPTFE" {
  provisioner "local-exec" {
    command = "echo hello world in PTFE"
  }
}
```
- Init :
```bash
terraform init

Initializing the backend...

Successfully configured the backend "remote"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "null" (hashicorp/null) 2.1.2...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.null: version = "~> 2.1"

Terraform has been successfully initialized!

```
- Terraform apply :
```bash
terraform apply
Running apply in the remote backend. Output will stream here. Pressing Ctrl-C
will cancel the remote apply if it's still pending. If the apply started it
will stop streaming the logs, but will not stop the apply running remotely.

Preparing the remote apply...

To view this run in a browser, visit:
https://ptfe-pm-1.guselietov.com/app/acme/playground/runs/run-nm8qhb6uRY5D7Qr3

Waiting for the plan to start...

Terraform v0.12.2

Configuring remote state backend...
Initializing Terraform configuration...
2019/10/29 08:18:40 [DEBUG] Using modified User-Agent: Terraform/0.12.2 TFE/ad6f6a1d83
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # null_resource.helloPTFE will be created
  + resource "null_resource" "helloPTFE" {
      + id = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions in workspace "playground"?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

2019/10/29 08:18:56 [DEBUG] Using modified User-Agent: Terraform/0.12.2 TFE/ad6f6a1d83
null_resource.helloPTFE: Creating...
null_resource.helloPTFE: Provisioning with 'local-exec'...
null_resource.helloPTFE (local-exec): Executing: ["/bin/sh" "-c" "echo hello world in PTFE"]
null_resource.helloPTFE (local-exec): hello world in PTFE
null_resource.helloPTFE: Creation complete after 0s [id=8447053125194314224]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```
Success!

## Changes for install
- Pumped up instance to m5.large
- Modified AWS Security Group to allow traffic on 8800 port
- apparently root volume should have at least 10G total disk space :-( for Docker
.. and 40G for the main APP even if we using Prod MOunt Disk mode 
- Total space requirement met for directory /
  - Directory must have at least 10G total space
- Total space requirement met for directory /var/lib/docker
  - Directory must have at least 40G total space


# TODO

- [ ] create instruction block
- [ ] redeploy PTFE to test instructions
- [ ] update README

# DONE
- [x] define objectives 
- [x] create code for instance deploys and EBS creation
  - [x] DNS module
  - [x] create SSL keys/cert module
  - [x] instance module/code ( including EBS)
  - [x] main code
- [x] install TFE in Prod mode, write down steps
- [ ] add VPC and security group creation

# Notes 

# Technologies

1. **To download the content of this repository** you will need **git command-line tools**(recommended) or **Git UI Client**. To install official command-line Git tools please [find here instructions](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) for various operating systems. 
2. **For managing infrastructure** we using Terraform - open-source infrastructure as a code software tool created by HashiCorp. It enables users to define and provision a data center infrastructure using a high-level configuration language known as Hashicorp Configuration Language, or optionally JSON. More you encouraged to [learn here](https://www.terraform.io). 
3. **This project for virtualization** uses **AWS EC2** - Amazon Elastic Compute Cloud (Amazon EC2 for short) - a web service that provides secure, resizable compute capacity in the cloud. It is designed to make web-scale cloud computing easier for developers. You can read in details and create a free try-out account if you don't have one here :  [Amazon EC2 main page](https://aws.amazon.com/ec2/) 
4. **GoDaddy** - GoDaddy Inc. is an American publicly traded Internet domain registrar and web hosting company, headquartered in Scottsdale, Arizona, and incorporated in Delaware. More information here: https://www.godaddy.com/
5. **Let'sEncrypt** - Let's Encrypt is a non-profit certificate authority run by Internet Security Research Group that provides X.509 certificates for Transport Layer Security encryption at no charge. The certificate is valid for 90 days, during which renewal can take place at any time. You can find out more on their [official page](https://letsencrypt.org/)
