# GoDaddy DSN module

A terraform module to create VPC and secruity groups for given region
with firewall rules for TFE 

# Dependency

- Require AWS provider initialization

See [installation](#installation) section below  for more details 

## WARNING


## Inputs

- **region** - *string* - AWS region
- **availabilityZone** - *string* - AWS availabilty zone for that region
- **tag** - *string* - tag

## non-mandatory inputs(parameters)
- **instanceTenancy** -  default = "default"
- **dnsSupport** -  default = true
- **dnsHostNames** - default = true
- **vpcCIDRblock** -  default = "10.0.0.0/16"
- **subnetCIDRblock** -  default = "10.0.1.0/24"
- **destinationCIDRblock** -  default = "0.0.0.0/0"
- **ingressCIDRblock** -  *list*  - default = ["0.0.0.0/0"]
- **mapPublicIP** - default = true

## Outputs
- **cert_pem** - *strng* - PEM-encoded Certificate
- **cert_private_key_pem** - *strng* - PEM-encoded private key
- **cert_url** - *strng* - Full certificate URL on  ACEM Let'sEncryt site 
- **cert_issuer_pem** - *strng* - PEM-encoded Issuer Cert
- **cert_bundle** - *strng* - PEM-Encoded bundle

# Installation

- Install GoDaddy plugin :  https://github.com/n3integration/terraform-godaddy
    - Run :
    ```bash
    bash <(curl -s https://raw.githubusercontent.com/n3integration/terraform-godaddy/master/install.sh)
    ```
    - This is going to create plugin binary in `~/.terraform/plugins` , while the recommended path should be `~/.terraform.d/plugins/`, and the name should be in a proper format pattern . let's move and rename it :
    ```bash
    mv ~/.terraform/plugins/terraform-godaddy ~/.terraform.d/plugins/terraform-provider-godaddy
    ```
- Register and export as env variables GoDaddy API keys.
    - Use this link : https://developer.godaddy.com/keys/ ( pay attention that you are creating API KEY IN **production** area)
    - Export them via :
    ```bash
    export GODADDY_API_KEY=MY_KEY
    export GODADDY_API_SECRET=MY_SECRET
    ```
- GoDaddy provider init : 
```terraform
provider "godaddy" {}
```
- ACME provider init example : 
```terraform
remote:      https://github.com/Galser/ptfe-prodmount-vc-cloud/pull/new/f-dns-module
provider "acme" {
  # PRODUCTION
  version    = "~> 1.0"
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
  # STAGING
  # "https://acme-staging-v02.api.letsencrypt.org/directory"
}
```

