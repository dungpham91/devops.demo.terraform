provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source               = "../../modules/vpc"
  aws_region           = var.aws_region
  default_tags         = var.default_tags
  project              = var.project
  environment          = var.environment
  private_subnets_cidr = var.private_subnets_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  vpc_cidr             = var.vpc_cidr
}

module "vpc_endpoint" {
  source          = "../../modules/vpc-endpoint"
  aws_region      = var.aws_region
  default_tags    = var.default_tags
  project         = var.project
  environment     = var.environment
  private_subnets = module.vpc.aws_subnets_private
  route_table_ids = [module.vpc.private_route_table]
  vpc_cidr        = [module.vpc.cidr_block]
  vpc_id          = module.vpc.vpc_id

  depends_on = [module.vpc]
}

module "kms" {
  source       = "../../modules/kms"
  default_tags = var.default_tags
  project      = var.project
  environment  = var.environment
}

module "ssm" {
  source      = "../../modules/ssm"
  project     = var.project
  environment = var.environment
}

module "bastion" {
  source                        = "../../modules/bastion"
  default_tags                  = var.default_tags
  project                       = var.project
  environment                   = var.environment
  ami_id                        = var.bastion_ami_id
  bastion_instance_profile_name = module.ssm.ssm_instance_profile_name
  instance_type                 = var.bation_instance_type
  private_subnet_id             = module.vpc.aws_subnets_private[0]
  vpc_cidr                      = [module.vpc.cidr_block]
  vpc_id                        = module.vpc.vpc_id

  depends_on = [
    module.vpc,
    module.ssm
  ]
}

module "ecr_fe" {
  source          = "../../modules/ecr"
  default_tags    = var.default_tags
  project         = var.project
  environment     = var.environment
  kms_key_arn     = module.kms.kms_arn
  repository_name = "devopslite-fe"

  depends_on = [module.kms]
}

module "ecr_be" {
  source          = "../../modules/ecr"
  default_tags    = var.default_tags
  project         = var.project
  environment     = var.environment
  kms_key_arn     = module.kms.kms_arn
  repository_name = "devopslite-be"

  depends_on = [module.kms]
}

module "eks" {
  source                      = "../../modules/eks"
  default_tags                = var.default_tags
  project                     = var.project
  environment                 = var.environment
  bastion_sg_id               = module.bastion.bastion_sg_id
  vpc_id                      = module.vpc.vpc_id
  vpc_cidr                    = [module.vpc.cidr_block]
  private_subnets             = module.vpc.aws_subnets_private
  eks_cluster_version         = var.eks_cluster_version
  kms_key_arn                 = module.kms.kms_arn
  custom_ami_id               = var.custom_ami_id
  node_group_name             = var.node_group_name
  node_capacity_type          = var.node_capacity_type
  node_instance_type          = var.node_instance_type
  node_group_desired_capacity = var.node_group_desired_capacity
  node_group_min_size         = var.node_group_min_size
  node_group_max_size         = var.node_group_max_size

  depends_on = [
    module.vpc,
    module.kms,
    module.bastion
  ]
}

module "eks_access" {
  source            = "../../modules/eks-access"
  project           = var.project
  environment       = var.environment
  access_entry_type = var.access_entry_type
  access_scope_type = var.access_scope_type
  kubernetes_groups = var.kubernetes_groups
  policy_arn        = var.policy_arn
  principal_arn     = var.principal_arn

  depends_on = [module.eks]
}
