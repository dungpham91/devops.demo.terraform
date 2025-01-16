variable "ami_id" {
  type        = string
  description = "AMI ID for Bastion Host"
}

variable "bastion_instance_profile_name" {
  type        = string
  description = "Name of bastion IAM Instance Profile"
}

variable "default_tags" {
  type        = map(string)
  default     = {}
  description = "The default tags to apply to resources"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "instance_type" {
  type        = string
  description = "Instance type for bastion host"
}

variable "private_subnet_id" {
  type        = string
  description = "ID of the private subnet"
}

variable "project" {
  type        = string
  description = "Project name"
}

variable "vpc_cidr" {
  type        = list(string)
  description = "VPC CIDR"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}
