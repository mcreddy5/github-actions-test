resource "aws_instance" "mongoserver" {
    ami = data.aws_ami.amazon-linux.id
    instance_type = var.instance_type["mongo-server"]
    count = var.instance_count["mongo-server"]
    key_name = var.key_name
    
    root_block_device {
      volume_size = var.root_vol_size["mongo-server"]
      volume_type = var.volume_type["common"]
      encrypted = "true"
      tags = { "Name" = "${var.instance_tags["mongo-server"]}-root-vol-${count.index + 1}" }
    }
    tags = merge( { "Name" = "${var.instance_tags["mongo-server"]}-${count.index + 1}" }, local.ec2_common_tags, {"Environment" = "${var.env}"})
    subnet_id = var.priv_sub_id[0] 
    vpc_security_group_ids = [ aws_security_group.mongo_server_sg.id, aws_security_group.common_sg.id ]
}

resource "aws_ebs_volume" "mongoserver-volumes" {
  count = var.instance_count["mongo-server"]
  availability_zone = var.priv_sub_azs[0]
  size = var.data_vol_size["mongo-server"]
  encrypted = "true"
  type = "gp3"
  tags = merge( { "Name" = "${var.instance_tags["mongo-server"]}-${count.index + 1}-data-vol"}, local.ec2_common_tags, {"Environment" = "${var.env}"})
}

resource "aws_volume_attachment" "mongoserver_ebs_att" {
  device_name = "/dev/sdh"
  count= var.instance_count["mongo-server"]
  volume_id   = aws_ebs_volume.mongoserver-volumes[count.index].id
  instance_id = aws_instance.mongoserver[count.index].id
  
  }
