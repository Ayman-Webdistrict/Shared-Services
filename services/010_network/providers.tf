# -------------------------
# NETWORK SERVICE PROVIDERS
# -------------------------

terraform {
  backend "remote" {
    organization = "fevo-inc"
    workspaces {
      prefix = "010_network-"
    }
  }
}

provider "aws" {
  region  = local.aws.region
  profile = local.aws.profile

  assume_role {
    role_arn     = local.aws.role_arn
    session_name = "infrastructure-network-010-network-${terraform.workspace}"
  }

}
