output "region" {
  value = var.region
}

output "project_name" {
  value = var.project_name
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_az1_id" {
  value = aws_subnet.public_subnet_az1.id
}

output "public_subnet_az2_id" {
  value = aws_subnet.public_subnet_az2.id
}

output "private_app_subnet_az1_id" {
  value = aws_subnet.private_app_subnet_az1.id
}

output "private_app_subnet_az2_id" {
  value = aws_subnet.private_app_subnet_az2.id
}

output "private_data_subnet_az1" {
  value = aws_subnet.private_data_subnet_az1.id
}

output "private_data_subnet_az2" {
  value = aws_subnet.private_data.subnet_az2.id
}

output "internet_gateway" {
  value = aws_internet_gateway.internet_gateway
}
/*  allow you to export structured data about your 
resources. Outputs are also necessary to share data 
from a child module to your root module. to get information 
about the resources you have deployed. Output values are similar to return values 
in programming languages.
*/
