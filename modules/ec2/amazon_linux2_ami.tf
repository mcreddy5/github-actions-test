data "aws_ami" "amazon-linux" {
  most_recent =  "true"
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
