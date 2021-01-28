# -------------------------
# NETWORK SERVICE VARIABLES
# -------------------------

variable "aws_profile" {
  default     = null
  description = "AWS Local profile defined at ~/.aws/credentials"
}

variable "aws_region" {
  default     = null
  description = "AWS Region"
}

variable "environment" {
  default     = null
  description = "To be added to every single component deployed"
}

variable "aws_access_key" {
  default     = "xxxxx"
  description = "AWS Access Key"
}

variable "aws_secret_key" {
  default     = ""
  description = "AWS Secret Key"
}

variable "aws_session_token" {
  default     = ""
  description = "AWS Session Token"
}

variable "aws_session_name" {
  default     = "xxxxx"
  description = "AWS Assume Role Session Name"
}

variable "aws_role_arn" {
  default     = "xxxxx"
  description = "AWS Assume Role Arn"
}

variable "vpc_name" {
  default = null
}

variable "vpc_cidr" {
  default     = null
  description = "AWS VPC CIDR. It should be different per region/environment to allow potential VPC Peering"
}

variable "vpc_azs" {
  default     = []
  description = "AWS VPC AZS. For HA should be at least two az."
}

variable "vpc_appadmin_subnets" {
  default     = []
  description = "AWS VPC Subnets for AppAdmin"
}

variable "vpc_prodman_subnets" {
  default     = []
  description = "AWS VPC Subnets for ProdMan"
}

variable "vpc_qaman_subnets" {
  default     = []
  description = "AWS VPC Subnets for QAMan"
}

variable "vpc_devman_subnets" {
  default     = []
  description = "AWS VPC Subnets for DevMan"
}

variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "vpc_peering_name" {
  description = "Name of the VPC Peering"
  default     = ""
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
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

variable "shared_services_1_acceptor_peering_name" {
  description = ""
  type        = string
  default     = ""
}

variable "shared_services_1_acceptor_vpc_id" {
  description = ""
  type        = string
  default     = ""
}
