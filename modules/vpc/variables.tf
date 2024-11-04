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
    Team       = "DevOps"
    Terraform = "true"
    # Environment = "dev"
    # Timestamp = format("%s", formatdate("DD-MMM-YYYY hh:mm:ss",timeadd(timestamp(), "5h30m")))
    # Timestamp = formatdate("DD-MMM-YYYY hh:mm:ss ZZZ", timestamp())
  }
}