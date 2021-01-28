# --------------------------------
# FEVO NETWORKING MODULE PROVIDERS
# --------------------------------

provider "aws" {

  alias   = "peer"
  region  = var.shared_services_1_acceptor_region
  profile = var.shared_services_1_acceptor_profile
  //token = var.shared_services_1_acceptor_session_token

  assume_role {
    role_arn     = var.shared_services_1_acceptor_role_arn
    session_name = "infrastructure-network-cluter-modules-fevo-networking-${terraform.workspace}"
  }

}
