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

# Run-log 

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

# TODO
- [ ] create code for instance deploys and EBS creation
  - [x] DNS module
  - [x] create SSL keys/cert module
  - [x] instance module/code ( including EBS)
  - [ ] main code
- [ ] install TFE in Prod mode, write down steps
- [ ] create instruction block
- [ ] test instructions
- [ ] update README

# DONE
- [x] define objectives 

# Notes 

# Technologies

1. **To download the content of this repository** you will need **git command-line tools**(recommended) or **Git UI Client**. To install official command-line Git tools please [find here instructions](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) for various operating systems. 
2. **For managing infrastructure** we using Terraform - open-source infrastructure as a code software tool created by HashiCorp. It enables users to define and provision a data center infrastructure using a high-level configuration language known as Hashicorp Configuration Language, or optionally JSON. More you encouraged to [learn here](https://www.terraform.io). 
3. **This project for virtualization** uses **AWS EC2** - Amazon Elastic Compute Cloud (Amazon EC2 for short) - a web service that provides secure, resizable compute capacity in the cloud. It is designed to make web-scale cloud computing easier for developers. You can read in details and create a free try-out account if you don't have one here :  [Amazon EC2 main page](https://aws.amazon.com/ec2/) 
4. **GoDaddy** - GoDaddy Inc. is an American publicly traded Internet domain registrar and web hosting company, headquartered in Scottsdale, Arizona, and incorporated in Delaware. More information here: https://www.godaddy.com/
5. **Let'sEncrypt** - Let's Encrypt is a non-profit certificate authority run by Internet Security Research Group that provides X.509 certificates for Transport Layer Security encryption at no charge. The certificate is valid for 90 days, during which renewal can take place at any time. You can find out more on their [official page](https://letsencrypt.org/)
