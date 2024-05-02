output "vpc_id" {
  value = aws_vpc.main-vpc.id
}

output "subnet_id" {
  value = aws_subnet.private-subnet.id
}