# --------------------------------
# FEVO NETWORKING MODULE VARIABLES
# --------------------------------

variable "envrname" {
  description = "Suffix to append to database subnets name"
  type        = string
  default     = "Terraform"
}

variable "tagenvrname" {
  description = "Suffix to append to Tag name"
  type        = string
  default     = ""
}

variable "region" {
  description = "Suffix to append to database subnets name"
  type        = string
  default     = ""
}

variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = []
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = list(string)
  default     = []
}

variable "sgcidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = list(string)
  default     = []
}

variable "secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks to associate with the VPC to extend the IP Address pool"
  type        = list(string)
  default     = []
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
}

//Tags
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
}

variable "app_subnet_tags" {
  description = "Additional tags for the app subnets"
  type        = map(string)
  default     = {}
}

variable "prod_subnet_tags" {
  description = "Additional tags for the Web subnets"
  type        = map(string)
  default     = {}
}

variable "qa_subnet_tags" {
  description = "Additional tags for the Web subnets"
  type        = map(string)
  default     = {}
}

variable "dev_subnet_tags" {
  description = "Additional tags for the Web subnets"
  type        = map(string)
  default     = {}
}

variable "app_security_group_tags" {
  description = "Additional tags for the Security Group"
  type        = map(string)
  default     = {}
}

variable "qa_security_group_tags" {
  description = "Additional tags for the Security Group"
  type        = map(string)
  default     = {}
}

variable "prod_security_group_tags" {
  description = "Additional tags for the Security Group"
  type        = map(string)
  default     = {}
}

variable "dev_security_group_tags" {
  description = "Additional tags for the Security Group"
  type        = map(string)
  default     = {}
}

variable "app_acl_tags" {
  description = "Additional tags for the app subnets network ACL"
  type        = map(string)
  default     = {}
}

variable "prod_acl_tags" {
  description = "Additional tags for the prod subnets network ACL"
  type        = map(string)
  default     = {}
}

variable "qa_acl_tags" {
  description = "Additional tags for the prod subnets network ACL"
  type        = map(string)
  default     = {}
}

variable "dev_acl_tags" {
  description = "Additional tags for the prod subnets network ACL"
  type        = map(string)
  default     = {}
}

variable "app_route_table_tags" {
  description = "Additional tags for the app route tables"
  type        = map(string)
  default     = {}
}

variable "prod_route_table_tags" {
  description = "Additional tags for the prod route tables"
  type        = map(string)
  default     = {}
}

variable "qa_route_table_tags" {
  description = "Additional tags for the qa route tables"
  type        = map(string)
  default     = {}
}

variable "dev_route_table_tags" {
  description = "Additional tags for the dev route tables"
  type        = map(string)
  default     = {}
}

//Suffix

variable "app_subnet_suffix" {
  description = "Suffix to append to WEB subnets name"
  type        = string
  default     = ""
}

variable "prod_subnet_suffix" {
  description = "Suffix to append to API subnets name"
  type        = string
  default     = ""
}

variable "qa_subnet_suffix" {
  description = "Suffix to append to API subnets name"
  type        = string
  default     = ""
}

variable "dev_subnet_suffix" {
  description = "Suffix to append to API subnets name"
  type        = string
  default     = ""
}

//Subnets
variable "app_subnets" {
  description = "A list of web subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "prod_subnets" {
  description = "A list of API subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "qa_subnets" {
  description = "A list of API subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "dev_subnets" {
  description = "A list of API subnets inside the VPC"
  type        = list(string)
  default     = []
}
//SG
variable "app_ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
  }))
  default = []
}

variable "app_egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
  }))
  default = []
}

variable "prod_ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
  }))
  default = []
}


variable "prod_egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
  }))
  default = []
}

variable "qa_ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
  }))
  default = []
}

variable "qa_egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
  }))
  default = []
}

variable "dev_ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
  }))
  default = []
}

variable "dev_egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
  }))
  default = []
}

//ACL
variable "app_inbound_acl_rules" {
  description = "Public subnets inbound network ACLs"
  type        = list(map(string))
  default     = []
}

variable "app_outbound_acl_rules" {
  description = "APP subnets outbound network ACLs"
  type        = list(map(string))
  default     = []
}

variable "prod_inbound_acl_rules" {
  description = "Prod subnets inbound network ACLs"
  type        = list(map(string))

  default = []
}

variable "prod_outbound_acl_rules" {
  description = "Prod subnets outbound network ACLs"
  type        = list(map(string))

  default = []
}

variable "qa_inbound_acl_rules" {
  description = "Private subnets inbound network ACLs"
  type        = list(map(string))

  default = []
}

variable "qa_outbound_acl_rules" {
  description = "Private subnets outbound network ACLs"
  type        = list(map(string))

  default = []
}

variable "dev_inbound_acl_rules" {
  description = "DB subnets inbound network ACLs"
  type        = list(map(string))

  default = []
}

variable "dev_outbound_acl_rules" {
  description = "DB subnets outbound network ACLs"
  type        = list(map(string))

  default = []
}

# -----------
# VPC Peering
# -----------

variable "shared_services_1_acceptor_peering_name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "shared_services_1_acceptor_peering_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
}

variable "shared_services_1_acceptor_alias" {
  description = ""
  type        = string
  default     = ""
}
variable "shared_services_1_acceptor_region" {
  description = ""
  type        = string
  default     = ""
}
variable "shared_services_1_acceptor_profile" {
  description = ""
  type        = string
  default     = ""
}

variable "shared_services_1_acceptor_role_arn" {
  description = ""
  type        = string
  default     = ""
}

variable "shared_services_1_acceptor_session_name" {
  description = ""
  type        = string
  default     = ""
}

variable "shared_services_1_acceptor_session_token" {
  description = ""
  type        = string
  default     = ""
}

variable "shared_services_1_acceptor_shared_credentials_file" {
  description = ""
  type        = string
  default     = ""
}

variable "shared_services_1_acceptor_account_id" {
  description = ""
  type        = string
  default     = ""
}

variable "shared_services_1_peering_name" {
  description = ""
  type        = string
  default     = ""
}

variable "shared_services_1_acceptor_vpc_id" {
  description = ""
  type        = string
  default     = ""
}

variable "shared_services_1_acceptor_vpc_tags" {
  description = ""
  type        = map(string)
  default     = null
}

//Routes

variable "rtsharedservice" {
  default = ""
}
