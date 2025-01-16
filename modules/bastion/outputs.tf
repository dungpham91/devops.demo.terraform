output "bastion_instance_id" {
  value       = aws_instance.bastion_host.id
  description = "The ID of bastion ec2 instance"
}

output "bastion_sg_id" {
  value       = aws_security_group.bastion_sg.id
  description = "The ID of bastion security group"
}
