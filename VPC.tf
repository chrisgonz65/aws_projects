provider "aws" {
    region = "us-west-1"
}

#vpc with /16 CIDR, first two octets are reserved for network.
resource "aws_vpc" "VPC1" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"

    tags = {
        Name = "AWS_VPC1"
    }
}

#private subnet with 253 usable IPs
resource "aws_subnet" "private1" {
    vpc_id = aws_vpc.VPC1.id
    cidr_block = "10.0.1.0/24"

    tags = {
        Name = "AWS_VPC1"
    }
}

#public subnet with 253 usable IPs
resource "aws_subnet" "public1" {
    vpc_id = aws_vpc.VPC1.id
    cidr_block = "10.0.2.0/24"

    tags = {
        Name = "AWS_VPC1"
    }
}

#EC2 build with linux AMI in private subnet
resource "aws_instance" "server1"{
ami = "ami-07413789aae50b0e0"
#key_name = ""
instance_type = "t2.micro"
subnet_id = aws_subnet.private1.id

tags = {
    Name = "AWS_VPC1"
}
}

#internet gateway for public1 subnet
resource "aws_internet_gateway" "IG-01"{
    vpc_id = aws_vpc.VPC1.id

    tags = {
        Name = "AWS_VPC1"
    }
}

#NAT gateway for private subnet to get private/secure internet access via AWS network
resource "aws_nat_gateway" "NAT-01" {
  subnet_id     = aws_subnet.private1.id

  tags = {
    Name = "AWS_VPC1"
  }

}

#route table for public subnet
resource "aws_route_table" "RT-Public" {
    vpc_id = aws_vpc.VPC1.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IG-01.id
    }

    tags = {
        Name = "AWS_VPC1"
    }
}

#route table for private subnet
resource "aws_route_table" "RT-Private" {
    vpc_id = aws_vpc.VPC1.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.NAT-01.id
    }

    tags = {
        Name = "AWS_VPC1"
    }
}

#association for the public route table and the public subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.RT-Public.id
}

#association for the private route table and the private subnet
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.RT-Private.id
}

/*
#NSG rule for ssh connectivity from any ip.
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.VPC1.id

  tags = {
    Name = "allow_ssh"
  }
}


resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = aws_vpc.VPC1.id
  from_port         = 22
  ip_protocol       = "ssh"
  to_port           = 22
}



resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

*/





