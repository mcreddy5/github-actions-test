# for provider
aws_region = "us-west-2"
############################ VPC TFVARS #################################
vpc_cidr_block      = "10.100.0.0/16"
pub_sub_azs         = ["us-west-2a","us-west-2b", "us-west-2c"]
pub_sub_cidr_block  = ["10.100.0.0/20","10.100.16.0/20","10.100.32.0/20"]
priv_sub_azs        = ["us-west-2a","us-west-2b", "us-west-2c"]
priv_sub_cidr_block = ["10.100.48.0/20","10.100.64.0/20","10.100.80.0/20"]
global_route        = "0.0.0.0/0"
env                 = "prod-test-rev"


sub_count = {
  "public"  = "3"
  "private" = "3"
}
network_tags = {
  "vpc"      = "vpc-testing-copy"
  "priv_sub" = "priv_sub-rev"
  "pub_sub"  = "pub_sub-rev"
  "priv_rt"  = "priv_rt-rev"
  "pub_rt"   = "pub_rt-rev"
}



############################ EC2 TFVARS #################################
#ec2-tfvars
sg_name_ec2 = {
  "rmq"         = "rmq-sg-prod-test"
  "pritunl"       = "pritunl-sg-prod-test"
  "common"        = "common-sg-prod-test"
  "mongo_ops"     = "mongo-ops-sg-prod-test"
  "hazelcast"     = "Hazelcast-SG"
  "elk"           = "elk-sg-prod-test"
  "grafana"       = "grafana-sg-prod-test"
  "ftp"           = "ftp-sg-prod-test"
  "kube"          = "kube-sg-prod-test"
  "bastion"       = "bastion-sg-prod-test"
  "private-nginx" = "private-nginx-sg-prod-test"
  "public-nginx"  = "public-nginx-sg-prod-test"
  "postgresql"    = "postgresql-sg-prod-test"
  "mancenter"     = "mancenter-sg-prod-test"
  "eks_cluster_additional_sg" = "sg_for_eks_cluster_additional_sg-prod-test"
  "mongo-standalone" = "prod-rev-mongo-stand"
  "mongo-server"     = "prod-rev-mongo-ser-sg"
  "rvgpt"           = "rvgpt-sg-prod"
}
sg_info_ec2 = {
  "rmq"         = "sg for rmq prod-test"
  "pritunl"       = "sg for pritunl server prod-test"
  "mongo_ops"         = "sg for mongo nodes prod-test"
  "hazelcast"     = "sg for hazelcast prod"
  "common"        = "sg for common access prod-test"
  "elk"           = "sg for elk prod-test"
  "grafana"       = "sg for prometheus and grafana prod-test"
  "ftp"           = "sg for public ftp prod-test"
  "kube"          = "sg for kube machine prod-test"
  "bastion"       = "sg for bastion host prod-test"
  "public-nginx"  = "sg for public-nginx prod-test"
  "postgresql"    = "sg for postgresql prod-test"
  "mancenter"     = "sg for manacenter prod-test"
  "eks_cluster_additional_sg" = "sg for eks_cluster_additional_sg  prod-test"
   "mongo-standalone" = "sg for prod mongo standalone server"
    "mongo-server"     = "sg for prod mongo 3 node cluster"
    "rvgpt"            = "sg for rvgpt-service-prod-az"

}

sg_rules_common = {
  ssh_access           = { from = 22, to = 22, proto = "tcp", cidr = "10.50.0.0/16", desc = "Allow ssh internally" }
  node_exporter_access = { from = 9100, to = 9100, proto = "tcp", cidr = "10.50.0.0/16", desc = "Allow node exporter to prometheus ip" }
  push_gateway_access = { from = 9091, to = 9091, proto = "tcp", cidr = "10.50.0.0/16", desc = "for pushgateway" }
  }

sg_rules_pritunl = {
  revlitix_ssh       = { from = 22, to = 22, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow ssh from " }
  revlitix_from_outside = { from = 0, to = 65535, proto = "tcp", cidr = "183.82.105.227/32", desc = "Allow ssh from revlitix" }
  revlitix_ssh_from_pritunl= { from = 443, to = 443, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow ssh from Pritunl" }
  revlitix_https_from_outside = { from = 443, to = 443, proto = "tcp", cidr = "183.82.105.227/32", desc = "Allow https from revlitix" }


}

sg_rules_mongo_ops = {
  db_acces        = { from = 27017, to = 27017, proto = "tcp", cidr = "10.50.0.0/16" , desc = "Allow db port internally" }
  db_access_mongo = { from = 27019, to = 27019, proto = "tcp", cidr = "10.50.0.0/16" , desc = "Allow db port internally" }
  db_access_mon   = { from = 27018, to = 27018, proto = "tcp", cidr = "10.50.0.0/16" , desc = "Allow db port internally" }
  db_access       = { from = 8080, to = 8080, proto = "tcp", cidr = "10.50.0.0/16" , desc = "Allow db port internally" } 
  https_access    = { from = 443, to = 443, proto = "tcp", cidr = "10.50.0.0/16" , desc = "Allow https port internally" } 
  
}
sg_rules_mongo_standalone = {
   db_acces        = { from = 27017, to = 27017, proto = "tcp", cidr = "10.50.0.0/16" , desc = "Allow db port internally" }
}
sg_rules_mongo_server = {
   db_acces        = { from = 27017, to = 27017, proto = "tcp", cidr = "10.50.0.0/16" , desc = "Allow db port internally" }
}

sg_rules_bastion = {
  revlitix_ssh_from_pritunl       = { from = 22, to = 22, proto = "tcp", cidr = "10.50.38.93/32", desc = "Allow ssh from Pritunl" }
}

sg_rules_kube = {
   revlitix_ssh       = { from = 22, to = 22, proto = "tcp", cidr = "10.100.0.0/16", desc = "Allow ssh from " }
}
sg_rules_hazelcast = {
 hc_access         = { from = 5701, to = 5701, proto = "tcp", cidr = "10.50.0.0/16", desc = "Allow hazelcast access internally" }
}
sg_rules_mancenter = {
  hc_mcenter_access = { from = 8080, to = 8080, proto = "tcp", cidr = "10.100.0.0/16", desc = "Allow hazelcast_mancenter access internally" }
  hc_access         = { from = 5701, to = 5701, proto = "tcp", cidr = "10.100.0.0/16", desc = "Allow hazelcast access internally" }
}
sg_rules_public_nginx = {
  http_all_access  = { from = 80, to = 80, proto = "tcp", cidr = "10.100.0.0/16", desc = "Allow http to public" }
  https_all_access = { from = 443, to = 443, proto = "tcp", cidr = "10.100.0.0/16", desc = "Allow https to public" }
}

sg_rules_grafana = {
  pms_access     = { from = 9090, to = 9090, proto = "tcp", cidr = "10.50.0.0/16", desc = "Allow prometheus ui internally" }
  grafana_access = { from = 3000, to = 3000, proto = "tcp", cidr = "10.50.0.0/16", desc = "Allow grafana ui internally " }
  alert_access   = { from = 9093, to = 9093, proto = "tcp", cidr = "10.50.0.0/16", desc = "Allow alertmanager ui ui internally " }
}

sg_rules_elk = {
  kibana_access   = { from = 5601, to = 5601, proto = "tcp", cidr = "10.50.0.0/16", desc = "Allow kibana ui internally" }
  alert_access    = { from = 9200, to = 9200, proto = "tcp", cidr = "10.50.0.0/16", desc = "Allow elasticsearch  ui internally " }
}

sg_rules_ftp = {
  ftp_access       = { from = 20, to = 21, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow ftp to public" }
  ftp_allow_access = { from = 1024, to = 2048, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow access to public" }
}

sg_rules_postgresql = {
  traffic_port_internal_access       = { from = 3306, to = 3306, proto = "tcp", cidr = "10.100.0.0/16", desc = "Allow traffic from VPC" }
  postgres_access       = { from = 5432, to = 5432, proto = "tcp", cidr = "10.100.0.0/16", desc = "Allow traffic from VPC" }
}

sg_rules_rvgpt ={
  global_access_8080      = { from = 8080, to = 8080, proto = "tcp", cidr = "0.0.0.0/0", desc = "all access from 8080" }
  global_access_9000      = { from = 9090, to = 9090, proto = "tcp", cidr = "0.0.0.0/0", desc = "all access from 9000" }
}

sg_rules_rmq = {
  traffic_port_internal_access       = { from = 5672, to = 5672, proto = "tcp", cidr = "10.100.0.0/16", desc = "Allow traffic from VPC" }
  RMQ_UI_Port = { from = 15672, to = 15672, proto = "tcp", cidr = "10.100.0.0/16", desc = "Allow traffic from VPC" }
  RMQ_access = { from = 25672, to = 25672, proto = "tcp", cidr = "10.100.0.0/16", desc = "Allow traffic from VPC" }
  RMQ = { from = 15692, to = 15692, proto = "tcp", cidr = "10.100.0.0/16", desc = "Allow traffic from VPC" }
}
# sg_rules_eks_additional_ec2 = {
#    htpps_access       = { from = 443, to = 443, proto = "tcp", cidr = "10.50.0.0/16", desc = "Allow access to kube" }
# }

instance_tags = {
  "rmq"             = "rmq-prod-test"
  "hazelcast"       = "prod-hazelcast-node-az"
  "elk"             = "ELK-Stack-prod-test"
  "grafana"         = "prod-prome-grafana"
  "ftp"             = "FTP-prod-test"
  "bastion"         = "prod-bastion"
  "mongo_ops"       = "prod-ops-manager"
  "kube"            = "prod-kube-proxy-v1.29"
  "public-nginx"    = "Public-Nginx-prod-test"
  "pritunl"         = "prod-rev-pritunl-vpn-az"
  "postgresql"      = "postgresql-Server-prod-test"
  "mancenter"       = "prod-memcenter" 
  "mongo-standalone" = "prod-rev-mongo-standalone" 
  "mongo-server"    = "prod-rev-mongo-ser-az"
  "rvgpt"           = "rvgpt-service-prod-az"
}
/*instance_type = {
  "rmq"           = "m5.large"
  "hazelcast"       = "m5.xlarge"
  "elk"             = "m5.large"
  "grafana"         = "t3.medium"
  "ftp"             = "t3.medium"
  "bastion"         = "t3.medium"
  "mongo_ops"       = "t3.large"
  "kube"            = "t3.small"
  "public-nginx"    = "t3.small"
  "pritunl"         = "t2.micro"
  "postgresql"      = "m5.large"
  "mancenter"       = "t3.medium"
  "mongo-standalone" = "m5.large"
  "mongo-server"    = "m5.2xlarge"
  "rvgpt"           = "m5.large"
  }*/
  instance_type = {
  "rmq"           = "t3a.medium"
  "hazelcast"       = "t3a.medium"
  "elk"             = "t3a.medium"
  "grafana"         = "t3a.medium"
  "ftp"             = "t3a.medium"
  "bastion"         = "t3a.medium"
  "mongo_ops"       = "t3a.medium"
  "kube"            = "t3a.medium"
  "public-nginx"    = "t3a.medium"
  "pritunl"         = "t2.micro"
  "postgresql"      = "t3a.medium"
  "mancenter"       = "t3a.medium"
  "mongo-standalone" = "t3a.medium"
  "mongo-server"    = "t3a.medium"
  "rvgpt"           = "t3a.medium"
  }


instance_count = {
  "rmq"           = "3"
  "hazelcast"       = "2"
  "mongo-server"      = "3"
}
volume_type = {
  "common" = "gp3"
}
root_vol_size = {
  "rmq"           = "30"
  "hazelcast"       = "30"
  "elk"             = "30"
  "grafana"         = "30"
  "ftp"             = "30"
  "kube"            = "30"
  "mongo_ops"       = "30"
  "bastion"         = "30"
  "public-nginx"    = "30"
  "private-nginx"   = "30"
  "pritunl"         = "30"
  "postgresql"      = "30"
  "mancenter"       = "30"
  "mongo-standalone" = "30"
  "mongo-server"    = "30"
  "rvgpt"           = "25"
}
data_vol_size = {
  "rmq"           = "50"
  "elk"             = "100"
  "grafana"         = "50"
  "mongo_ops"       = "50"
  "postgresql"      = "50"
  "mongo-standalone" = "150"
  "mongo-server"     = "195"
}
key_name = "rev-terraform-githubactions-test"




############################ EKS TFVARS #################################
/*(environment_name                      = "preprod"
cluster_name                          = "preprod-eks-rev-cluster-new"
cluster_version                       = "1.25"
eks_cluster_role_name                 = "preprod-eks-rev-cluster-new"
node_group_iam_role_name              = "preprod-rev-node-group-new"
vpc_id                                = "vpc-0e33710f3ed32083f"
subnet_ids_for_eks_cluster            = ["subnet-0a1d60f3efa9b5ce2", "subnet-09fba2ec5eebd601b", "subnet-05686a6565697b33c", "subnet-0d73748dfdedebc0e", "subnet-037d4f681ac0e5e87", "subnet-08043cc6d51eecf86"]
subnet_ids_for_eks_cluster_node_group = ["subnet-0d73748dfdedebc0e", "subnet-08043cc6d51eecf86",  "subnet-08043cc6d51eecf86"]


default_node_group_name          = "default-rev-node-group-new"
default_node_group_instance_type = ["m5.large"]
default_node_disk_size           = 20
eks_desired_size_default_node    = 1
eks_max_size_default_node        = 2
eks_min_size_default_node        = 1

node_group_name   = ["rev-preprod-eks-preprod-app-group-glad-antelope", "rev-preprod-eks-datascience-node-group-new-test"]
eks_instance_type = ["m5.large", "m5.large"]
node_disk_size    = [20, 20]
eks_desired_size  = [1, 1]
eks_min_size      = [1, 1]
eks_max_size      = [2, 2]
#eks_cluster_node_group_taint_value = ["]
count = length(var.node_group_name)

sg_name = {
  "eks_cluster_additional_sg" = "sg_for_dev_eks_cluster_additional_sg"
}
sg_info = {
  "eks_cluster_additional_sg" = "sg_for_dev_eks_cluster_additional_sg"
}
sg_rules_eks_additional = {
  htpps_access = { from = 443, to = 443, proto = "tcp", cidr = "10.70.49.110/32", desc = "Allow access to kube" },
}*/
