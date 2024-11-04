variable "vpc_id" {
  type = string
}
variable "sg_name_ec2" {
  type = map
}
variable "sg_info_ec2" {
  type = map
}
variable "sg_rules_common" {
  type = map
}
variable "sg_rules_bastion" {
  type = map
}
variable "sg_rules_mongo_ops" {
  type = map
}
variable "sg_rules_mongo_standalone" {
  type = map
  }
  variable "sg_rules_mongo_server" {
    type = map
    
  }
variable "sg_rules_rmq" {
  type = map
}  
variable "sg_rules_pritunl" {
  type = map  
}
variable "sg_rules_kube" {
  type = map
}
variable "sg_rules_mancenter" {
  type = map
}
variable "sg_rules_elk" {
  type = map
}
variable "sg_rules_grafana" {
  type = map
}
variable "sg_rules_public_nginx" {
  type = map
}
variable "sg_rules_hazelcast" {
  type = map
}
variable "sg_rules_postgresql" {
  type = map  
}

variable "sg_rules_rvgpt" {
  type = map
}

variable "priv_sub_id" {
  type = list(string)
}
variable "pub_sub_id" {
  type = list(string)
}
variable "priv_sub_azs" {
  type = list(string)
}
variable "instance_tags" {
  type = map
}
variable "instance_type" {
  type = map
}
variable "instance_count" {
  type = map
}
variable "root_vol_size" {
  type = map
}
variable "volume_type" {
  type = map
}
variable "data_vol_size" {
  type = map
}
variable "key_name" {
  type = string
}
variable "env" { 
  type = string
}
locals {
  ec2_common_tags = {
    Terraform = "true"
    # Environment = "stage"
    # Timestamp = formatdate("DD-MMM-YYYY hh:mm:ss ZZZ", timestamp())
  }
}
