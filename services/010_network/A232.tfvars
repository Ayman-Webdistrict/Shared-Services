# ----------------------
# NETWORK SERVICE TFVARS
# ----------------------

# --------------------------------
# AWS ENVIRONMENT VARIABLES VALUES
# --------------------------------


aws_region   = "us-east-2"
aws_role_arn = "arn:aws:iam::484922075568:role/Admin"
aws_profile  = "fevo-app"


# -----------
# VPC DETAILS
# -----------

environment          = "app"
vpc_name             = "A232"
vpc_cidr             = ["10.30.0.0/16"]
vpc_azs              = ["us-east-2a", "us-east-2c"]
vpc_app_subnets      = ["172.30.20.0/24"]

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
