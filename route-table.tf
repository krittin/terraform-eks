resource "aws_route_table" "private_route_tables" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat_gateways[*].id, count.index)
  }

  tags = {
    name = "routing table for private subnet ${count.index+1}"
  }

}

resource "aws_route_table_association" private_rt_associations {
  count = length(var.private_subnet_cidrs)
  subnet_id = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = element(aws_route_table.private_route_tables[*].id, count.index)
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    name = "routing table for public subnets"
  }

}

resource "aws_route_table_association" public_rt_associations {
  count = length(var.public_subnet_cidrs)

  subnet_id = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}
