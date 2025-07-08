resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type
  count         = var.instance_count

  tags = {
    Name = var.name
  }
}
