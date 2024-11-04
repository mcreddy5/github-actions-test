resource "aws_instance" "mancenter" {
    ami = data.aws_ami.amazon-linux.id
    instance_type = var.instance_type["mancenter"]
    key_name = var.key_name
    
    root_block_device {
      volume_size = var.root_vol_size["mancenter"]
      volume_type = var.volume_type["common"]
      encrypted = "true"
      tags = { "Name" = "${var.instance_tags["mancenter"]}-root-vol" }
    }
    tags = merge( { "Name" = "${var.instance_tags["mancenter"]}" }, local.ec2_common_tags, {"Environment" = "${var.env}"})
    subnet_id = var.priv_sub_id[0] 
    vpc_security_group_ids = [ aws_security_group.mancenter_sg.id, aws_security_group.common_sg.id ]
}
