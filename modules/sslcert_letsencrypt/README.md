# GoDaddy DSN module

A terraform module to create SSL Cert fro the given DNS record in
GoDaddy managed domain

# Dependency

- Require GoDaddy plugin
- Require initialization of GoDaddy provider and corresponding ENV variable
setting
- Require ACME provider initialization

See [installation](#installation) section below  for more details 

## WARNING

Please, do not initialize request first for testing in STAGING then transfer it into PRODUCTION with the same name. This is not going to work. Specific of the implementation of ACME right now is such, that once you've registered technical account in first step in staging, consequent request to create certificate in **prod** will reply you wth URL **containing staging**! And that is terribly wrong. 


## Inputs
- **domain**  *[String]* -  Domain for the record
- **host**  *[String]* -  Host part for the record

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

