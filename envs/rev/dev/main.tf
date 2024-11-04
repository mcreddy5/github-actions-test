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

module "ec2" {
  source                 = "../../../modules/ec2"
  vpc_id                 = module.vpc.vpc_id
  env                    = var.env
  sg_name_ec2            = var.sg_name_ec2
  sg_info_ec2            = var.sg_info_ec2  
  sg_rules_common        = var.sg_rules_common
  sg_rules_bastion       = var.sg_rules_bastion
  sg_rules_mongo         = var.sg_rules_mongo
  #sg_rules_kafka         = var.sg_rules_kafka
  sg_rules_pritunl       = var.sg_rules_pritunl
  sg_rules_kube          = var.sg_rules_kube
  sg_rules_mancenter     = var.sg_rules_mancenter
  sg_rules_elk           = var.sg_rules_elk
  sg_rules_grafana       = var.sg_rules_grafana
  sg_rules_public_nginx  = var.sg_rules_public_nginx
  sg_rules_hazelcast     = var.sg_rules_hazelcast
  #sg_rules_mysql         = var.sg_rules_mysql
  sg_rules_rmq         = var.sg_rules_rmq
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
}
