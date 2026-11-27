output "project_name" {
  description = "The project name: "
  value       = var.project_name
}

output "aws_region" {
  description = "The infras region: "
  value       = var.aws_region
}

output "vpc_id" {
  description = "The VPC name: "
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "The VPC cidr block: "
  value       = aws_vpc.main.cidr_block
}

output "pub_subnet1" {
  description = "Public subnet 1"
  value       = aws_subnet.public1.id
}

output "pub_subnet2" {
  description = "Public subnet 2"
  value       = aws_subnet.public2.id
}

output "priv_subnet1" {
  description = "Private subnet 1"
  value       = aws_subnet.private1.id
}

output "priv_subnet2" {
  description = "Private subnet 2"
  value       = aws_subnet.private2.id
}
