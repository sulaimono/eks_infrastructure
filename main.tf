module "vpc" {
  source = "./modules/aws_vpc"

  project_name            = var.project_name
  aws_region              = var.aws_region
  cidr_block              = var.cidr_block
  pub_subnet1_cidr_block  = var.pub_subnet1_cidr_block
  pub_subnet2_cidr_block  = var.pub_subnet2_cidr_block
  priv_subnet1_cidr_block = var.priv_subnet1_cidr_block
  priv_subnet2_cidr_block = var.priv_subnet2_cidr_block
  k8s_role_elb            = var.k8s_role_elb
  k8s_role_internal_elb   = var.k8s_role_internal_elb
}

module "iam" {
  source = "./modules/aws_iam"

  project_name = var.project_name
}


module "eks" {
  source = "./modules/aws_eks"

  project_name       = var.project_name
  cluster_role_arn   = module.iam.cluster_role_arn
  kubernetes_version = var.kubernetes_version
  node_role_arn      = module.iam.node_role_arn
  priv_subnet1       = module.vpc.priv_subnet1
  priv_subnet2       = module.vpc.priv_subnet2
  depends_on         = [module.iam]
}