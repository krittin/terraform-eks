
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    name = "eks vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    name = "eks vpc internet gateway"
  }

}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.vpc.id
  cidr_block = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
 
  tags = {
   name = "eks private subnet ${count.index+1}"
  }
}


resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.vpc.id
  cidr_block = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
 
  tags = {
   name = "eks public subnet ${count.index+1}"
  }
}

resource "aws_eip" "nat_ips" {
  count = length(var.private_subnet_cidrs)

  tags = {
    name = "eip for nat ${count.index+1}"
  }
}

resource "aws_nat_gateway" "nat_gateways" {
  count = length(var.private_subnet_cidrs)
  allocation_id = element(aws_eip.nat_ips[*].id, count.index)
  subnet_id = element(aws_subnet.public_subnets[*].id, count.index)

  tags = {
    name = "nat ${count.index+1}"
  }

  depends_on = [ aws_internet_gateway.igw ]

}

