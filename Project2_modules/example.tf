resource "aws_instance" "server1"{
ami = var.ec2_ami_id
instance_type = "t2.micro"
subnet_id = aws_subnet.public1.id

#ami = "ami-07413789aae50b0e0"
#security_groups = [aws_security_group.sg1]

user_data = <<-EOF
#!/bin/bash
sudo apt update -y
sudo install apache2 -y
EOF

tags = {
    Name = "web_server"
}
}

module "my_ec2_instance" {
    source = "./"
}



module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-1a", "us-west-1b", "us-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
}