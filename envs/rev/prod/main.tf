module "vpc" {
  source              = "../../../modules/vpc"
  vpc_cidr_block      = var.vpc_cidr_block
  pub_sub_azs         = var.pub_sub_azs
  pub_sub_cidr_block  = var.pub_sub_cidr_block
  sub_count           = var.sub_count
  network_tags        = var.network_tags
  priv_sub_azs        = var.priv_sub_azs
  priv_sub_cidr_block = var.priv_sub_cidr_block
  global_route        = var.global_route
   env                 = var.env
 
  
}
/*module "ec2" {
  source                 = "../../../modules/ec2"
  vpc_id                 = module.vpc.vpc_id
  env                    = var.env
  sg_name_ec2            = var.sg_name_ec2
  sg_info_ec2            = var.sg_info_ec2  
  sg_rules_common        = var.sg_rules_common
  sg_rules_bastion       = var.sg_rules_bastion
  sg_rules_mongo_ops     = var.sg_rules_mongo_ops
  sg_rules_pritunl       = var.sg_rules_pritunl
  sg_rules_kube          = var.sg_rules_kube
  sg_rules_mancenter     = var.sg_rules_mancenter
  sg_rules_elk           = var.sg_rules_elk
  sg_rules_grafana       = var.sg_rules_grafana
  sg_rules_public_nginx  = var.sg_rules_public_nginx
  sg_rules_hazelcast     = var.sg_rules_hazelcast
  sg_rules_postgresql     = var.sg_rules_postgresql
  sg_rules_rvgpt          = var.sg_rules_rvgpt
  sg_rules_rmq         = var.sg_rules_rmq
  sg_rules_mongo_server = var.sg_rules_mongo_server
  sg_rules_mongo_standalone = var.sg_rules_mongo_standalone
  priv_sub_id            = module.vpc.priv_sub_names[*]
  pub_sub_id             = module.vpc.pub_sub_names[*]
  priv_sub_azs           = module.vpc.priv_sub_azs[*]
  instance_tags          = var.instance_tags
  instance_type          = var.instance_type
  instance_count         = var.instance_count
  data_vol_size          = var.data_vol_size
  root_vol_size          = var.root_vol_size
  volume_type            = var.volume_type
  key_name               = var.key_name
  depends_on = [
    module.vpc
  ]
}*/

module "eks" {
  source                                = "../../../modules/eks"
  environment_name                      = var.environment_name
  cluster_name                          = var.cluster_name
  cluster_version                       = var.cluster_version
 #region                               = var.region
  vpc_id                                = module.vpc.vpc_id
  subnet_ids_for_eks_cluster            = module.vpc.pub_sub_names
  subnet_ids_for_eks_cluster_node_group = module.vpc.priv_sub_names

  eks_cluster_role_name    = var.eks_cluster_role_name
  node_group_iam_role_name = var.node_group_iam_role_name

  default_node_group_name          = var.default_node_group_name
  default_node_group_instance_type = var.default_node_group_instance_type
  default_node_disk_size           = var.default_node_disk_size
  eks_desired_size_default_node    = var.eks_desired_size_default_node
  eks_max_size_default_node        = var.eks_max_size_default_node
  eks_min_size_default_node        = var.eks_min_size_default_node

  node_group_name   = var.node_group_name
  eks_instance_type = var.eks_instance_type
  node_disk_size    = var.node_disk_size
  eks_desired_size  = var.eks_desired_size
  eks_max_size      = var.eks_max_size
  eks_min_size      = var.eks_min_size
  #eks_cluster_node_group_taint_value = var.eks_cluster_node_group_taint_value

  sg_name                 = var.sg_name
  sg_info                 = var.sg_info
  sg_rules_eks_additional = var.sg_rules_eks_additional
 depends_on = [
    module.vpc
  ]
}
