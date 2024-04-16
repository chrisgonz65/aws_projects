provider "aws" {
    region = "us-west-1"
}

resource "aws_instance" "apache_server" {
    ami = "ami-07413789aae50b0e0"
    instance_type = "t2.micro"
}