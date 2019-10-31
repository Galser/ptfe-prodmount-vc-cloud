# Example of `terraform destroy` output
```bash

terraform destroy
module.dns_cloudflare.data.cloudflare_zones.site_zone: Refreshing state...
module.sslcert_letsencrypt.tls_private_key.private_key: Refreshing state... [id=f373580c669f2092784aac7e5a9e0f13df0f7436]
module.sslcert_letsencrypt.acme_registration.reg: Refreshing state... [id=https://acme-v02.api.letsencrypt.org/acme/acct/70733663]
module.sslcert_letsencrypt.acme_certificate.certificate: Refreshing state... [id=https://acme-v02.api.letsencrypt.org/acme/cert/038c3155d60a395767d5e9a0763d0bebc2a6]
module.sslcert_letsencrypt.local_file.ssl_cert_file: Refreshing state... [id=124c184f7c5188018e410ab5743cc3eb79936cf1]
module.sslcert_letsencrypt.local_file.ssl_private_key_file: Refreshing state... [id=2c6f2b6cc38c1932e8d0eb8cda31f90eeb50e0b1]
module.sslcert_letsencrypt.local_file.ssl_cert_bundle_file: Refreshing state... [id=b4dcb73038f0108856d981f7df75b1bd96a7357f]
module.vpc_aws.aws_vpc.ag_tfe: Refreshing state... [id=vpc-07c2fd61666754353]
aws_key_pair.ptfe-key: Refreshing state... [id=ptfe-key]
module.vpc_aws.aws_internet_gateway.ag_tfe_GW: Refreshing state... [id=igw-02196b9ece2d7f996]
module.vpc_aws.aws_route_table.ag_tfe_route_table: Refreshing state... [id=rtb-0a8d390b471a0e292]
module.vpc_aws.aws_subnet.ag_tfe_Subnet: Refreshing state... [id=subnet-0a4b7f6d126aeb9ff]
module.vpc_aws.aws_security_group.ag_tfe_Security_Group_elb: Refreshing state... [id=sg-005968ce36451e757]
module.vpc_aws.aws_security_group.ag_tfe_Security_Group: Refreshing state... [id=sg-019f4700d7367ed10]
module.vpc_aws.aws_route.ag_tfe_internet_access: Refreshing state... [id=r-rtb-0a8d390b471a0e2921080289494]
module.vpc_aws.aws_route_table_association.ag_tfe_association: Refreshing state... [id=rtbassoc-066a7b1f8feec0b51]
aws_instance.ptfe: Refreshing state... [id=i-0d3da0bc6ac7fda1e]
module.dns_cloudflare.cloudflare_record.site_backend: Refreshing state... [id=4fe8ec1e083bc8dbe8d2901c3bd37dcd]
aws_elb.ptfe_lb: Refreshing state... [id=ag-tfe-clb]
module.dns_cloudflare.cloudflare_record.site_lb: Refreshing state... [id=624d897993a6490eefd329a2c97a1753]

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_elb.ptfe_lb will be destroyed
  - resource "aws_elb" "ptfe_lb" {
      - arn                         = "arn:aws:elasticloadbalancing:eu-central-1:729476260648:loadbalancer/ag-tfe-clb" -> null
      - availability_zones          = [
          - "eu-central-1a",
        ] -> null
      - connection_draining         = true -> null
      - connection_draining_timeout = 400 -> null
      - cross_zone_load_balancing   = true -> null
      - dns_name                    = "ag-tfe-clb-96443231.eu-central-1.elb.amazonaws.com" -> null
      - id                          = "ag-tfe-clb" -> null
      - idle_timeout                = 400 -> null
      - instances                   = [
          - "i-0d3da0bc6ac7fda1e",
        ] -> null
      - internal                    = false -> null
      - name                        = "ag-tfe-clb" -> null
      - security_groups             = [
          - "sg-005968ce36451e757",
        ] -> null
      - source_security_group       = "729476260648/ag_ptfe_pm-sg-elb" -> null
      - source_security_group_id    = "sg-005968ce36451e757" -> null
      - subnets                     = [
          - "subnet-0a4b7f6d126aeb9ff",
        ] -> null
      - tags                        = {
          - "Name"      = "ptfe-prodmount-andrii"
          - "andriitag" = "true"
          - "learntag"  = "200tf"
        } -> null
      - zone_id                     = "Z215JYRZR1TBD5" -> null

      - health_check {
          - healthy_threshold   = 3 -> null
          - interval            = 30 -> null
          - target              = "TCP:8800" -> null
          - timeout             = 10 -> null
          - unhealthy_threshold = 10 -> null
        }

      - listener {
          - instance_port     = 443 -> null
          - instance_protocol = "tcp" -> null
          - lb_port           = 443 -> null
          - lb_protocol       = "tcp" -> null
        }
      - listener {
          - instance_port     = 8800 -> null
          - instance_protocol = "tcp" -> null
          - lb_port           = 8800 -> null
          - lb_protocol       = "tcp" -> null
        }
    }

  # aws_instance.ptfe will be destroyed
  - resource "aws_instance" "ptfe" {
      - ami                          = "ami-08a162fe1419adb2a" -> null
      - arn                          = "arn:aws:ec2:eu-central-1:729476260648:instance/i-0d3da0bc6ac7fda1e" -> null
      - associate_public_ip_address  = true -> null
      - availability_zone            = "eu-central-1a" -> null
      - cpu_core_count               = 1 -> null
      - cpu_threads_per_core         = 2 -> null
      - disable_api_termination      = false -> null
      - ebs_optimized                = false -> null
      - get_password_data            = false -> null
      - id                           = "i-0d3da0bc6ac7fda1e" -> null
      - instance_state               = "running" -> null
      - instance_type                = "m5.large" -> null
      - ipv6_address_count           = 0 -> null
      - ipv6_addresses               = [] -> null
      - key_name                     = "ptfe-key" -> null
      - monitoring                   = false -> null
      - primary_network_interface_id = "eni-082f640e94387710a" -> null
      - private_dns                  = "ip-10-0-1-110.eu-central-1.compute.internal" -> null
      - private_ip                   = "10.0.1.110" -> null
      - public_dns                   = "ec2-54-93-173-49.eu-central-1.compute.amazonaws.com" -> null
      - public_ip                    = "54.93.173.49" -> null
      - security_groups              = [] -> null
      - source_dest_check            = true -> null
      - subnet_id                    = "subnet-0a4b7f6d126aeb9ff" -> null
      - tags                         = {
          - "Name"      = "ptfe-prodmount-andrii"
          - "andriitag" = "true"
          - "learntag"  = "200tf"
        } -> null
      - tenancy                      = "default" -> null
      - volume_tags                  = {
          - "Name"      = "ptfe-prodmount-andrii"
          - "andriitag" = "true"
        } -> null
      - vpc_security_group_ids       = [
          - "sg-019f4700d7367ed10",
        ] -> null

      - ebs_block_device {
          - delete_on_termination = false -> null
          - device_name           = "/dev/sdg" -> null
          - encrypted             = false -> null
          - iops                  = 123 -> null
          - volume_id             = "vol-08c81ba03e2a7eb3d" -> null
          - volume_size           = 41 -> null
          - volume_type           = "gp2" -> null
        }

      - root_block_device {
          - delete_on_termination = true -> null
          - encrypted             = false -> null
          - iops                  = 120 -> null
          - volume_id             = "vol-08054602dda03da33" -> null
          - volume_size           = 40 -> null
          - volume_type           = "gp2" -> null
        }
    }

  # aws_key_pair.ptfe-key will be destroyed
  - resource "aws_key_pair" "ptfe-key" {
      - fingerprint = "01:ca:46:0b:ea:ba:4e:28:0e:c9:b4:9e:2d:f3:29:66" -> null
      - id          = "ptfe-key" -> null
      - key_name    = "ptfe-key" -> null
      - public_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC704xhVAxg9Bhq0jIbABWVjKl2DW7apvfFj3UtvActT9a9w1Xt5Fa2jEFuzMXceFtpDjgq5j8E8vsrICu8Wpeqwuo2SR2aAjEjBDfJzOM3kmF9wuWdpacDhVm1luPJiqqM4wLAPufht5vhdlqD8QtW/q84MMHbbkXNjdvgqsIcvDWcCRLQDa1Du3ElF9V+/n182ihIDfQCUtQS0zc9lIcUemZMSLRhxAWA9BZYCu8wnUuLBE/fv8apC0NxOayklSBEj7Pk/HxJnYxTeskqGs5MkzHydObPZSnAtX4Hfe1KlmsAVwt6Sj2bG2AYpt9G0jF7Oq9sYQ6nBTMAxENIsmhB andrii@guselietovs-mbp.home" -> null
    }

  # module.dns_cloudflare.cloudflare_record.site_backend will be destroyed
  - resource "cloudflare_record" "site_backend" {
      - created_on  = "2019-10-31T13:15:36.883905Z" -> null
      - data        = {} -> null
      - hostname    = "ptfe-pm-1_backend.guselietov.com" -> null
      - id          = "4fe8ec1e083bc8dbe8d2901c3bd37dcd" -> null
      - metadata    = {
          - "auto_added"             = "false"
          - "managed_by_apps"        = "false"
          - "managed_by_argo_tunnel" = "false"
        } -> null
      - modified_on = "2019-10-31T13:15:36.883905Z" -> null
      - name        = "ptfe-pm-1_backend" -> null
      - priority    = 0 -> null
      - proxiable   = true -> null
      - proxied     = false -> null
      - ttl         = 600 -> null
      - type        = "A" -> null
      - value       = "54.93.173.49" -> null
      - zone_id     = "2032750a75777e59b3bf6c73333ee2b0" -> null
    }

  # module.dns_cloudflare.cloudflare_record.site_lb will be destroyed
  - resource "cloudflare_record" "site_lb" {
      - created_on  = "2019-10-31T13:15:40.633251Z" -> null
      - data        = {} -> null
      - hostname    = "ptfe-pm-1.guselietov.com" -> null
      - id          = "624d897993a6490eefd329a2c97a1753" -> null
      - metadata    = {
          - "auto_added"             = "false"
          - "managed_by_apps"        = "false"
          - "managed_by_argo_tunnel" = "false"
        } -> null
      - modified_on = "2019-10-31T13:15:40.633251Z" -> null
      - name        = "ptfe-pm-1" -> null
      - priority    = 0 -> null
      - proxiable   = true -> null
      - proxied     = false -> null
      - ttl         = 600 -> null
      - type        = "CNAME" -> null
      - value       = "ag-tfe-clb-96443231.eu-central-1.elb.amazonaws.com" -> null
      - zone_id     = "2032750a75777e59b3bf6c73333ee2b0" -> null
    }

  # module.sslcert_letsencrypt.acme_certificate.certificate will be destroyed
  - resource "acme_certificate" "certificate" {
      - account_key_pem    = (sensitive value)
      - certificate_domain = "ptfe-pm-1.guselietov.com" -> null
      - certificate_p12    = (sensitive value)
      - certificate_pem    = "-----BEGIN CERTIFICATE-----\nMIIFaDCCBFCgAwIBAgISA4wxVdYKOVdn1emgdj0L68KmMA0GCSqGSIb3DQEBCwUA\nMEoxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1MZXQncyBFbmNyeXB0MSMwIQYDVQQD\nExpMZXQncyBFbmNyeXB0IEF1dGhvcml0eSBYMzAeFw0xOTEwMzExMjE0NTlaFw0y\nMDAxMjkxMjE0NTlaMCMxITAfBgNVBAMTGHB0ZmUtcG0tMS5ndXNlbGlldG92LmNv\nbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAM5m0EW6FbGrIRtZ/wFj\niA8QT78JX7BoaLBnjSEuqJpwzcq/oMzBQ5Q+oDlnDnVqMGQu4tB3OD/ZqxSKoddm\n8LUx6PKAGqqZ7GEE57qiD3JkMMfvxh+G7cWF+qTjTjmHEKybnHt9XPWJuGQpKoUq\nMRgehl9ULfxRiSa3pwkGx2NxQ8h0yMbxOfxb0QNpTehlMfQFGz2jpxKar0QUWa/m\nUXrUDC+bVZR/5adoVOd99RBB+YmqL3Eb1xEciguFy2hxRYEplj/PdnbSR1COfjE6\nZ1uA6oxo7eYRoP9ZOQS6iZqKM/ZBZPpusnoJ8zfCpwL042wvw48PlZa4B6RUW3/t\nH80CAwEAAaOCAm0wggJpMA4GA1UdDwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEF\nBQcDAQYIKwYBBQUHAwIwDAYDVR0TAQH/BAIwADAdBgNVHQ4EFgQU6Sfd7jfK1Bul\nM+j+6DyNxtIajUgwHwYDVR0jBBgwFoAUqEpqYwR93brm0Tm3pkVl7/Oo7KEwbwYI\nKwYBBQUHAQEEYzBhMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcC5pbnQteDMubGV0\nc2VuY3J5cHQub3JnMC8GCCsGAQUFBzAChiNodHRwOi8vY2VydC5pbnQteDMubGV0\nc2VuY3J5cHQub3JnLzAjBgNVHREEHDAaghhwdGZlLXBtLTEuZ3VzZWxpZXRvdi5j\nb20wTAYDVR0gBEUwQzAIBgZngQwBAgEwNwYLKwYBBAGC3xMBAQEwKDAmBggrBgEF\nBQcCARYaaHR0cDovL2Nwcy5sZXRzZW5jcnlwdC5vcmcwggEEBgorBgEEAdZ5AgQC\nBIH1BIHyAPAAdgBep3P531bA57U2SH3QSeAyepGaDIShEhKEGHWWgXFFWAAAAW4h\n9HXSAAAEAwBHMEUCIQCRWD6rO+XHBixIJP2BF4NpbZ5A2B2BVIPw/l4x/oHdmwIg\neCTadrI+kvtO7/AervNg1NsdYT+tQGi0okuxFkFwjxQAdgAHt1wb5X1o//Gwxh0j\nFce65ld8V5S3au68YToaadOiHAAAAW4h9HZSAAAEAwBHMEUCIArLUDkk4NfHGvDR\nTpyAetmKz/ZoE23LBO0fiwm5V5YrAiEA+Y4YDGvqtxmEEJKI2tjdnDX+C0YMAZ42\nybUjoZ4xxbswDQYJKoZIhvcNAQELBQADggEBAIbcHHPdiHT9O3wiXNX1ghcer/++\nSOD3yHLLhBzScv9j4YYOBGHFb+nflwceGVwvspooxYAq3oAoU6wZyhbvDWkkMpzf\njgJQbFQ4yHzH9aR4y1lE8fwleAaowpFLhB62PFYWe4akSJbaE3MFlDaIgrZWKaCa\nN0LVkHKUwKArdQj92LFUPD/cYKV4Hh+8vhipieiEBG14Tc4gkjhpFf/JhmmHPU7B\nrXEqN9svcIEFjDN6tXVyprni2zkoBoHp+c7UIWGX1+V4vAJKth8pgaHRJ1zCFOZG\nwftpy8uS737x2v+A3IwpjhJ8xjDTH9tpDs34EcseLksLPRXN9/7+cL5N2TY=\n-----END CERTIFICATE-----\n" -> null
      - certificate_url    = "https://acme-v02.api.letsencrypt.org/acme/cert/038c3155d60a395767d5e9a0763d0bebc2a6" -> null
      - common_name        = "ptfe-pm-1.guselietov.com" -> null
      - id                 = "https://acme-v02.api.letsencrypt.org/acme/cert/038c3155d60a395767d5e9a0763d0bebc2a6" -> null
      - issuer_pem         = "-----BEGIN CERTIFICATE-----\nMIIEkjCCA3qgAwIBAgIQCgFBQgAAAVOFc2oLheynCDANBgkqhkiG9w0BAQsFADA/\nMSQwIgYDVQQKExtEaWdpdGFsIFNpZ25hdHVyZSBUcnVzdCBDby4xFzAVBgNVBAMT\nDkRTVCBSb290IENBIFgzMB4XDTE2MDMxNzE2NDA0NloXDTIxMDMxNzE2NDA0Nlow\nSjELMAkGA1UEBhMCVVMxFjAUBgNVBAoTDUxldCdzIEVuY3J5cHQxIzAhBgNVBAMT\nGkxldCdzIEVuY3J5cHQgQXV0aG9yaXR5IFgzMIIBIjANBgkqhkiG9w0BAQEFAAOC\nAQ8AMIIBCgKCAQEAnNMM8FrlLke3cl03g7NoYzDq1zUmGSXhvb418XCSL7e4S0EF\nq6meNQhY7LEqxGiHC6PjdeTm86dicbp5gWAf15Gan/PQeGdxyGkOlZHP/uaZ6WA8\nSMx+yk13EiSdRxta67nsHjcAHJyse6cF6s5K671B5TaYucv9bTyWaN8jKkKQDIZ0\nZ8h/pZq4UmEUEz9l6YKHy9v6Dlb2honzhT+Xhq+w3Brvaw2VFn3EK6BlspkENnWA\na6xK8xuQSXgvopZPKiAlKQTGdMDQMc2PMTiVFrqoM7hD8bEfwzB/onkxEz0tNvjj\n/PIzark5McWvxI0NHWQWM6r6hCm21AvA2H3DkwIDAQABo4IBfTCCAXkwEgYDVR0T\nAQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAYYwfwYIKwYBBQUHAQEEczBxMDIG\nCCsGAQUFBzABhiZodHRwOi8vaXNyZy50cnVzdGlkLm9jc3AuaWRlbnRydXN0LmNv\nbTA7BggrBgEFBQcwAoYvaHR0cDovL2FwcHMuaWRlbnRydXN0LmNvbS9yb290cy9k\nc3Ryb290Y2F4My5wN2MwHwYDVR0jBBgwFoAUxKexpHsscfrb4UuQdf/EFWCFiRAw\nVAYDVR0gBE0wSzAIBgZngQwBAgEwPwYLKwYBBAGC3xMBAQEwMDAuBggrBgEFBQcC\nARYiaHR0cDovL2Nwcy5yb290LXgxLmxldHNlbmNyeXB0Lm9yZzA8BgNVHR8ENTAz\nMDGgL6AthitodHRwOi8vY3JsLmlkZW50cnVzdC5jb20vRFNUUk9PVENBWDNDUkwu\nY3JsMB0GA1UdDgQWBBSoSmpjBH3duubRObemRWXv86jsoTANBgkqhkiG9w0BAQsF\nAAOCAQEA3TPXEfNjWDjdGBX7CVW+dla5cEilaUcne8IkCJLxWh9KEik3JHRRHGJo\nuM2VcGfl96S8TihRzZvoroed6ti6WqEBmtzw3Wodatg+VyOeph4EYpr/1wXKtx8/\nwApIvJSwtmVi4MFU5aMqrSDE6ea73Mj2tcMyo5jMd6jmeWUHK8so/joWUoHOUgwu\nX4Po1QYz+3dszkDqMp4fklxBwXRsW10KXzPMTZ+sOPAveyxindmjkW8lGy+QsRlG\nPfZ+G6Z6h7mjem0Y+iWlkYcV4PIWL1iwBi8saCbGS5jN2p8M+X+Q7UNKEkROb3N6\nKOqkqm57TH2H3eDJAkSnh6/DNFu0Qg==\n-----END CERTIFICATE-----\n" -> null
      - key_type           = "2048" -> null
      - min_days_remaining = 30 -> null
      - must_staple        = false -> null
      - private_key_pem    = (sensitive value)

      - dns_challenge {
          - config   = (sensitive value)
          - provider = "cloudflare" -> null
        }
    }

  # module.sslcert_letsencrypt.acme_registration.reg will be destroyed
  - resource "acme_registration" "reg" {
      - account_key_pem  = (sensitive value)
      - email_address    = "andrii@guselietov.com" -> null
      - id               = "https://acme-v02.api.letsencrypt.org/acme/acct/70733663" -> null
      - registration_url = "https://acme-v02.api.letsencrypt.org/acme/acct/70733663" -> null
    }

  # module.sslcert_letsencrypt.local_file.ssl_cert_bundle_file will be destroyed
  - resource "local_file" "ssl_cert_bundle_file" {
      - directory_permission = "0777" -> null
      - file_permission      = "0777" -> null
      - filename             = "./site_ssl_cert_bundle.pem" -> null
      - id                   = "b4dcb73038f0108856d981f7df75b1bd96a7357f" -> null
      - sensitive_content    = (sensitive value)
    }

  # module.sslcert_letsencrypt.local_file.ssl_cert_file will be destroyed
  - resource "local_file" "ssl_cert_file" {
      - directory_permission = "0777" -> null
      - file_permission      = "0777" -> null
      - filename             = "./site_ssl_cert.pem" -> null
      - id                   = "124c184f7c5188018e410ab5743cc3eb79936cf1" -> null
      - sensitive_content    = (sensitive value)
    }

  # module.sslcert_letsencrypt.local_file.ssl_private_key_file will be destroyed
  - resource "local_file" "ssl_private_key_file" {
      - directory_permission = "0777" -> null
      - file_permission      = "0777" -> null
      - filename             = "./site_ssl_private_key.pem" -> null
      - id                   = "2c6f2b6cc38c1932e8d0eb8cda31f90eeb50e0b1" -> null
      - sensitive_content    = (sensitive value)
    }

  # module.sslcert_letsencrypt.tls_private_key.private_key will be destroyed
  - resource "tls_private_key" "private_key" {
      - algorithm                  = "RSA" -> null
      - ecdsa_curve                = "P224" -> null
      - id                         = "f373580c669f2092784aac7e5a9e0f13df0f7436" -> null
      - private_key_pem            = (sensitive value)
      - public_key_fingerprint_md5 = "4b:14:4d:7f:bb:8b:4a:79:62:66:75:fb:9c:e6:00:75" -> null
      - public_key_openssh         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDebwFUfnlzTRWmCGBPsWHgyBBfiCYCXgyqwPzz6aSEWtJ++54Gv+I5LbTpfer3pepqva3uSHGg8UT0bco70DDXqe6EVUP+35Rfp1B5xL40hAEFFp/juiKoxrSewfOzSgp+/ywSOblMDcbqinG5WOqR6h9aF/q2GKV0KItjNY1cfx1+I/3DbPfLwOkPEJENtgQR92QZ17Rz7dQbwsrFuB8Tz0fUoD9wlUQR59S2pfbmYD23Ew9d+WRferToJ2NSbi/IJzNP9rX8N7eug+PaGjXG0/afnPRU0A+8m45zrsEeWeXdLz+IiiduWvXNRWmqkLe9ly/ydAjzDYRRtZEm2SAx\n" -> null
      - public_key_pem             = "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3m8BVH55c00VpghgT7Fh\n4MgQX4gmAl4MqsD88+mkhFrSfvueBr/iOS206X3q96Xqar2t7khxoPFE9G3KO9Aw\n16nuhFVD/t+UX6dQecS+NIQBBRaf47oiqMa0nsHzs0oKfv8sEjm5TA3G6opxuVjq\nkeofWhf6thildCiLYzWNXH8dfiP9w2z3y8DpDxCRDbYEEfdkGde0c+3UG8LKxbgf\nE89H1KA/cJVEEefUtqX25mA9txMPXflkX3q06CdjUm4vyCczT/a1/De3roPj2ho1\nxtP2n5z0VNAPvJuOc67BHlnl3S8/iIonblr1zUVpqpC3vZcv8nQI8w2EUbWRJtkg\nMQIDAQAB\n-----END PUBLIC KEY-----\n" -> null
      - rsa_bits                   = 2048 -> null
    }

  # module.vpc_aws.aws_internet_gateway.ag_tfe_GW will be destroyed
  - resource "aws_internet_gateway" "ag_tfe_GW" {
      - id       = "igw-02196b9ece2d7f996" -> null
      - owner_id = "729476260648" -> null
      - tags     = {
          - "Name" = "ag_ptfe_pm_internet_gateway"
        } -> null
      - vpc_id   = "vpc-07c2fd61666754353" -> null
    }

  # module.vpc_aws.aws_route.ag_tfe_internet_access will be destroyed
  - resource "aws_route" "ag_tfe_internet_access" {
      - destination_cidr_block = "0.0.0.0/0" -> null
      - gateway_id             = "igw-02196b9ece2d7f996" -> null
      - id                     = "r-rtb-0a8d390b471a0e2921080289494" -> null
      - origin                 = "CreateRoute" -> null
      - route_table_id         = "rtb-0a8d390b471a0e292" -> null
      - state                  = "active" -> null
    }

  # module.vpc_aws.aws_route_table.ag_tfe_route_table will be destroyed
  - resource "aws_route_table" "ag_tfe_route_table" {
      - id               = "rtb-0a8d390b471a0e292" -> null
      - owner_id         = "729476260648" -> null
      - propagating_vgws = [] -> null
      - route            = [
          - {
              - cidr_block                = "0.0.0.0/0"
              - egress_only_gateway_id    = ""
              - gateway_id                = "igw-02196b9ece2d7f996"
              - instance_id               = ""
              - ipv6_cidr_block           = ""
              - nat_gateway_id            = ""
              - network_interface_id      = ""
              - transit_gateway_id        = ""
              - vpc_peering_connection_id = ""
            },
        ] -> null
      - tags             = {
          - "Name" = "ag_ptfe_pm_route_table"
        } -> null
      - vpc_id           = "vpc-07c2fd61666754353" -> null
    }

  # module.vpc_aws.aws_route_table_association.ag_tfe_association will be destroyed
  - resource "aws_route_table_association" "ag_tfe_association" {
      - id             = "rtbassoc-066a7b1f8feec0b51" -> null
      - route_table_id = "rtb-0a8d390b471a0e292" -> null
      - subnet_id      = "subnet-0a4b7f6d126aeb9ff" -> null
    }

  # module.vpc_aws.aws_security_group.ag_tfe_Security_Group will be destroyed
  - resource "aws_security_group" "ag_tfe_Security_Group" {
      - arn                    = "arn:aws:ec2:eu-central-1:729476260648:security-group/sg-019f4700d7367ed10" -> null
      - description            = "ag_ptfe_pm Security Group" -> null
      - egress                 = [
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = ""
              - from_port        = 1024
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 65535
            },
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = ""
              - from_port        = 443
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 443
            },
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = ""
              - from_port        = 80
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 80
            },
        ] -> null
      - id                     = "sg-019f4700d7367ed10" -> null
      - ingress                = [
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = ""
              - from_port        = 22
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 22
            },
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = ""
              - from_port        = 443
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 443
            },
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = ""
              - from_port        = 8800
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 8800
            },
        ] -> null
      - name                   = "ag_ptfe_pm Security Group" -> null
      - owner_id               = "729476260648" -> null
      - revoke_rules_on_delete = false -> null
      - tags                   = {
          - "Name" = "ag_ptfe_pm_security_group"
        } -> null
      - vpc_id                 = "vpc-07c2fd61666754353" -> null
    }

  # module.vpc_aws.aws_security_group.ag_tfe_Security_Group_elb will be destroyed
  - resource "aws_security_group" "ag_tfe_Security_Group_elb" {
      - arn                    = "arn:aws:ec2:eu-central-1:729476260648:security-group/sg-005968ce36451e757" -> null
      - description            = "ag_ptfe_pm ELB Security Group" -> null
      - egress                 = [
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = ""
              - from_port        = 0
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "-1"
              - security_groups  = []
              - self             = false
              - to_port          = 0
            },
        ] -> null
      - id                     = "sg-005968ce36451e757" -> null
      - ingress                = [
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = ""
              - from_port        = 443
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 443
            },
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = ""
              - from_port        = 8800
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 8800
            },
        ] -> null
      - name                   = "ag_ptfe_pm-sg-elb" -> null
      - owner_id               = "729476260648" -> null
      - revoke_rules_on_delete = false -> null
      - tags                   = {} -> null
      - vpc_id                 = "vpc-07c2fd61666754353" -> null
    }

  # module.vpc_aws.aws_subnet.ag_tfe_Subnet will be destroyed
  - resource "aws_subnet" "ag_tfe_Subnet" {
      - arn                             = "arn:aws:ec2:eu-central-1:729476260648:subnet/subnet-0a4b7f6d126aeb9ff" -> null
      - assign_ipv6_address_on_creation = false -> null
      - availability_zone               = "eu-central-1a" -> null
      - availability_zone_id            = "euc1-az2" -> null
      - cidr_block                      = "10.0.1.0/24" -> null
      - id                              = "subnet-0a4b7f6d126aeb9ff" -> null
      - map_public_ip_on_launch         = true -> null
      - owner_id                        = "729476260648" -> null
      - tags                            = {
          - "Name" = "ag_ptfe_pm_subnet"
        } -> null
      - vpc_id                          = "vpc-07c2fd61666754353" -> null
    }

  # module.vpc_aws.aws_vpc.ag_tfe will be destroyed
  - resource "aws_vpc" "ag_tfe" {
      - arn                              = "arn:aws:ec2:eu-central-1:729476260648:vpc/vpc-07c2fd61666754353" -> null
      - assign_generated_ipv6_cidr_block = false -> null
      - cidr_block                       = "10.0.0.0/16" -> null
      - default_network_acl_id           = "acl-075e61321d0b24764" -> null
      - default_route_table_id           = "rtb-0efc9a1a6d9f0766d" -> null
      - default_security_group_id        = "sg-0463a81e22c9ca281" -> null
      - dhcp_options_id                  = "dopt-4f934827" -> null
      - enable_dns_hostnames             = true -> null
      - enable_dns_support               = true -> null
      - id                               = "vpc-07c2fd61666754353" -> null
      - instance_tenancy                 = "default" -> null
      - main_route_table_id              = "rtb-0efc9a1a6d9f0766d" -> null
      - owner_id                         = "729476260648" -> null
      - tags                             = {
          - "Name" = "ag_ptfe_pm"
        } -> null
    }

Plan: 0 to add, 0 to change, 19 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

module.sslcert_letsencrypt.local_file.ssl_private_key_file: Destroying... [id=2c6f2b6cc38c1932e8d0eb8cda31f90eeb50e0b1]
module.sslcert_letsencrypt.local_file.ssl_cert_file: Destroying... [id=124c184f7c5188018e410ab5743cc3eb79936cf1]
module.sslcert_letsencrypt.local_file.ssl_cert_bundle_file: Destroying... [id=b4dcb73038f0108856d981f7df75b1bd96a7357f]
module.sslcert_letsencrypt.local_file.ssl_private_key_file: Destruction complete after 0s
module.sslcert_letsencrypt.local_file.ssl_cert_bundle_file: Destruction complete after 0s
module.sslcert_letsencrypt.local_file.ssl_cert_file: Destruction complete after 0s
module.dns_cloudflare.cloudflare_record.site_backend: Destroying... [id=4fe8ec1e083bc8dbe8d2901c3bd37dcd]
module.dns_cloudflare.cloudflare_record.site_lb: Destroying... [id=624d897993a6490eefd329a2c97a1753]
module.sslcert_letsencrypt.acme_certificate.certificate: Destroying... [id=https://acme-v02.api.letsencrypt.org/acme/cert/038c3155d60a395767d5e9a0763d0bebc2a6]
module.dns_cloudflare.cloudflare_record.site_lb: Destruction complete after 0s
module.dns_cloudflare.cloudflare_record.site_backend: Destruction complete after 0s
module.sslcert_letsencrypt.acme_certificate.certificate: Destruction complete after 1s
module.sslcert_letsencrypt.acme_registration.reg: Destroying... [id=https://acme-v02.api.letsencrypt.org/acme/acct/70733663]
module.vpc_aws.aws_route_table_association.ag_tfe_association: Destroying... [id=rtbassoc-066a7b1f8feec0b51]
module.vpc_aws.aws_route.ag_tfe_internet_access: Destroying... [id=r-rtb-0a8d390b471a0e2921080289494]
aws_elb.ptfe_lb: Destroying... [id=ag-tfe-clb]
module.vpc_aws.aws_route_table_association.ag_tfe_association: Destruction complete after 0s
module.vpc_aws.aws_route.ag_tfe_internet_access: Destruction complete after 0s
module.vpc_aws.aws_internet_gateway.ag_tfe_GW: Destroying... [id=igw-02196b9ece2d7f996]
module.vpc_aws.aws_route_table.ag_tfe_route_table: Destroying... [id=rtb-0a8d390b471a0e292]
module.sslcert_letsencrypt.acme_registration.reg: Destruction complete after 1s
module.sslcert_letsencrypt.tls_private_key.private_key: Destroying... [id=f373580c669f2092784aac7e5a9e0f13df0f7436]
module.sslcert_letsencrypt.tls_private_key.private_key: Destruction complete after 0s
module.vpc_aws.aws_route_table.ag_tfe_route_table: Destruction complete after 0s
aws_elb.ptfe_lb: Destruction complete after 0s
module.vpc_aws.aws_security_group.ag_tfe_Security_Group_elb: Destroying... [id=sg-005968ce36451e757]
aws_instance.ptfe: Destroying... [id=i-0d3da0bc6ac7fda1e]
module.vpc_aws.aws_security_group.ag_tfe_Security_Group_elb: Destruction complete after 9s
module.vpc_aws.aws_internet_gateway.ag_tfe_GW: Still destroying... [id=igw-02196b9ece2d7f996, 10s elapsed]
aws_instance.ptfe: Still destroying... [id=i-0d3da0bc6ac7fda1e, 10s elapsed]
module.vpc_aws.aws_internet_gateway.ag_tfe_GW: Still destroying... [id=igw-02196b9ece2d7f996, 20s elapsed]
aws_instance.ptfe: Still destroying... [id=i-0d3da0bc6ac7fda1e, 20s elapsed]
module.vpc_aws.aws_internet_gateway.ag_tfe_GW: Still destroying... [id=igw-02196b9ece2d7f996, 30s elapsed]
aws_instance.ptfe: Still destroying... [id=i-0d3da0bc6ac7fda1e, 30s elapsed]
module.vpc_aws.aws_internet_gateway.ag_tfe_GW: Still destroying... [id=igw-02196b9ece2d7f996, 40s elapsed]
aws_instance.ptfe: Still destroying... [id=i-0d3da0bc6ac7fda1e, 40s elapsed]
module.vpc_aws.aws_internet_gateway.ag_tfe_GW: Still destroying... [id=igw-02196b9ece2d7f996, 50s elapsed]
aws_instance.ptfe: Still destroying... [id=i-0d3da0bc6ac7fda1e, 51s elapsed]
module.vpc_aws.aws_internet_gateway.ag_tfe_GW: Destruction complete after 56s
aws_instance.ptfe: Still destroying... [id=i-0d3da0bc6ac7fda1e, 1m1s elapsed]
aws_instance.ptfe: Destruction complete after 1m1s
aws_key_pair.ptfe-key: Destroying... [id=ptfe-key]
module.vpc_aws.aws_subnet.ag_tfe_Subnet: Destroying... [id=subnet-0a4b7f6d126aeb9ff]
module.vpc_aws.aws_security_group.ag_tfe_Security_Group: Destroying... [id=sg-019f4700d7367ed10]
aws_key_pair.ptfe-key: Destruction complete after 0s
module.vpc_aws.aws_subnet.ag_tfe_Subnet: Destruction complete after 0s
module.vpc_aws.aws_security_group.ag_tfe_Security_Group: Destruction complete after 0s
module.vpc_aws.aws_vpc.ag_tfe: Destroying... [id=vpc-07c2fd61666754353]
module.vpc_aws.aws_vpc.ag_tfe: Destruction complete after 1s

Destroy complete! Resources: 19 destroyed.

