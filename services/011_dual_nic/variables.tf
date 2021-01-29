variable "instance_type" {
  default = null
}

variable "vpc_appadmin_subnets" {
  default = null
}

variable "availability_zone" {
  default = null
}

variable "aws_region" {
  default = null
}

variable "aws_profile" {
  default = null
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