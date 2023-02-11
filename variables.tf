variable "aws_profile" {
  type = string
  description = "AWS profile set up for AWS CLI"
}

variable "aws_region" {
  type = string
  default = "eu-west-2"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "private_subnet_cidrs" {
 type = list(string)
 default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}


variable "public_subnet_cidrs" {
 type = list(string)
 default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}
 
