# For Provides
variable "aws_region" {
  type = string
}
######################################## VPC variables ########################################
variable "vpc_cidr_block" {
  type = string
}
variable "sub_count" {
  type = map(string)
  description = "public / private subcounts"
}   
variable "pub_sub_cidr_block" {
  type = list
}
variable "priv_sub_cidr_block" {
  type = list
}
variable "network_tags" {
  type = map(string)
  description = "common network tags"
}
variable "pub_sub_azs" {
  type = list
}
variable "priv_sub_azs" {
  type = list
}
variable "global_route" {
  type = string
}
variable "env" { 
  type = string
}

locals {
  vpc_common_tags = {
    Team       = "DevOpsPoc"
    Terraform = "true"
    Environment = "dev"
    Timestamp = formatdate("DD-MMM-YYYY hh:mm:ss ZZZ", timestamp())
  }
}
######################################## EKS variables ########################################
/*variable "environment_name" {
  type = string
}
variable "cluster_name" {
    type = string
}
variable "cluster_version" {
    type = string
}
# only required if provisioning single eks module, otherwise it has a dependency on vpc and takes value from them.
# variable "vpc_id" {
#     type = string
# }
# variable "subnet_ids_for_eks_cluster" {
#     type = list(string)
# }
# variable "subnet_ids_for_eks_cluster_node_group" {
#     type = list(string)
# }

# IAM info
variable "eks_cluster_role_name" {
    type = string
}

variable "node_group_iam_role_name" {
    type = string
}

# default nodes
variable "default_node_group_name" {
    type = string
}
variable "default_node_group_instance_type" {
    type = list(string)
} 
variable "default_node_disk_size" {
    type = number
}
variable "eks_desired_size_default_node" {
    type = number
}
variable "eks_max_size_default_node" {
    type = number
}
variable "eks_min_size_default_node" {
    type = number
}
# other node groups
variable "node_group_name" {
    type = list(string)
}
variable "eks_instance_type" {
    type = list(string)
}
variable "node_disk_size" {
    type = list(number)
}
variable "eks_desired_size" {
    type = list(number)
}
variable "eks_min_size" {
    type = list(number)
}
variable "eks_max_size" {
    type = list(number)
}
/*variable "eks_cluster_node_group_taint_value" {
    type = list(string)
}

# security group info
variable "sg_name" {
    type = map(string)
}
variable "sg_info" {
    type = map(string)
}
variable "sg_rules_eks_additional" {
    type = map
}
#variable "cluster_sg_id" {
#
#}  */

######################################## EC2 variables ########################################
// Only required while provisioning seperate ec2 module, otherwise it takes value from vpc
# variable "vpc_id" {
#   type = string
# }
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
variable "sg_rules_mongo" {
  type = map
}
/*variable "sg_rules_kafka" {
  type = map
}*/
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
/*variable "sg_rules_mysql" {
  type = map
}*/
variable "sg_rules_rmq" {
  type = map
}

// Only required while provisioning seperate ec2 module, otherwise it takes value from vpc
# variable "priv_sub_id" {
#   type = list(string)
# }
# variable "pub_sub_id" {
#   type = list(string)
# }
# variable "priv_sub_azs" {
#   type = list(string)
# }
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
locals {
  ec2_common_tags = {
    Terraform = "true"
    # Environment = "stage"
    # Timestamp = formatdate("DD-MMM-YYYY hh:mm:ss ZZZ", timestamp())
  }
}
