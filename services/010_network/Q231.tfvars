# ----------------------
# NETWORK SERVICE TFVARS
# ----------------------

# --------------------------------
# AWS ENVIRONMENT VARIABLES VALUES
# --------------------------------

aws_profile       = "fevo-qa"
aws_region        = "us-east-1"
aws_role_arn      = "arn:aws:iam::195973961332:role/Admin"

# -----------
# VPC DETAILS
# -----------

environment          = "qa"
vpc_name             = "Q231"
vpc_cidr             = ["10.30.0.0/16"]
vpc_azs              = ["us-east-1a", "us-east-1b"]
vpc_qa_subnets       = ["172.30.21.64/26"]

# -------------------
# VPC PEERING DETAILS
# -------------------

shared_services_1_acceptor_profile       = "networking"
shared_services_1_acceptor_peering_name  = "vpc-peering"
shared_services_1_acceptor_region        = "us-east-1"
shared_services_1_acceptor_account_id    = "934898517106"
shared_services_1_acceptor_role_arn      = "arn:aws:iam::934898517106:role/Admin"
shared_services_1_acceptor_session_name  = "peer"
shared_services_1_acceptor_session_token = ""