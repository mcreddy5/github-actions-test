resource "aws_instance" "mongo-standalone-server" {
    ami = data.aws_ami.amazon-linux.id
    instance_type = var.instance_type["mongo-standalone"]
    key_name = var.key_name
    root_block_device {
      volume_size = var.root_vol_size["mongo-standalone"]
      volume_type = var.volume_type["common"]
      encrypted = "true"
      tags = {
          "Name" = "${var.instance_tags["mongo-standalone"]}-root-vol"
      }
    }
    tags = merge( { "Name" = "${var.instance_tags["mongo-standalone"]}" }, local.ec2_common_tags, {"Environment" = "${var.env}"})
    subnet_id = var.priv_sub_id[0] 
    vpc_security_group_ids = [ aws_security_group.mongo_ops_sg.id, aws_security_group.common_sg.id ]
}

resource "aws_ebs_volume" "mongo-standalone-volume" {
  availability_zone = var.priv_sub_azs[0]
  size = var.data_vol_size["mongo-standalone"]
  type = var.volume_type["common"]
  encrypted = "true"
  tags = merge( { "Name" = "${var.instance_tags["mongo-standalone"]}-data-vol"}, local.ec2_common_tags, {"Environment" = "${var.env}"})
}


resource "aws_volume_attachment" "mongo_standalone_ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.mongo-standalone-volume.id
  instance_id = aws_instance.mongo-standalone-server.id 
}