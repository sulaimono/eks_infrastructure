variable "project_name" {
  description = "The Infra Project Name"
  type        = string
}

variable "aws_region" {
  description = "The infra Region"
  type        = string
}

variable "cidr_block" {
  description = "The cidr block for the VPC"
  type        = string
}

variable "pub_subnet1_cidr_block" {
  description = "First Public subnet cidr block"
  type        = string
}

variable "pub_subnet2_cidr_block" {
  description = "Second Public Subnet cidr block"
  type        = string
}

variable "priv_subnet1_cidr_block" {
  description = "First Private subnet cidr block"
  type        = string
}

variable "priv_subnet2_cidr_block" {
  description = "Second Private Subnet cidr block"
  type        = string
}

variable "k8s_role_elb" {
  description = "Kubernetes Tag to the public subnet for the creation of its elb"
  type        = string
}

variable "k8s_role_internal_elb" {
  description = "Kubernetes Tag to the private subnet for the creation of its internal lb"
  type        = string
}
