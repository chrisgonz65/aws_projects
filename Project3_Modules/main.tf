provider "aws" {
  region = "us-west-1"
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
}

variable "subnet_cidr_block" {
  description = "subnet CIDR block"
}

resource "aws_vpc" "main-vpc" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main-vpc.id
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.private-subnet.id
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_s3_bucket" "example" {
  bucket = "mybucket-tf-testing"
}

resource "aws_instance" "web-server" {
  ami = ami = "ami-07413789aae50b0e0"
  instance_type = t2.micro
  subnet_id = aws_subnet.private-subnet.id
  #key_name = 
  aws_key_pair.generated_key.key_name
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl start httpd
    EOF
}

resource "aws_key_pair" "generated_key" {
    key_name = "my_key"
    public_key = "my_public_ssh_key"
  
}