# --------------------
# NETWORK SERVICE MAIN
# --------------------

# ----------------------------------------------------
# 1. USES FEVO NETWORKING MODULE TO SETUP BASELINE VPC
# ----------------------------------------------------

module "vpc" {
  source      = "../../modules/fevo-vpc"
  region      = local.aws.region
  envrname    = local.vpc.name
  tagenvrname = local.vpc.environment
  name        = ["APP", "PROD", "QA", "DEV"]
  cidr        = local.vpc.cidr
  azs         = local.vpc.azs
  vpc_tags    = local.vpc.vpc_tags

  # APPMAN
  appadmin_subnets             = local.workspace.appadmin.subnets
  appadmin_subnet_tags         = local.workspace.appadmin.subnet_tags
  appadmin_security_group_tags = local.workspace.appadmin.security_group_tags
  appadmin_acl_tags            = local.workspace.appadmin.acl_tags
  appadmin_subnet_suffix       = local.workspace.appadmin.subnet_suffix
  appadmin_ingress_rules       = local.workspace.appadmin.ingress_rules
  appadmin_egress_rules        = local.workspace.appadmin.egress_rules
  appadmin_inbound_acl_rules   = local.workspace.appadmin.inbound_acl_rules
  appadmin_outbound_acl_rules  = local.workspace.appadmin.outbound_acl_rules

  # PRODMAN
  prodman_subnets             = local.workspace.prodman.subnets
  prodman_subnet_tags         = local.workspace.prodman.subnet_tags
  prodman_security_group_tags = local.workspace.prodman.security_group_tags
  prodman_acl_tags            = local.workspace.prodman.acl_tags
  prodman_subnet_suffix       = local.workspace.prodman.subnet_suffix
  prodman_ingress_rules       = local.workspace.prodman.ingress_rules
  prodman_egress_rules        = local.workspace.prodman.egress_rules
  prodman_inbound_acl_rules   = local.workspace.prodman.inbound_acl_rules
  prodman_outbound_acl_rules  = local.workspace.prodman.outbound_acl_rules

  # QAMAN
  qaman_subnets             = local.workspace.qaman.subnets
  qaman_subnet_tags         = local.workspace.qaman.subnet_tags
  qaman_security_group_tags = local.workspace.qaman.security_group_tags
  qaman_acl_tags            = local.workspace.qaman.acl_tags
  qaman_subnet_suffix       = local.workspace.qaman.subnet_suffix
  qaman_egress_rules        = local.workspace.qaman.egress_rules
  qaman_ingress_rules       = local.workspace.qaman.ingress_rules
  qaman_inbound_acl_rules   = local.workspace.qaman.inbound_acl_rules
  qaman_outbound_acl_rules  = local.workspace.qaman.outbound_acl_rules

  # DEVMAN
  devman_subnets             = local.workspace.devman.subnets
  devman_subnet_tags         = local.workspace.devman.subnet_tags
  devman_security_group_tags = local.workspace.devman.security_group_tags
  devman_acl_tags            = local.workspace.devman.acl_tags
  devman_subnet_suffix       = local.workspace.devman.subnet_suffix
  devman_ingress_rules       = local.workspace.devman.ingress_rules
  devman_egress_rules        = local.workspace.devman.egress_rules
  devman_inbound_acl_rules   = local.workspace.devman.inbound_acl_rules
  devman_outbound_acl_rules  = local.workspace.devman.outbound_acl_rules

  # shared-services-1 peering
  shared_services_1_acceptor_peering_tags            = local.vpc.peering.shared_services_1.acceptor_tags
  shared_services_1_acceptor_region                  = local.vpc.peering.shared_services_1.acceptor_region
  shared_services_1_acceptor_profile                 = local.vpc.peering.shared_services_1.acceptor_profile
  shared_services_1_acceptor_role_arn                = local.vpc.peering.shared_services_1.acceptor_role_arn
  shared_services_1_acceptor_session_name            = local.vpc.peering.shared_services_1.acceptor_session_name
  shared_services_1_acceptor_session_token           = local.vpc.peering.shared_services_1.acceptor_session_token
  shared_services_1_acceptor_shared_credentials_file = local.vpc.peering.shared_services_1.acceptor_shared_credentials_file
  shared_services_1_acceptor_account_id              = local.vpc.peering.shared_services_1.acceptor_account_id
  shared_services_1_acceptor_peering_name            = local.vpc.peering.shared_services_1.acceptor_peering_name
  shared_services_1_acceptor_vpc_tags                = local.vpc.peering.shared_services_1.acceptor_vpc_tags

}
