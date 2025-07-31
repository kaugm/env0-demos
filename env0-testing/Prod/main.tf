provider "aws" {
  region = "us-east-1"
}



resource "aws_instance" "example" {
  ami                    = data.aws_ami.ubuntu.id
  subnet_id = "subnet-0e4adba6f0364b18a" # Hardcoded because I don't want to write a data block
  instance_type          = "t2.micro"

    tags = {
    Name = "FOR VISA ENV DISCOVERY DO NOT TOUCH - KARL"
  }
}



data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}
