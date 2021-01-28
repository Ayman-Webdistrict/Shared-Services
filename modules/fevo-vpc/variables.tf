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

variable "appadmin_subnet_tags" {
  description = "Additional tags for the app subnets"
  type        = map(string)
  default     = {}
}

variable "prodman_subnet_tags" {
  description = "Additional tags for the Web subnets"
  type        = map(string)
  default     = {}
}

variable "qaman_subnet_tags" {
  description = "Additional tags for the Web subnets"
  type        = map(string)
  default     = {}
}

variable "devman_subnet_tags" {
  description = "Additional tags for the Web subnets"
  type        = map(string)
  default     = {}
}

variable "appadmin_security_group_tags" {
  description = "Additional tags for the Security Group"
  type        = map(string)
  default     = {}
}

variable "qaman_security_group_tags" {
  description = "Additional tags for the Security Group"
  type        = map(string)
  default     = {}
}

variable "prodman_security_group_tags" {
  description = "Additional tags for the Security Group"
  type        = map(string)
  default     = {}
}

variable "devman_security_group_tags" {
  description = "Additional tags for the Security Group"
  type        = map(string)
  default     = {}
}

variable "appadmin_acl_tags" {
  description = "Additional tags for the app subnets network ACL"
  type        = map(string)
  default     = {}
}

variable "prodman_acl_tags" {
  description = "Additional tags for the prod subnets network ACL"
  type        = map(string)
  default     = {}
}

variable "qaman_acl_tags" {
  description = "Additional tags for the prod subnets network ACL"
  type        = map(string)
  default     = {}
}

variable "devman_acl_tags" {
  description = "Additional tags for the prod subnets network ACL"
  type        = map(string)
  default     = {}
}

variable "appadmin_route_table_tags" {
  description = "Additional tags for the app route tables"
  type        = map(string)
  default     = {}
}

variable "prodman_route_table_tags" {
  description = "Additional tags for the prod route tables"
  type        = map(string)
  default     = {}
}

variable "qaman_route_table_tags" {
  description = "Additional tags for the qa route tables"
  type        = map(string)
  default     = {}
}

variable "devman_route_table_tags" {
  description = "Additional tags for the dev route tables"
  type        = map(string)
  default     = {}
}

//Suffix

variable "appadmin_subnet_suffix" {
  description = "Suffix to append to WEB subnets name"
  type        = string
  default     = ""
}

variable "prodman_subnet_suffix" {
  description = "Suffix to append to API subnets name"
  type        = string
  default     = ""
}

variable "qaman_subnet_suffix" {
  description = "Suffix to append to API subnets name"
  type        = string
  default     = ""
}

variable "devman_subnet_suffix" {
  description = "Suffix to append to API subnets name"
  type        = string
  default     = ""
}

//Subnets
variable "appadmin_subnets" {
  description = "A list of web subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "prodman_subnets" {
  description = "A list of API subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "qaman_subnets" {
  description = "A list of API subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "devman_subnets" {
  description = "A list of API subnets inside the VPC"
  type        = list(string)
  default     = []
}
//SG
variable "appadmin_ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
  }))
  default = []
}

variable "appadmin_egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
  }))
  default = []
}

variable "prodman_ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
  }))
  default = []
}


variable "prodman_egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
  }))
  default = []
}

variable "qaman_ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
  }))
  default = []
}

variable "qaman_egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
  }))
  default = []
}

variable "devman_ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
  }))
  default = []
}

variable "devman_egress_rules" {
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
variable "appadmin_inbound_acl_rules" {
  description = "Public subnets inbound network ACLs"
  type        = list(map(string))
  default     = []
}

variable "appadmin_outbound_acl_rules" {
  description = "APP subnets outbound network ACLs"
  type        = list(map(string))
  default     = []
}

variable "prodman_inbound_acl_rules" {
  description = "Prod subnets inbound network ACLs"
  type        = list(map(string))

  default = []
}

variable "prodman_outbound_acl_rules" {
  description = "Prod subnets outbound network ACLs"
  type        = list(map(string))

  default = []
}

variable "qaman_inbound_acl_rules" {
  description = "Private subnets inbound network ACLs"
  type        = list(map(string))

  default = []
}

variable "qaman_outbound_acl_rules" {
  description = "Private subnets outbound network ACLs"
  type        = list(map(string))

  default = []
}

variable "devman_inbound_acl_rules" {
  description = "DB subnets inbound network ACLs"
  type        = list(map(string))

  default = []
}

variable "devman_outbound_acl_rules" {
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
