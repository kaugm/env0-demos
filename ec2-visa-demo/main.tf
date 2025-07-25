provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2_iam_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# Multiple AWS Managed Policies via for_each
resource "aws_iam_role_policy_attachment" "ec2_policy_attachments" {
  for_each   = toset(var.managed_policy_arns)
  role       = aws_iam_role.ec2_role.name
  policy_arn = each.value
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_iam_role"
  role = aws_iam_role.ec2_role.name
}

resource "aws_security_group" "sg_test1" {
  name        = "sg_test1"
  description = "Security group for EC2 instance"
  vpc_id      = "vpc-0c897a2a53d947af6" # Hardcoded because I don't want to write a data block

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.10.10.10/32"]
  }

  # Continually Add Egress Rules
  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}

resource "aws_instance" "example" {
  ami                    = data.aws_ami.ubuntu.id
  subnet_id = "subnet-0e4adba6f0364b18a" # Hardcoded because I don't want to write a data block
  instance_type          = "t2.micro"
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids        = [aws_security_group.sg_test1.id]

    tags = {
    Name = "FOR VISA DO NOT TOUCH - KARL"
  }
}



data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}resource "aws_security_group" "sg_test1" {
  name        = "sg_test1"
  description = "Security group for EC2 instance"
  vpc_id      = "vpc-0c897a2a53d947af6" # Hardcoded because I don't want to write a data block

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.10.10.10/32"]
  }

  tags = local.terratag_added_main
}le.ec2_role.name
}

resource "aws_security_group" "sg_test1" {
  name        = "sg_test1"
  description = "Security group for EC2 instance"
  vpc_id      = "vpc-0c897a2a53d947af6" # Hardcoded because I don't want to write a data block

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.10.10.10/32"]
  }

  # Continually Add Egress Rules
  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}

resource "aws_instance" "example" {
  ami                    = data.aws_ami.ubuntu.id
  subnet_id = "subnet-0e4adba6f0364b18a" # Hardcoded because I don't want to write a data block
  instance_type          = "t2.micro"
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids        = [aws_security_group.sg_test1.id]

    tags = {
    Name = "FOR VISA DO NOT TOUCH - KARL"
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
