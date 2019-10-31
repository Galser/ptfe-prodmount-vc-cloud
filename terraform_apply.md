# Example of `terraform apply -auto-approve` output
```bash

 ~/../ptfe-prodmount-vc-cloud  ● terraform apply -auto-approve
module.dns_cloudflare.data.cloudflare_zones.site_zone: Refreshing state...
module.sslcert_letsencrypt.tls_private_key.private_key: Creating...
module.sslcert_letsencrypt.tls_private_key.private_key: Creation complete after 0s [id=f373580c669f2092784aac7e5a9e0f13df0f7436]
module.sslcert_letsencrypt.acme_registration.reg: Creating...
aws_key_pair.ptfe-key: Creating...
module.vpc_aws.aws_vpc.ag_tfe: Creating...
module.sslcert_letsencrypt.acme_registration.reg: Creation complete after 2s [id=https://acme-v02.api.letsencrypt.org/acme/acct/70733663]
module.sslcert_letsencrypt.acme_certificate.certificate: Creating...
aws_key_pair.ptfe-key: Creation complete after 1s [id=ptfe-key]
module.vpc_aws.aws_vpc.ag_tfe: Creation complete after 2s [id=vpc-07c2fd61666754353]
module.vpc_aws.aws_internet_gateway.ag_tfe_GW: Creating...
module.vpc_aws.aws_route_table.ag_tfe_route_table: Creating...
module.vpc_aws.aws_subnet.ag_tfe_Subnet: Creating...
module.vpc_aws.aws_security_group.ag_tfe_Security_Group_elb: Creating...
module.vpc_aws.aws_security_group.ag_tfe_Security_Group: Creating...
module.vpc_aws.aws_route_table.ag_tfe_route_table: Creation complete after 1s [id=rtb-0a8d390b471a0e292]
module.vpc_aws.aws_internet_gateway.ag_tfe_GW: Creation complete after 1s [id=igw-02196b9ece2d7f996]
module.vpc_aws.aws_route.ag_tfe_internet_access: Creating...
module.vpc_aws.aws_subnet.ag_tfe_Subnet: Creation complete after 1s [id=subnet-0a4b7f6d126aeb9ff]
module.vpc_aws.aws_route_table_association.ag_tfe_association: Creating...
module.vpc_aws.aws_route_table_association.ag_tfe_association: Creation complete after 1s [id=rtbassoc-066a7b1f8feec0b51]
module.vpc_aws.aws_route.ag_tfe_internet_access: Creation complete after 1s [id=r-rtb-0a8d390b471a0e2921080289494]
module.vpc_aws.aws_security_group.ag_tfe_Security_Group_elb: Creation complete after 2s [id=sg-005968ce36451e757]
module.vpc_aws.aws_security_group.ag_tfe_Security_Group: Creation complete after 2s [id=sg-019f4700d7367ed10]
aws_instance.ptfe: Creating...
module.sslcert_letsencrypt.acme_certificate.certificate: Still creating... [10s elapsed]
module.sslcert_letsencrypt.acme_certificate.certificate: Creation complete after 12s [id=https://acme-v02.api.letsencrypt.org/acme/cert/038c3155d60a395767d5e9a0763d0bebc2a6]
module.sslcert_letsencrypt.local_file.ssl_cert_bundle_file: Creating...
module.sslcert_letsencrypt.local_file.ssl_private_key_file: Creating...
module.sslcert_letsencrypt.local_file.ssl_cert_file: Creating...
module.sslcert_letsencrypt.local_file.ssl_cert_bundle_file: Creation complete after 0s [id=b4dcb73038f0108856d981f7df75b1bd96a7357f]
module.sslcert_letsencrypt.local_file.ssl_private_key_file: Creation complete after 0s [id=2c6f2b6cc38c1932e8d0eb8cda31f90eeb50e0b1]
module.sslcert_letsencrypt.local_file.ssl_cert_file: Creation complete after 0s [id=124c184f7c5188018e410ab5743cc3eb79936cf1]
aws_instance.ptfe: Still creating... [10s elapsed]
aws_instance.ptfe: Provisioning with 'remote-exec'...
aws_instance.ptfe (remote-exec): Connecting to remote host via SSH...
aws_instance.ptfe (remote-exec):   Host: 54.93.173.49
aws_instance.ptfe (remote-exec):   User: ubuntu
aws_instance.ptfe (remote-exec):   Password: false
aws_instance.ptfe (remote-exec):   Private key: true
aws_instance.ptfe (remote-exec):   Certificate: false
aws_instance.ptfe (remote-exec):   SSH Agent: true
aws_instance.ptfe (remote-exec):   Checking Host Key: false
aws_instance.ptfe: Still creating... [20s elapsed]
aws_instance.ptfe (remote-exec): Connecting to remote host via SSH...
aws_instance.ptfe (remote-exec):   Host: 54.93.173.49
aws_instance.ptfe (remote-exec):   User: ubuntu
aws_instance.ptfe (remote-exec):   Password: false
aws_instance.ptfe (remote-exec):   Private key: true
aws_instance.ptfe (remote-exec):   Certificate: false
aws_instance.ptfe (remote-exec):   SSH Agent: true
aws_instance.ptfe (remote-exec):   Checking Host Key: false
aws_instance.ptfe: Still creating... [30s elapsed]
aws_instance.ptfe (remote-exec): Connecting to remote host via SSH...
aws_instance.ptfe (remote-exec):   Host: 54.93.173.49
aws_instance.ptfe (remote-exec):   User: ubuntu
aws_instance.ptfe (remote-exec):   Password: false
aws_instance.ptfe (remote-exec):   Private key: true
aws_instance.ptfe (remote-exec):   Certificate: false
aws_instance.ptfe (remote-exec):   SSH Agent: true
aws_instance.ptfe (remote-exec):   Checking Host Key: false
aws_instance.ptfe (remote-exec): Connecting to remote host via SSH...
aws_instance.ptfe (remote-exec):   Host: 54.93.173.49
aws_instance.ptfe (remote-exec):   User: ubuntu
aws_instance.ptfe (remote-exec):   Password: false
aws_instance.ptfe (remote-exec):   Private key: true
aws_instance.ptfe (remote-exec):   Certificate: false
aws_instance.ptfe (remote-exec):   SSH Agent: true
aws_instance.ptfe (remote-exec):   Checking Host Key: false
aws_instance.ptfe (remote-exec): Connected!
aws_instance.ptfe: Still creating... [40s elapsed]
aws_instance.ptfe (remote-exec): 36 packages can be upgraded. Run 'apt list --upgradable' to see them.
aws_instance.ptfe (remote-exec): curl is already the newest version (7.58.0-2ubuntu3.8).
aws_instance.ptfe (remote-exec): curl set to manually installed.
aws_instance.ptfe (remote-exec): wget is already the newest version (1.19.4-1ubuntu2.2).
aws_instance.ptfe (remote-exec): wget set to manually installed.
aws_instance.ptfe (remote-exec): 0 upgraded, 0 newly installed, 0 to remove and 36 not upgraded.
aws_instance.ptfe (remote-exec): mkfs.xfs: /dev/nvme0n1 appears to contain a partition table (dos).
aws_instance.ptfe (remote-exec): mkfs.xfs: Use the -f option to force overwrite.
aws_instance.ptfe: Creation complete after 45s [id=i-0d3da0bc6ac7fda1e]
module.dns_cloudflare.cloudflare_record.site_backend: Creating...
aws_elb.ptfe_lb: Creating...
module.dns_cloudflare.cloudflare_record.site_backend: Creation complete after 1s [id=4fe8ec1e083bc8dbe8d2901c3bd37dcd]
aws_elb.ptfe_lb: Creation complete after 4s [id=ag-tfe-clb]
module.dns_cloudflare.cloudflare_record.site_lb: Creating...
module.dns_cloudflare.cloudflare_record.site_lb: Creation complete after 1s [id=624d897993a6490eefd329a2c97a1753]

Apply complete! Resources: 19 added, 0 changed, 0 destroyed.

Outputs:

backend_fqdn = ptfe-pm-1_backend.guselietov.com
cert_url = https://acme-v02.api.letsencrypt.org/acme/cert/038c3155d60a395767d5e9a0763d0bebc2a6
full_site_name = ptfe-pm-1.guselietov.com
loadbalancer_fqdn = ag-tfe-clb-96443231.eu-central-1.elb.amazonaws.com
public_dns = ec2-54-93-173-49.eu-central-1.compute.amazonaws.com
public_ip = 54.93.173.49
```