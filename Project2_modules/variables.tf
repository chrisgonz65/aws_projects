variable "ec2_ami_id" {
    type = string
}

variable "ec2_instance_type" {
    type = string
    default = "t3.micro"
}

variable "instance_amount" {
    type = number
}

variable "ec2_instance_name" {
    type = string
}