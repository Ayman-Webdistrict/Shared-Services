# --------------------------------------------------------------------
# NETWORK SERVICE LOCALS
# Variables enrichment and default settings for all modules in main.tf
# Locals are the reflection of what modules expect, while its values
# are from user friendly variables from .tfvars
# --------------------------------------------------------------------

locals {

  aws = {

    region = var.aws_region

    #TODO: We shouldn't use profiles, as long as the current profile can assume role
    profile = var.aws_profile

    role_arn     = var.aws_role_arn
    session_name = var.aws_session_name

    #TODO: why do we need to include a session token in the terraform providers?
    session_token = var.aws_session_token

    #TODO: We shouldn't need access_key or secret_key
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key

  }

  vpc = {

    name        = var.vpc_name
    environment = var.environment
    cidr        = var.vpc_cidr
    azs         = var.vpc_azs

    vpc_tags = {
      Environment = var.environment
      Namespace   = "shared-services"
    }

    //peering_name     = var.vpc_peering_name

    app_route_table_tags = {
      Environment = var.environment
      Namespace   = "shared-services"
    }

    prod_route_table_tags = {
      Environment = var.environment
      Namespace   = "shared-services"
    }

    qa_route_table_tags = {
      Environment = var.environment
      Namespace   = "shared-services"
    }

    dev_route_table_tags = {
      Environment = var.environment
      Namespace   = "shared-services"
    }

    peering = {
      # WE MIGHT HAVE MORE SHARED SERVICES PEERING IN THE FUTURE, NAME IT ACCORDINGLY.
      shared_services_1 = {
        acceptor_region                  = var.shared_services_1_acceptor_region
        acceptor_profile                 = var.shared_services_1_acceptor_profile
        acceptor_role_arn                = var.shared_services_1_acceptor_role_arn
        acceptor_session_name            = var.shared_services_1_acceptor_session_name
        acceptor_session_token           = var.shared_services_1_acceptor_session_token
        acceptor_shared_credentials_file = var.shared_services_1_acceptor_shared_credentials_file
        acceptor_account_id              = var.shared_services_1_acceptor_account_id
        acceptor_peering_name            = var.shared_services_1_acceptor_peering_name

        # TO LOOKUP ACCEPTOR VPC ID WHERE THE PEERING WILL BE SET
        acceptor_vpc_tags = {
          Namespace = "shared-services-1"
        }

        acceptor_tags = {
          Environment = var.environment
          Namespace   = "shared-services"
        }
      }
    }

  }

  env = {

    appadmin = {

      # ------
      # APP Admin
      # ------

      appadmin = {

        subnets = var.vpc_appadmin_subnets

        subnet_tags = {
          Environment  = var.environment
          Namespace    = "AppAdmin"
          Tier         = "app"
        }

        acl_tags = {
          Environment = var.environment
          Namespace   = "AppAdmin"
          Tier        = "app"
        }

        security_group_tags = {
          Environment = var.environment
          Namespace   = "AppAdmin"
          Tier        = "app"
        }

        subnet_suffix = "app"

        ingress_rules = [
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "172.30.21.0/24"
            description = "Permit traffic from Shared Services"
          },
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "172.30.23.0/24"
            description = "Permit traffic from Shared Services"
          },
        ]

        egress_rules = [
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "0.0.0.0/0"
            description = "Permit traffic to ANY"
          },
        ]

        inbound_acl_rules = [
          {
            rule_number = 100
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "172.30.21.0/24"
          },
          {
            rule_number = 101
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "172.30.23.0/24"
          },
        ]

        outbound_acl_rules = [
          {
            rule_number = 100
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "0.0.0.0/0"
          },
        ]
      }
    }

    qa = {

      # ------
      # QA MAN
      # ------

      qa = {

        subnets = var.vpc_qaman_subnets

        subnet_tags = {
          Environment  = var.environment
          Namespace    = "QAMan"
          Tier         = "qa"
        }

        acl_tags = {
          Environment = var.environment
          Namespace   = "QAMan"
          Tier        = "qa"
        }

        security_group_tags = {
          Environment = var.environment
          Namespace   = "QAMan"
          Tier        = "qa"
        }

        subnet_suffix = "qa"

        ingress_rules = [
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "172.30.21.64/26"
            description = "Permit traffic from Shared Services"
          },
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "172.16.96.0/18"
            description = "Permit traffic from TGW"
          },
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "172.17.96.0/18"
            description = "Permit traffic from TGW"
          },
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "172.18.96.0/18"
            description = "Permit traffic from TGW"
          },
        ]

        egress_rules = [
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "172.30.21.64/26"
            description = "Permit traffic TO Shared Services"
          },
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "172.16.96.0/18"
            description = "Permit traffic TO TGW"
          },
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "172.17.96.0/18"
            description = "Permit traffic TO TGW"
          },
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "172.18.96.0/18"
            description = "Permit traffic TO TGW"
          },
        ]

        inbound_acl_rules = [
          {
            rule_number = 100
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "172.30.21.64/26"
          },
          {
            rule_number = 101
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "172.16.96.0/18"
          },
          {
            rule_number = 102
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "172.17.96.0/18"
          },
          {
            rule_number = 103
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "172.18.96.0/18"
          },
        ]

        outbound_acl_rules = [
          {
            rule_number = 100
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "172.30.21.64/26"
          },
          {
            rule_number = 101
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "172.16.96.0/18"
          },
          {
            rule_number = 102
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "172.17.96.0/18"
          },
          {
            rule_number = 103
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "172.18.96.0/18"
          },
        ]
      }

    }

    dev = {

      # ------
      # Dev MAN
      # ------

      dev = {

        subnets = var.vpc_devman_subnets

        subnet_tags = {
          Environment  = var.environment
          Namespace    = "DevMan"
          Tier         = "dev"
        }

        acl_tags = {
          Environment = var.environment
          Namespace   = "DevMan"
          Tier        = "dev"
        }

        security_group_tags = {
          Environment = var.environment
          Namespace   = "DevMan"
          Tier        = "dev"
        }

        subnet_suffix = "dev"

        ingress_rules = [
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "172.30.21.128/26"
            description = "Permit traffic from Shared Services"
          },
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "172.16.0.0/18"
            description = "Permit traffic from TGW"
          },
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "172.17.0.0/18"
            description = "Permit traffic from TGW"
          },
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "172.18.0.0/18"
            description = "Permit traffic from TGW"
          },
        ]

        egress_rules = [
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "172.30.21.128/26"
            description = "Permit traffic from Shared Services"
          },
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "172.16.0.0/18"
            description = "Permit traffic from TGW"
          },
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "172.17.0.0/18"
            description = "Permit traffic from TGW"
          },
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "172.18.0.0/18"
            description = "Permit traffic from TGW"
          },
        ]

        inbound_acl_rules = [
          {
            rule_number = 100
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "172.30.21.128/26"
          },
          {
            rule_number = 101
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "172.16.0.0/18"
          },
          {
            rule_number = 102
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "172.17.0.0/18"
          },
          {
            rule_number = 103
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "172.18.0.0/18"
          },
        ]

        outbound_acl_rules = [
          {
            rule_number = 100
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "172.30.21.128/26"
          },
          {
            rule_number = 101
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "172.16.0.0/18"
          },
          {
            rule_number = 102
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "172.17.0.0/18"
          },
          {
            rule_number = 103
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "172.18.0.0/18"
          },
        ]
      }
    }

    prodman = {

      # ------
      # PROD MAN
      # ------

      prodman = {

        subnets = var.vpc_prodman_subnets

        subnet_tags = {
          Environment  = var.environment
          Namespace    = "PRODMan"
          Tier         = "prod"
        }

        acl_tags = {
          Environment = var.environment
          Namespace   = "PRODMan"
          Tier        = "prod"
        }

        security_group_tags = {
          Environment = var.environment
          Namespace   = "PRODMan"
          Tier        = "prod"
        }

        subnet_suffix = "prod"

        ingress_rules = [
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "172.30.21.0/26"
            description = "Permit traffic from Shared Services"
          },
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "10.0.0.0/8"
            description = "Permit traffic from TGW"
          },
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "22.0.0.0/8"
            description = "Permit traffic from TGW"
          },
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "33.0.0.0/8"
            description = "Permit traffic from TGW"
          },
        ]

        egress_rules = [
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "172.30.21.0/26"
            description = "Permit traffic from Shared Services"
          },
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "10.0.0.0/8"
            description = "Permit traffic from TGW"
          },
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "22.0.0.0/8"
            description = "Permit traffic from TGW"
          },
          {
            from_port   = -1
            to_port     = -1
            protocol    = "-1"
            cidr_block  = "33.0.0.0/8"
            description = "Permit traffic from TGW"
          },
        ]

        inbound_acl_rules = [
          {
            rule_number = 100
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "172.30.21.0/26"
          },
          {
            rule_number = 101
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "10.0.0.0/8"
          },
          {
            rule_number = 102
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "22.0.0.0/8"
          },
          {
            rule_number = 103
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "33.0.0.0/8"
          },
        ]

        outbound_acl_rules = [
          {
            rule_number = 100
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "172.30.21.0/26"
          },
          {
            rule_number = 101
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "10.0.0.0/8"
          },
          {
            rule_number = 102
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "22.0.0.0/8"
          },
          {
            rule_number = 103
            rule_action = "allow"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_block  = "33.0.0.0/8"
          },
        ]
      }
    }

  }
}
