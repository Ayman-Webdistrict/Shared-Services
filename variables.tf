variable aws_reg {
  description = "AWS Region that used to provision these resources"
  default     = "us-west-1"
}

variable "ec2_type" {
  default     = "t2.micro"  
}

variable "squid_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCm6cyarw3OI6zxYWoyKRJ6BcVKmyPmIbPt2T0NLnaSHGXjvDop9eN7ZtmqDiFJhqrGP34iOfCWKB34LPr27Hmr1U533OflFmUJ5NeKHd//RPAgeEd4OYugLWQK5MK8QMAqpHUFt9OOooxbBqQZG5D508P640ehq25Kz9j4b2EAA2YVewvzCGCLCZfaeTQb18+3wcXekKybcGvo/wnNMmEn/DnTRYKeNVNjos+Ta0WahHWhzbZKgCMlEhK03YpP537POVIDhchRM7QpMFhZI7RlVd4g+7Om8YXS0V+OSm9uhyUcyQeGIiR2/uwywewqw/nULUtO3uHkjn80Hn6dIDwmSBPEPRjXcI0Ei6E1saQrcnrXCm4VFyaFCcEJ63WHB/5vhuucfIvPbme8pbbUy3qSu64eRioFaNbQ1vGMIlcfj9knqQEPtT9dJ5vFGn7/L68O+zhulvviJfF+TeRGiV6GNOkR4NNAj5szTP5v+dPvKp+hQVBMoDyB/SfGhBirZYM4YcPr5Wt7i6TFGA02K1h26YDcJNt1OCbjIORVOx7WVq1874uNS7yDvxzoCfGl4jWi1Sx6StDxy7srxixij32R6/49VWxUjEGfonTaTKg3sL4vKrVyo2scPhsv1i+5LZlqAH1yaDoa96vRpzftn4qTbow8JHcBhTzSD/pFrKBxTw== ibrahim.elsayed"
}

variable "ssh_priv_key" {
  default = "~/linuxawy_key"
}

variable "vpc_id" {
  description = "VPC id that used for provision these resources"
}

variable "subnet_id" {
  description = "Subnet id that used for provision the EC2 machine"
}

variable "squid_user" {
  description = "define your squid proxy user"
}

variable "squid_pass" {
  description = "define your squid proxy password"
}