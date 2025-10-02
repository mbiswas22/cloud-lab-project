provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
}

resource "aws_instance" "web" {
  ami = var.ami
  instance_type = var.instance_type
  tags = {
    Name = "Terraform-EC2"
    }
  subnet_id     = aws_subnet.public.id
  key_name      = var.key_pair_name
  security_groups = [aws_security_group.web_sg.id]

  user_data = file("setup_web.sh")
}

