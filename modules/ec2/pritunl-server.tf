# resource "aws_instance" "pritunl-server" {
#     ami = data.aws_ami.ubuntu-linux.id
#     instance_type = var.instance_type["pritunl"]
#     key_name = var.key_name
    
#     root_block_device {
#       volume_size = var.root_vol_size["pritunl"]
#       volume_type = var.volume_type["common"]
#       encrypted = "true"
#       tags = {
#           "Name" = "${var.instance_tags["pritunl"]}-root-vol"
#       }
#     }

#     tags = merge( { "Name" = "${var.instance_tags["pritunl"]}" }, local.ec2_common_tags, {"Environment" = "${var.env}"})

#     subnet_id = var.pub_sub_id[0]

#     vpc_security_group_ids = [  aws_security_group.pritunl_sg.id  ]
# }

resource "aws_instance" "pritunl-server" {
    ami = data.aws_ami.ubuntu-linux.id
    instance_type = var.instance_type["pritunl"]
    key_name = var.key_name
    
    root_block_device {
      volume_size = var.root_vol_size["pritunl"]
      volume_type = var.volume_type["common"]
      encrypted = "true"
      tags = {
          "Name" = "${var.instance_tags["pritunl"]}-root-vol"
      }
    }

    tags = merge( { "Name" = "${var.instance_tags["pritunl"]}" }, local.ec2_common_tags, {"Environment" = "${var.env}"})

    subnet_id = var.pub_sub_id[0]

    vpc_security_group_ids = [aws_security_group.pritunl_sg.id]

    /*Iprovisioner "local-exec" {   
      command = "sed -i 's/#opsmanager.stageinternal.com/${aws_instance.opsmanager-server.private_ip}/g' /home/prem/Downloads/preprod-ansibe/ansible-staging/hosts && sed -i 's/#rabbitMQ1.stageinternal.com/${aws_instance.rmqserver[0].private_ip}/g' /home/prem/Downloads/preprod-ansibe/ansible-staging/hosts && sed -i 's/#rabbitMQ2.stageinternal.com/${aws_instance.rmqserver[1].private_ip}/g' /home/prem/Downloads/preprod-ansibe/ansible-staging/hosts && sed -i 's/#postgres.stageinternal.com/${aws_instance.postgresql-server.private_ip}/g' /home/prem/Downloads/preprod-ansibe/ansible-staging/hosts && sed -i 's/#kube22.stageinternal.com/${aws_instance.kube-server.private_ip}/g' /home/prem/Downloads/preprod-ansibe/ansible-staging/hosts && sed -i 's/#grafana.stageinternal.com/${aws_instance.grafana-server.private_ip}/g' /home/prem/Downloads/preprod-ansibe/ansible-staging/hosts && sed -i 's/#elk.stageinternal.com/${aws_instance.elkserver.private_ip}/g' /home/prem/Downloads/preprod-ansibe/ansible-staging/hosts && sed -i 's/#hc1.stageinternal.com/${aws_instance.hazelcast-servers[0].private_ip}/g' /home/prem/Downloads/preprod-ansibe/ansible-staging/hosts && sed -i 's/#bastion.stageinternal.com/${aws_instance.bastion-server.private_ip}/g' /home/prem/Downloads/preprod-ansibe/ansible-staging/hosts" 
        }
    
    provisioner "file" {
      source      = "/home/prem/Downloads/preprod-ansibe"
      destination = "/tmp"

      connection {
        type        = "ssh"
        user        = "ubuntu"  # Replace with the correct username
        private_key = file("/home/prem/Downloads/preprod-ansibe/rev-prod-test-env.pem")
        host        = self.public_ip
      }
    }
    
    provisioner "remote-exec" {
        inline = [
             "chmod +x /tmp/preprod-ansibe/pritunl.sh",
             "/tmp/preprod-ansibe/pritunl.sh > /tmp/out.txt",
        ]
        connection {
            type        = "ssh"
            user        = "ubuntu"  # Update with your EC2 instance's user
            private_key = file("/home/prem/Downloads/preprod-ansibe/rev-prod-test-env.pem")  # Update with your private key file path
            host        = self.public_ip  # Use the public IP of the EC2 instance
        }
    }*/
}


# output "installed_script_output" {
#     value = aws_instance.pritunl-server.provisioners[1].connection["script"]  # Get the output of the script
# }
