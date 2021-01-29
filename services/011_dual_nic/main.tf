locals {
  user_data = <<EOF
#!/bin/bash
> .ssh/authorized_keys
sudo sh -c 'echo ec2-user:Linuxawy!1 | chpasswd'
EOF
}

#module "security_group" {
#  source  = "terraform-aws-modules/security-group/aws"
#  version = "~> 3.0"
#
#  name        = "example"
#  description = "Security group for example usage with EC2 instance"
#  vpc_id      = data.aws_vpc.default.id
#
#  ingress_cidr_blocks = ["0.0.0.0/0"]
#  ingress_rules       = ["http-80-tcp", "all-icmp"]
#  egress_rules        = ["all-all"]
#}

resource "aws_network_interface" "this" {
  count = 2
  subnet_id = tolist(data.aws_subnet_ids.all.ids)[count.index]
}

module "ec2" {
  source = "../../modules/ec2-dual-nic/"

  instance_count = 1

  name                        = "example-network"
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  user_data                   = local.user_data
  availability_zone           = "eu-west-1b"
#  key_name                    = "Linuxawy"

  network_interface = [
    {
      device_index          = 0
      network_interface_id  = aws_network_interface.this[0].id
    },
    {
      device_index          = 1
      network_interface_id  = aws_network_interface.this[1].id
    }
  ]
}