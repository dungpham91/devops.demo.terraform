variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags to apply to all resources"
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, prod)"
}

variable "private_subnets" {
  type        = list(string)
  description = "List of private subnets"
}

variable "project" {
  type        = string
  description = "Project name"
}


variable "route_table_ids" {
  type        = list(string)
  description = "List of Route Table IDs for VPC Endpoint"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = list(string)
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}
