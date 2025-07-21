output "instances" {
  value = module.demo-ec2.id
}

output "public_ip" {
  value = module.demo-ec2.public_ip
}

output "private_ip" {
  value = module.demo-ec2.private_ip
}
