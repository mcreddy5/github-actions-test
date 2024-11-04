
resource "aws_instance" "rvgpt-server" {
    ami = data.aws_ami.amazon-linux.id
    instance_type = var.instance_type["rvgpt"]
    key_name = var.key_name
    
    root_block_device {
      volume_size = var.root_vol_size["rvgpt"]
      volume_type = var.volume_type["common"]
      encrypted = "true"
      tags = {
          "Name" = "${var.instance_tags["rvgpt"]}-root-vol"
      }
    }

    tags = merge( { "Name" = "${var.instance_tags["rvgpt"]}" }, local.ec2_common_tags, {"Environment" = "${var.env}"})

    subnet_id = var.priv_sub_id[1] 

    vpc_security_group_ids = [ aws_security_group.rvgpt_sg.id, aws_security_group.common_sg.id ]
}

