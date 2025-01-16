resource "aws_security_group" "vpc_endpoint_sg" {
  name        = "${var.project}-${var.environment}-vpc-endpoint-sg"
  vpc_id      = var.vpc_id
  description = "Security Group for VPC Endpoints"

  ingress {
    description = "Allow all traffic to VPC Endpoint"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.vpc_cidr
  }

  egress {
    description = "Allow all traffic to all destinations"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.default_tags,
    {
      Name = "${var.project}-${var.environment}-vpc-endpoint-sg"
    }
  )
}

resource "aws_vpc_endpoint" "ec2" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ec2"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = var.private_subnets
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  tags = merge(
    var.default_tags,
    {
      Name = "${var.project}-${var.environment}-ec2-vpc-endpoint"
    }
  )
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = var.private_subnets
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  tags = merge(
    var.default_tags,
    {
      Name = "${var.project}-${var.environment}-ec2messages-vpc-endpoint"
    }
  )
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ecr.api"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = var.private_subnets
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  tags = merge(
    var.default_tags,
    {
      Name = "${var.project}-${var.environment}-ecr-api-vpc-endpoint"
    }
  )
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = var.private_subnets
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  tags = merge(
    var.default_tags,
    {
      Name = "${var.project}-${var.environment}-ecr-dkr-vpc-endpoint"
    }
  )
}

resource "aws_vpc_endpoint" "eks" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.eks"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = var.private_subnets
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  tags = merge(
    var.default_tags,
    {
      Name = "${var.project}-${var.environment}-eks-vpc-endpoint"
    }
  )
}

resource "aws_vpc_endpoint" "eks_auth" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.eks-auth"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = var.private_subnets
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  tags = merge(
    var.default_tags,
    {
      Name = "${var.project}-${var.environment}-eks-auth-vpc-endpoint"
    }
  )
}

resource "aws_vpc_endpoint" "elb" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.elasticloadbalancing"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = var.private_subnets
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  tags = merge(
    var.default_tags,
    {
      Name = "${var.project}-${var.environment}-elb-vpc-endpoint"
    }
  )
}

resource "aws_vpc_endpoint" "kms" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.kms"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = var.private_subnets
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  tags = merge(
    var.default_tags,
    {
      Name = "${var.project}-${var.environment}-kms-vpc-endpoint"
    }
  )
}

resource "aws_vpc_endpoint" "logs" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.logs"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = var.private_subnets
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  tags = merge(
    var.default_tags,
    {
      Name = "${var.project}-${var.environment}-logs-vpc-endpoint"
    }
  )
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.route_table_ids
  tags = merge(
    var.default_tags,
    {
      Name = "${var.project}-${var.environment}-s3-vpc-endpoint"
    }
  )
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ssm"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = var.private_subnets
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  tags = merge(
    var.default_tags,
    {
      Name = "${var.project}-${var.environment}-ssm-vpc-endpoint"
    }
  )
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = var.private_subnets
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  tags = merge(
    var.default_tags,
    {
      Name = "${var.project}-${var.environment}-ssmmessages-vpc-endpoint"
    }
  )
}

resource "aws_vpc_endpoint" "sts" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.sts"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = var.private_subnets
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  tags = merge(
    var.default_tags,
    {
      Name = "${var.project}-${var.environment}-sts-vpc-endpoint"
    }
  )
}
