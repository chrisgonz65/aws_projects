provider "aws" {
    region = "us-west-1"
}

#EC2 build with linux AMI in public subnet
resource "aws_instance" "server2"{
ami = "ami-07413789aae50b0e0"
#key_name = ""
instance_type = "t2.micro"
subnet_id = aws_subnet.public1.id

tags = {
    Name = "AWS_VPC1"
}
}
