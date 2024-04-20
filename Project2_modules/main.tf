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