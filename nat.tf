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