variable "environment_name" {
  type = string
}
variable "cluster_name" {
    type = string
}
variable "cluster_version" {
    type = string
}
variable "vpc_id" {
    type = string
}
variable "subnet_ids_for_eks_cluster" {
    type = list(string)
}
variable "subnet_ids_for_eks_cluster_node_group" {
    type = list(string)
}

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
}*/

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
/*
variable "cluster_sg_id" {

}
*/