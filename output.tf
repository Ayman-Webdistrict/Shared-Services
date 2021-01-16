output "ami_id" {
  value = data.aws_ami.ubuntu.id
}

output "squid_user" {
  value = var.squid_user
}

output "squid_password" {
  value = var.squid_pass
}

output "private_ip" {
  value = aws_instance.squid_proxy.*.private_ip
}
output "private_dns" {
  value       = aws_instance.squid_proxy.*.private_dns
}