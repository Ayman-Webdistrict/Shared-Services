# ---------------------------------------
# FEVO Networking Terraform module README
#----------------------------------------

* [VPC](https://www.terraform.io/docs/providers/aws/r/vpc.html)
* [Subnet](https://www.terraform.io/docs/providers/aws/r/subnet.html)
* [Route](https://www.terraform.io/docs/providers/aws/r/route.html)
* [Route table](https://www.terraform.io/docs/providers/aws/r/route_table.html)
* [Internet Gateway](https://www.terraform.io/docs/providers/aws/r/internet_gateway.html)
* [Network ACL](https://www.terraform.io/docs/providers/aws/r/network_acl.html)
* [NAT Gateway](https://www.terraform.io/docs/providers/aws/r/nat_gateway.html)
* [DHCP Options Set](https://www.terraform.io/docs/providers/aws/r/vpc_dhcp_options.html)
* [Default VPC](https://www.terraform.io/docs/providers/aws/r/default_vpc.html)
* [Default Network ACL](https://www.terraform.io/docs/providers/aws/r/default_network_acl.html)
* [Security Group] (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)

## Requirements

| Name | Version |
|------|---------|
| terraform | v0.13.4 |
| aws | v3.13.0 |


## Providers

| Name | Version |
|------|---------|
| aws | v3.13.0 |

## Inputs
    source
    envrname
    name
    cidr
    azs
    app_subnets
    prod_subnets
    qa_subnets
    dev_subnets

    peeringname
    enable_peering
    requestor_vpc_id
    acceptor_vpc_id
