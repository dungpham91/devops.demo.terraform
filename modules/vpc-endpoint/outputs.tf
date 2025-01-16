output "ec2_endpoint_id" {
  description = "ID of EC2 VPC Endpoint"
  value       = aws_vpc_endpoint.ec2.id
}

output "ec2messages_endpoint_id" {
  description = "ID of EC2 Messages VPC Endpoint"
  value       = aws_vpc_endpoint.ec2messages.id
}

output "ecr_api_endpoint_id" {
  description = "ID of ECR API VPC Endpoint"
  value       = aws_vpc_endpoint.ecr_api.id
}

output "ecr_dkr_endpoint_id" {
  description = "ID of ECR DKR VPC Endpoint"
  value       = aws_vpc_endpoint.ecr_dkr.id
}

output "eks_auth_endpoint_id" {
  description = "ID of EKS Auth VPC Endpoint"
  value       = aws_vpc_endpoint.eks_auth.id
}

output "eks_endpoint_id" {
  description = "ID of EKS VPC Endpoint"
  value       = aws_vpc_endpoint.eks.id
}

output "elb_endpoint_id" {
  description = "ID of ELB VPC Endpoint"
  value       = aws_vpc_endpoint.elb.id
}

output "kms_endpoint_id" {
  description = "ID of KMS VPC Endpoint"
  value       = aws_vpc_endpoint.kms.id
}

output "logs_endpoint_id" {
  description = "ID of Cloudwatch Logs VPC Endpoint"
  value       = aws_vpc_endpoint.logs.id
}

output "s3_endpoint_id" {
  description = "ID of S3 VPC Endpoint"
  value       = aws_vpc_endpoint.s3.id
}

output "ssm_endpoint_id" {
  description = "ID of SSM VPC Endpoint"
  value       = aws_vpc_endpoint.ssm.id
}

output "ssmmessages_endpoint_id" {
  description = "ID of SSM Messages VPC Endpoint"
  value       = aws_vpc_endpoint.ssmmessages.id
}

output "sts_endpoint_id" {
  description = "ID of STS VPC Endpoint"
  value       = aws_vpc_endpoint.sts.id
}

output "vpc_endpoint_ids" {
  description = "List of VPC Endpoint Ids"
  value = [
    aws_vpc_endpoint.ec2.id,
    aws_vpc_endpoint.ec2messages.id,
    aws_vpc_endpoint.ecr_api.id,
    aws_vpc_endpoint.ecr_dkr.id,
    aws_vpc_endpoint.eks.id,
    aws_vpc_endpoint.eks_auth.id,
    aws_vpc_endpoint.elb.id,
    aws_vpc_endpoint.kms.id,
    aws_vpc_endpoint.logs.id,
    aws_vpc_endpoint.s3.id,
    aws_vpc_endpoint.ssm.id,
    aws_vpc_endpoint.ssmmessages.id,
    aws_vpc_endpoint.sts.id
  ]
}

output "vpc_endpoint_sg_id" {
  description = "ID of Security Group for VPC Endpoints"
  value       = aws_security_group.vpc_endpoint_sg.id
}
