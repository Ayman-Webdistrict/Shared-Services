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
  app_subnets             = local.workspace.app.subnets
  app_subnet_tags         = local.workspace.app.subnet_tags
  app_security_group_tags = local.workspace.app.security_group_tags
  app_acl_tags            = local.workspace.app.acl_tags
  app_subnet_suffix       = local.workspace.app.subnet_suffix
  app_ingress_rules       = local.workspace.app.ingress_rules
  app_egress_rules        = local.workspace.app.egress_rules
  app_inbound_acl_rules   = local.workspace.app.inbound_acl_rules
  app_outbound_acl_rules  = local.workspace.app.outbound_acl_rules

  # PRODMAN
  prod_subnets             = local.workspace.prod.subnets
  prod_subnet_tags         = local.workspace.prod.subnet_tags
  prod_security_group_tags = local.workspace.prod.security_group_tags
  prod_acl_tags            = local.workspace.prod.acl_tags
  prod_subnet_suffix       = local.workspace.prod.subnet_suffix
  prod_ingress_rules       = local.workspace.prod.ingress_rules
  prod_egress_rules        = local.workspace.prod.egress_rules
  prod_inbound_acl_rules   = local.workspace.prod.inbound_acl_rules
  prod_outbound_acl_rules  = local.workspace.prod.outbound_acl_rules

  # QAMAN
  qa_subnets             = local.workspace.qa.subnets
  qa_subnet_tags         = local.workspace.qa.subnet_tags
  qa_security_group_tags = local.workspace.qa.security_group_tags
  qa_acl_tags            = local.workspace.qa.acl_tags
  qa_subnet_suffix       = local.workspace.qa.subnet_suffix
  qa_egress_rules        = local.workspace.qa.egress_rules
  qa_ingress_rules       = local.workspace.qa.ingress_rules
  qa_inbound_acl_rules   = local.workspace.qa.inbound_acl_rules
  qa_outbound_acl_rules  = local.workspace.qa.outbound_acl_rules

  # DEVMAN
  dev_subnets             = local.workspace.dev.subnets
  dev_subnet_tags         = local.workspace.dev.subnet_tags
  dev_security_group_tags = local.workspace.dev.security_group_tags
  dev_acl_tags            = local.workspace.dev.acl_tags
  dev_subnet_suffix       = local.workspace.dev.subnet_suffix
  dev_ingress_rules       = local.workspace.dev.ingress_rules
  dev_egress_rules        = local.workspace.dev.egress_rules
  dev_inbound_acl_rules   = local.workspace.dev.inbound_acl_rules
  dev_outbound_acl_rules  = local.workspace.dev.outbound_acl_rules

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
