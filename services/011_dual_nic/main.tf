####################
# EC2 with Dual NIC
####################


module "ec2" {
  source = "../../modules/ec2-dual-nic/"

  instance_count      = 1

  name                = var.environment
  ami                 = data.aws_ami.amazon_linux.id
  instance_type       = local.workspace.etl.instance_type
  user_data           = local.workspace.etl.user_data
  availability_zone   = local.workspace.etl.availability_zone
  subnet_id           = tolist(data.aws_subnet_ids.all.ids)[0]
#  subnet_id           = local.workspace.etl.subnets

}
