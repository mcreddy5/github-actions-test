# fpr provider
aws_region = "us-east-2"
############################ VPC TFVARS #################################
vpc_cidr_block      = "10.60.0.0/16"
pub_sub_azs         = ["us-east-2a", "us-east-2b"]
pub_sub_cidr_block  = ["10.60.8.0/21", "10.60.16.0/21"]
priv_sub_azs        = ["us-east-2a", "us-east-2b"]
priv_sub_cidr_block = ["10.60.24.0/21", "10.60.32.0/21"]
global_route        = "0.0.0.0/0"
env                 = "dev"

sub_count = {
  "public"  = "2"
  "private" = "2"
}
network_tags = {
  "vpc"      = "rev_dev_vpc"
  "priv_sub" = "rev_priv_sub"
  "pub_sub"  = "rev_pub_sub"
  "priv_rt"  = "rev_priv_rt"
  "pub_rt"   = "rev_pub_rt"
}

############################ EC2 TFVARS #################################
#ec2-tfvars
sg_name_ec2 = {
  #"kafka"         = "dev-kafka-sg"
  "pritunl"       = "dev-pritunl-sg"
  "common"        = "dev-common-sg"
  "mongo"         = "dev-mongo-sg"
  "hazelcast"     = "dev-hc-sg"
  "elk"           = "dev-elk-sg"
  "grafana"       = "dev-grafana-sg"
  "mancenter"    = "dev-mancenter-sg"
  "kube"          = "dev-kube-sg"
  "bastion"       = "dev-bastion-sg"
  "private-nginx" = "dev-private-nginx-sg"
  "public-nginx"  = "dev-public-nginx-sg"
  #"mysql"         = "dev-mysql-sg"
  "rmq"           = "dev-rmq-sg"
  "eks_cluster_additional_sg" = "sg-for-dev-eks-cluster-additional-sg"
}
sg_info_ec2 = {
  #"kafka"         = "sg for dev-kafka"
  "pritunl"       = "sg for dev-pritunl server"
  "mongo"         = "sg for dev-mongo nodes"
  "hazelcast"     = "sg for dev-hazelcast"
  "common"        = "sg for dev-common access"
  "elk"           = "sg for dev-elk"
  "grafana"       = "sg for dev-prometheus and grafana"
  "mancenter"    = "sg for dev-mancenter"
  "kube"          = "sg for dev-kube machine"
  "bastion"       = "sg for dev-bastion host"
  "public-nginx"  = "sg for dev-public-nginx"
  #"mysql"         = "sg for dev-mysql"
  "rmq"           = "sg for dev-rmq"
  "eks_cluster_additional_sg" = "sg for dev-eks-cluster-additional-sg "
}

sg_rules_common = {
  ssh_access           = { from = 22, to = 22, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow ssh internally" }
  node_exporter_access = { from = 9100, to = 9100, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow node exporter to prometheus ip" }
}

sg_rules_pritunl = {
  rev_ssh       = { from = 22, to = 22, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow ssh from " }
}

sg_rules_mongo = {
  db_access       = { from = 27017, to = 27017, proto = "tcp", cidr = "0.0.0.0/0" , desc = "Allow db port internally" }
  internal_access = { from = 0, to = 65530, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow internal access" }
}

sg_rules_bastion = {
  rev_ssh_from_pritunl       = { from = 22, to = 22, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow ssh from Pritunl" }
  rev_pritunl_Ui       = { from = 443, to = 443, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow ssh from Pritunl" }
  
}

/* sg_rules_kafka = {
  kafka_access       = { from = 9092, to = 9092, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow kafka access internally" }
  zookeeper_access   = { from = 2181, to = 2181, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow zookeeper access internally" }
  cmak_access        = { from = 9000, to = 9000, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow cmak access internally" }
  # pushgateway_access = { from = 9111, to = 9111, proto = "tcp", cidr = "10.50.35.78/32", desc = "Allow prometheus ip to scrape lag metrics" }
}*/

sg_rules_kube = {
  // pushgateway_access = { from = 9091, to = 9091, proto = "tcp", cidr = "10.50.35.78/32", desc = "Allow prometheus ip to scrape pod metrics" }
}
sg_rules_hazelcast = {
  hc_access         = { from = 5701, to = 5701, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow hazelcast access internally" }
  hc_mcenter_access = { from = 8080, to = 8080, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow hazelcast_mancenter access internally" }
}

sg_rules_public_nginx = {
  http_all_access  = { from = 80, to = 80, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow http to public" }
  https_all_access = { from = 443, to = 443, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow https to public" }
}

sg_rules_grafana = {
  pms_access     = { from = 9090, to = 9090, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow prometheus ui internally" }
  grafana_access = { from = 3000, to = 3000, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow grafana ui internally " }
  alert_access   = { from = 9093, to = 9093, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow alertmanager ui ui internally " }
}

sg_rules_elk = {
  kibana_access   = { from = 5601, to = 5601, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow kibana ui internally" }
  logstash_access = { from = 5044, to = 5044, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow logstash ui internally " }
  alert_access    = { from = 9200, to = 9200, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow elasticsearch ui ui internally " }
}

sg_rules_mancenter = {
  http_all_access_access       = { from = 20, to = 21, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow ftp to public" }
  mancenter_allow_access = { from = 1024, to = 2048, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow access to public" }
}

/*sg_rules_mysql = {
  traffic_port_internal_access       = { from = 3306, to = 3306, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow traffic from VPC" }
}*/

sg_rules_rmq = {
  traffic_port_internal_access       = { from = 5672, to = 5672, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow traffic from VPC" }
  RMQ_UI_Port = { from = 15672, to = 15672, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow traffic from VPC" }
}
# sg_rules_eks_additional_ec2 = {
#    htpps_access       = { from = 443, to = 443, proto = "tcp", cidr = "0.0.0.0/0", desc = "Allow access to kube" }
# }

instance_tags = {
  #"kafka"           = "dev-Kafka"
  "mongo_message"   = "dev-Mongo"
  "hazelcast"       = "dev-Hazelcast"
  "elk"             = "dev-ELK-Stack"
  "grafana"         = "dev-Prometheus-Grafana"
  "mancenter"       = "dev-Mancenter"
  "bastion"         = "dev-Bastion"
  "mongo_ops"       = "dev-Ops-Manager"
  "kube"            = "dev-Kube-Proxy"
  "public-nginx"    = "dev-Public-Nginx"
  "pritunl"         = "dev-Pritunl-Server"
  #"mysql"           = "dev-Mysql-Server"
  "rmq"             = "dev-RMQ-Server"
}
instance_type = {
  #"kafka"           = "t3a.small"
  "mongo_message"   = "m5a.large"
  "hazelcast"       = "t3a.xlarge"
  "elk"             = "t3a.xlarge"
  "grafana"         = "t3a.medium"
  "mancenter"      = "t3a.medium"
  "bastion"         = "t3a.small"
  "mongo_ops"       = "m5a.large"
  "kube"            = "t3a.small"
  "public-nginx"    = "t3a.small"
  "pritunl"         = "t3a.small"
  #"mysql"           = "t3a.small"
  "rmq"             = "m5a.large"
}

instance_count = {
  #"kafka"           = "1"
  "mongo_message"   = "2"
  "hazelcast"       = "1"
}
volume_type = {
  "common" = "gp3"
}
root_vol_size = {
  #"kafka"           = "30"
  "mongo_message"   = "20"
  "hazelcast"       = "20"
  "elk"             = "20"
  "grafana"         = "20"
  "mancenter"       = "20"
  "kube"            = "20"
  "mongo_ops"       = "20"
  "bastion"         = "20"
  "public-nginx"    = "20"
  #"private-nginx"   = "20"
  "pritunl"         = "20"
  #"mysql"           = "20"
  "rmq"             = "20"
}
data_vol_size = {
  #"kafka"           = "100"
  "mongo_message"   = "100"
  "elk"             = "100"
  "grafana"         = "100"
  "mongo_ops"       = "100"
  #"mysql"           = "100"
}
key_name = "rev-dev-env"