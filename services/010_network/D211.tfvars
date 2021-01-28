# ----------------------
# NETWORK SERVICE TFVARS
# ----------------------

# --------------------------------
# AWS ENVIRONMENT VARIABLES VALUES
# --------------------------------

aws_region   = "us-east-1"
aws_role_arn = "arn:aws:iam::844564028558:role/Admin"
aws_profile  = "fevo-dev"

# -----------
# VPC DETAILS
# -----------

environment          = "dev"
vpc_name             = "D211"
vpc_cidr             = ["172.16.21.0/24", "172.17.21.0/24", "172.18.21.0/24", "172.21.0.0/16", "172.19.0.0/16"]
vpc_azs              = ["us-east-1a", "us-east-1b"]
eks_cidr             = "172.21.0.0/16"
vpc_web_subnets      = ["172.16.21.0/25", "172.16.21.128/25"]
vpc_api_subnets      = ["172.17.21.0/25", "172.17.21.128/25"]
vpc_db_subnets       = ["172.18.21.0/25", "172.18.21.128/25"]
vpc_kuberweb_subnets = ["172.21.0.0/20", "172.21.16.0/20"]
vpc_kuberapi_subnets = ["172.21.64.0/18", "172.21.128.0/18"]
vpc_kuberdb_subnets  = ["172.21.32.0/20", "172.21.48.0/20"]
vpc_dmz_subnets      = ["172.19.21.0/27", "172.19.21.32/27"]
vpc_pep_subnets      = ["172.19.255.0/26", "172.19.255.64/26"]
vpc_netman_subnets   = ["172.19.221.0/27", "172.19.221.32/27"]

# --------
# FORTINET
# --------

//fortinet_password = ""
fortinet_public_keypair = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+aQbFgrcSogxv+V3i5YeBXRcugZm1pZEVKA226CdqwuOm5jxpZ74SJli0g+kRcoIqZV5KuFD3YJMb1yJIGv3pwqdjUAhbItM/O/b3mbSVePIgXzTLRl/NlPhpxLxYSoExGJD7b6b+sXqgFQ22gclJMdLqj+SM2iyFIpinKihXvJB3faewkmzrYEPzCc2kmzL0yEqhFxWCWdO3PfpsX/ZGcbyyi6FED/sYgEIXF7xpT3aE1GIY2Xc+KCdYqu7xHTDDkkQgeTFCROG1ZXDuP7EzmbAaMKRUsxbfakTEO284jNYuso5Lhds3wDiZRwRnQikgFfAFgm37M6y1gDqv0puz"


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
