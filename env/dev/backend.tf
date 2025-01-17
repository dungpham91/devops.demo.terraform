terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.83.1"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.0.6"
    }
  }

  backend "s3" {
    bucket         = "devopslite-dev-tf-state"
    key            = "dev/terraform.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
    dynamodb_table = "devopslite-tf-state"
  }
}
