############################
# Additional NIC for the EC2
############################

resource "aws_network_interface" "this" {
 count = local.instance_count * local.interfaces_per_instance
 subnet_id       = var.subnet_id
 #security_groups = var.security_group
 private_ips_count = "1"

 attachment {
  instance     = aws_instance.this[count.index % local.instance_count].id
  device_index = 1
#  instance     = aws_instance.this[count.index % local.instance_count].id
#  device_index = count.index % local.interfaces_per_instance
 }

}