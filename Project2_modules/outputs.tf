output "region" {
  value = var.region
}

output "project_name" {
  value = var.project_name
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

/*  allow you to export structured data about your 
resources. Outputs are also necessary to share data 
from a child module to your root module. to get information 
about the resources you have deployed. Output values are similar to return values 
in programming languages.
*/
