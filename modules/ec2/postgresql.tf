resource "aws_instance" "postgresql-server" {
    ami = data.aws_ami.ubuntu-linux.id
    instance_type = var.instance_type["postgresql"]
    key_name = var.key_name
    root_block_device {
      volume_size = var.root_vol_size["postgresql"]
      volume_type = var.volume_type["common"]
      encrypted = "true"
      tags = {
          "Name" = "${var.instance_tags["postgresql"]}-root-vol"
      }
    }
    tags = merge( { "Name" = "${var.instance_tags["postgresql"]}" }, local.ec2_common_tags, {"Environment" = "${var.env}"})
    subnet_id = var.priv_sub_id[0]
    vpc_security_group_ids = [   aws_security_group.postgresql_sg.id, aws_security_group.common_sg.id  ]
}

resource "aws_ebs_volume" "postgresql-volume" {
  availability_zone = var.priv_sub_azs[0]
  size = var.data_vol_size["postgresql"]
  type = var.volume_type["common"]
  encrypted = "true"
  tags = merge( { "Name" = "${var.instance_tags["postgresql"]}-data-vol"}, local.ec2_common_tags, {"Environment" = "${var.env}"})
}


resource "aws_volume_attachment" "postgresql_ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.postgresql-volume.id
  instance_id = aws_instance.postgresql-server.id 
}
