provider "aws" {
    region = "us-west-1"
}

resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-west-1a"
}

resource "aws_s3_bucket" "my-website" {
    bucket = "my-static-webpage-via-s3"
    acl = "public-read"

website {
    index_document = "index.html"
    error_document = "error.html"
}
}

resource "aws_instance" "my-sql-server" {
    ami = "ami-"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.private_subnet.id

}