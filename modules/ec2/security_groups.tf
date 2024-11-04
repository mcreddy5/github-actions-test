# COMMON-SG
resource "aws_security_group" "common_sg" {
  name = var.sg_name_ec2["common"]
  description = var.sg_info_ec2["common"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name_ec2["common"] }, local.ec2_common_tags, {"Environment" = "${var.env}"} )
}
resource "aws_security_group_rule" "sg_common_ingress_rules" {
  for_each          = var.sg_rules_common
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.common_sg.id
}

# PRITUNL-SG
resource "aws_security_group" "pritunl_sg" {
  name = var.sg_name_ec2["pritunl"]
  description = var.sg_info_ec2["pritunl"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name_ec2["pritunl"] }, local.ec2_common_tags, {"Environment" = "${var.env}"} )
}
resource "aws_security_group_rule" "sg_pritunl_ingress_rules" {
  for_each          = var.sg_rules_pritunl
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.pritunl_sg.id
}

# BASTION-SG
resource "aws_security_group" "bastion_sg" {
  name = var.sg_name_ec2["bastion"]
  description = var.sg_info_ec2["bastion"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name_ec2["bastion"] }, local.ec2_common_tags, {"Environment" = "${var.env}"} )
}
resource "aws_security_group_rule" "sg_bastion_ingress_rules" {
  for_each          = var.sg_rules_bastion
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.bastion_sg.id
}

# ELK-SG
resource "aws_security_group" "elk_sg" {
  name = var.sg_name_ec2["elk"]
  description = var.sg_info_ec2["elk"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name_ec2["elk"] }, local.ec2_common_tags, {"Environment" = "${var.env}"} )
}

resource "aws_security_group_rule" "sg_elk_ingress_rules" {
  for_each          = var.sg_rules_elk
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.elk_sg.id
}

# mancenter-SG
resource "aws_security_group" "mancenter_sg" {
  name = var.sg_name_ec2["mancenter"]
  description = var.sg_info_ec2["mancenter"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name_ec2["mancenter"] }, local.ec2_common_tags, {"Environment" = "${var.env}"} )
}

resource "aws_security_group_rule" "sg_mancenter_ingress_rules" {
  for_each          = var.sg_rules_mancenter
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.mancenter_sg.id
}

# GRAFANA-SG
resource "aws_security_group" "grafana_sg" {
  name = var.sg_name_ec2["grafana"]
  description = var.sg_info_ec2["grafana"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name_ec2["grafana"] }, local.ec2_common_tags, {"Environment" = "${var.env}"} )
}

resource "aws_security_group_rule" "sg_grafana_ingress_rules" {
  for_each          = var.sg_rules_grafana
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.grafana_sg.id
}

# HAZELCAST-SG
resource "aws_security_group" "hazelcast_sg" {
  name = var.sg_name_ec2["hazelcast"]
  description = var.sg_info_ec2["hazelcast"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name_ec2["hazelcast"] }, local.ec2_common_tags, {"Environment" = "${var.env}"} )
}

resource "aws_security_group_rule" "sg_hazelcast_ingress_rules" {
  for_each          = var.sg_rules_hazelcast
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.hazelcast_sg.id
}

# rmq-SG
resource "aws_security_group" "rmq_sg" {
  name = var.sg_name_ec2["rmq"]
  description = var.sg_info_ec2["rmq"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name_ec2["rmq"] }, local.ec2_common_tags, {"Environment" = "${var.env}"} )
}

resource "aws_security_group_rule" "sg_rmq_ingress_rules" {
  for_each          = var.sg_rules_rmq
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.rmq_sg.id
}

# KUBE-SERVER-SG
resource "aws_security_group" "kube_sg" {
  name = var.sg_name_ec2["kube"]
  description = var.sg_info_ec2["kube"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name_ec2["kube"] }, local.ec2_common_tags, {"Environment" = "${var.env}"} )
}

resource "aws_security_group_rule" "sg_kube_ingress_rules" {
  for_each          = var.sg_rules_kube
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.kube_sg.id
}

# MONGO-SG
resource "aws_security_group" "mongo_ops_sg" {
  name = var.sg_name_ec2["mongo_ops"]
  description = var.sg_info_ec2["mongo_ops"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name_ec2["mongo_ops"] }, local.ec2_common_tags, {"Environment" = "${var.env}"} )
}

resource "aws_security_group_rule" "sg_mongo_ops_ingress_rules" {
  for_each          = var.sg_rules_mongo_ops
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.mongo_ops_sg.id
}

# MONGO-Standalone-SG

resource "aws_security_group" "mongo_standalone_sg" {
  name = var.sg_name_ec2["mongo-standalone"]
  description = var.sg_info_ec2["mongo-standalone"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name_ec2["mongo-standalone"] }, local.ec2_common_tags, {"Environment" = "${var.env}"} )
}

resource "aws_security_group_rule" "sg_mongo_standalone_ingress_rules" {
  for_each          = var.sg_rules_mongo_standalone
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.mongo_standalone_sg.id
}

# MONGO-Server-sg

resource "aws_security_group" "mongo_server_sg" {
  name = var.sg_name_ec2["mongo-server"]
  description = var.sg_info_ec2["mongo-server"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name_ec2["mongo-server"] }, local.ec2_common_tags, {"Environment" = "${var.env}"} )
}

resource "aws_security_group_rule" "sg_mongo_server_ingress_rules" {
  for_each          = var.sg_rules_mongo_server
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.mongo_server_sg.id
}




# NGINX-PUBLIC-SG
resource "aws_security_group" "public_nginx_sg" {
  name = var.sg_name_ec2["public-nginx"]
  description = var.sg_info_ec2["public-nginx"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name_ec2["public-nginx"] }, local.ec2_common_tags, {"Environment" = "${var.env}"} )
}

resource "aws_security_group_rule" "sg_public-nginx_ingress_rules" {
  for_each          = var.sg_rules_public_nginx
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.public_nginx_sg.id
}

# RVGPT-sg

resource "aws_security_group" "rvgpt_sg" {
  name = var.sg_name_ec2["rvgpt"]
  description = var.sg_info_ec2["rvgpt"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name_ec2["rvgpt"] }, local.ec2_common_tags, {"Environment" = "${var.env}"} )
}

resource "aws_security_group_rule" "sg_rvgpt_ingress_rules" {
  for_each          = var.sg_rules_rvgpt
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.rvgpt_sg.id
}


# postgresql-SG
resource "aws_security_group" "postgresql_sg" {
  name = var.sg_name_ec2["postgresql"]
  description = var.sg_info_ec2["postgresql"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name_ec2["postgresql"] }, local.ec2_common_tags, {"Environment" = "${var.env}"} )
}
resource "aws_security_group_rule" "sg_postgresql_ingress_rules" {
  for_each          = var.sg_rules_postgresql
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.postgresql_sg.id
}