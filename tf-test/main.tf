
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
