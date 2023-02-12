data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.vpc.id
  cidr_block = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
 
  tags = {
   name = "eks private subnet ${count.index+1}"
   "kubernetes.io/cluster/${var.eks_cluster_name}" = "owned"
   "kubernetes.io/role/internal-elb" = "1"
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