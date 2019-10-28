# GoDaddy DSN module

A terraform module to create GoDaddy DNS A-record

# Dependency

- Require GoDaddy plugin
- Require initialization of GoDaddy provider and corresponding ENV variable
setting

See [installation](#installation) section below  for more details 

## Inputs
- **record_ip**  *[String]* -  IP address for the record
- **domain**  *[String]* -  Domain for the record
- **host**  *[String]* -  Host part for the record

## Outputs 

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

