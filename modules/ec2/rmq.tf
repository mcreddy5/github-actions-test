resource "aws_instance" "rmqserver" {
    ami = data.aws_ami.amazon-linux.id
    instance_type = var.instance_type["rmq"]
    count = var.instance_count["rmq"]
    key_name = var.key_name
    
    root_block_device {
      volume_size = var.root_vol_size["rmq"]
      volume_type = var.volume_type["common"]
      encrypted = "true"
      tags = { "Name" = "${var.instance_tags["rmq"]}-root-vol-${count.index + 1}" }
    }
    tags = merge( { "Name" = "${var.instance_tags["rmq"]}-${count.index + 1}" }, local.ec2_common_tags, {"Environment" = "${var.env}"})
    subnet_id = var.priv_sub_id[0] 
    vpc_security_group_ids = [ aws_security_group.rmq_sg.id, aws_security_group.common_sg.id ]
}

resource "aws_ebs_volume" "rmq-volumes" {
  count = var.instance_count["rmq"]
  availability_zone = var.priv_sub_azs[0]
  size = var.data_vol_size["rmq"]
  encrypted = "true"
  type = "gp3"
  tags = merge( { "Name" = "${var.instance_tags["rmq"]}-${count.index + 1}-data-vol"}, local.ec2_common_tags, {"Environment" = "${var.env}"})
}

resource "aws_volume_attachment" "rmq_ebs_att" {
  device_name = "/dev/sdh"
  count= var.instance_count["rmq"]
  volume_id   = aws_ebs_volume.rmq-volumes[count.index].id
  instance_id = aws_instance.rmqserver[count.index].id
  
  }







