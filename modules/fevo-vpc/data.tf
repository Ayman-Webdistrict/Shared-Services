# ---------------------------
# FEVO NETWORKING MODULE DATA
# ---------------------------

# LOOKUP THE ACCEPTOR PEERING VPC ID BASED ON TAGS PROVIDED TO THIS MODULE SO WE DON'T NEED TO ENTER MANUALLY
data "aws_vpc" "shared_services_1_acceptor_vpc_tags" {
  provider = aws.peer
  tags     = var.shared_services_1_acceptor_vpc_tags
}
