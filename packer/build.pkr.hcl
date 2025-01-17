#------------------------------------------------------------------------------
# Packer plugin
#------------------------------------------------------------------------------
packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "v1.3.4"
    }
  }
}

#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------
variable "ami_name_prefix" {
  type    = string
  default = "amazon-eks-node"
}

variable "aws_tag_unit" {
  type    = string
  default = "devops"
}

variable "aws_tag_environment" {
  type    = string
  default = "dev"
}

variable "aws_tag_owner" {
  type    = string
  default = "devopslite"
}

variable "aws_tag_project" {
  type    = string
  default = "devopslite"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_id" {
  type    = string
  default = "vpc-08302ac1acf1735dc"
}

variable "public_subnet_id" {
  type    = string
  default = "subnet-05c808767355648a5"
}

variable "communicator" {
  description = "communication method used for instance"
  default     = "ssh"
}

variable "ssh_username" {
  description = "ssh username for packer to use for provisioning"
  default     = "ec2-user"
}

locals {
  timestamp = timestamp()
  date_part = formatdate("YYYYMMDD", local.timestamp)
  time_part = formatdate("HHmmss", local.timestamp)
  ami_name  = "${var.ami_name_prefix}-${local.date_part}-${local.time_part}"
}

#------------------------------------------------------------------------------
# Sources
#------------------------------------------------------------------------------
source "amazon-ebs" "eks_node" {
  ami_description             = "A node AMI used in EKS with Wazuh agent, based on Amazon Linux 2023."
  ami_name                    = local.ami_name
  instance_type               = "t3a.small"
  region                      = var.region
  vpc_id                      = var.vpc_id
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true

  source_ami_filter {
    filters = {
      architecture          = "x86_64"
      name                  = "amazon-eks-node-al2023-x86_64-standard-1.31-*"
      "root-device-type"    = "ebs"
      "virtualization-type" = "hvm"
    }

    most_recent = true
    owners      = ["602401143452"]
  }

  run_tags = {
    Name        = local.ami_name
    Environment = var.aws_tag_environment
    Owners      = var.aws_tag_owner
    Project     = var.aws_tag_project
  }

  run_volume_tags = {
    Name        = local.ami_name
    Environment = var.aws_tag_environment
    Owners      = var.aws_tag_owner
    Project     = var.aws_tag_project
  }

  tags = {
    Name        = local.ami_name
    Environment = var.aws_tag_environment
    Owners      = var.aws_tag_owner
    Project     = var.aws_tag_project
  }

  snapshot_tags = {
    Name        = local.ami_name
    Environment = var.aws_tag_environment
    Owners      = var.aws_tag_owner
    Project     = var.aws_tag_project
  }

  communicator = var.communicator
  ssh_username = var.ssh_username
}

#------------------------------------------------------------------------------
# Build AMI
#------------------------------------------------------------------------------
build {
  sources = ["source.amazon-ebs.eks_node"]

  provisioner "shell" {
    inline = [
      "sudo dnf upgrade -y",
      "sudo rpm --import https://packages.wazuh.com/key/GPG-KEY-WAZUH",
      "sudo bash -c 'cat > /etc/yum.repos.d/wazuh.repo << EOF\n[wazuh]\ngpgcheck=1\ngpgkey=https://packages.wazuh.com/key/GPG-KEY-WAZUH\nenabled=1\nname=EL-\\$releasever - Wazuh\nbaseurl=https://packages.wazuh.com/4.x/yum/\nprotect=1\nEOF'",
      "sudo dnf install -y wazuh-agent",
      "sudo sed -i 's/<address>MANAGER_IP<\\/address>/<address>siem.devopslite.com<\\/address>/g' /var/ossec/etc/ossec.conf",
      "sudo systemctl daemon-reload",
      "sudo systemctl enable wazuh-agent",
      "echo 'Completed install wazuh-agent' > /tmp/wazuh-agent-install.log",
      "cat /tmp/wazuh-agent-install.log",
      "sudo sed -i \"s/^enabled=1/enabled=0/\" /etc/yum.repos.d/wazuh.repo",
    ]
  }
}
