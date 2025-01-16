data "aws_region" "current" {}

resource "aws_security_group" "bastion_sg" {
  name        = "${var.project}-${var.environment}-bastion-sg"
  vpc_id      = var.vpc_id
  description = "Security group for bastion host"
  ingress {
    description = "Allow SSH from VPC CIDR"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.vpc_cidr
  }
  egress {
    description = "Allow all traffic to all destinations"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    var.default_tags,
    {
      Name = "${var.project}-${var.environment}-bastion-sg"
    }
  )
}

resource "aws_instance" "bastion_host" {
  # checkov:skip=CKV_AWS_126: "Ensure that detailed monitoring is enabled for EC2 instances"
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  iam_instance_profile   = var.bastion_instance_profile_name
  ebs_optimized          = true

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    encrypted = true
  }

  tags = merge(
    var.default_tags,
    {
      Name = "${var.project}-${var.environment}-bastion-host"
    }
  )
  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum install -y https://s3.${data.aws_region.current.name}.amazonaws.com/amazon-ssm-${data.aws_region.current.name}/latest/linux_amd64/amazon-ssm-agent.rpm
    systemctl enable amazon-ssm-agent
    systemctl start amazon-ssm-agent
    EOF
  )
}
