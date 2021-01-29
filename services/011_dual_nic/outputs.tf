output "ids" {
  description = "List of IDs of instances"
  value       = module.ec2.id
}

output "vpc_security_group_ids" {
  description = "List of VPC security group ids assigned to the instances"
  value       = module.ec2.vpc_security_group_ids
}

output "root_block_device_volume_ids" {
  description = "List of volume IDs of root block devices of instances"
  value       = module.ec2.root_block_device_volume_ids
}

output "ebs_block_device_volume_ids" {
  description = "List of volume IDs of EBS block devices of instances"
  value       = module.ec2.ebs_block_device_volume_ids
}

output "tags" {
  description = "List of tags"
  value       = module.ec2.tags
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = module.ec2.id[0]
}

