data "aws_ami" "ubuntu-linux" {
  most_recent =  "true"
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20221212"] 
  }
}
