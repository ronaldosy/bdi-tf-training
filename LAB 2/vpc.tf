resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = var.azs[count.index]
  cidr_block        = var.public_subnets[count.index]

  tags = {
    Name = "public_subnet_${var.public_subnets[count.index]}"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = var.azs[count.index]
  cidr_block        = var.private_subnets[count.index]

  tags = {
    Name = "private_subnet_${var.private_subnets[count.index]}"
  }
}

resource "aws_subnet" "db_subnet" {
  count             = length(var.db_subnets)
  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = var.azs[count.index]
  cidr_block        = var.db_subnets[count.index]

  tags = {
    Name = "db_subnet_${var.db_subnets[count.index]}"
  }
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "Training IGW"
  }
}

resource "aws_route_table" "to_inet_via_igw" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }
}

resource "aws_route_table_association" "associate_inet_rtb" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.to_inet_via_igw.id
}

resource "aws_eip" "eip_nat_gw" {
  count  = length(var.public_subnets)
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  count = length(var.public_subnets)

  allocation_id = aws_eip.eip_nat_gw[count.index].id
  subnet_id     = aws_subnet.public_subnet[count.index].id

  depends_on = [aws_eip.eip_nat_gw]
}

resource "aws_route_table" "to_inet_via_natgw" {
  count  = length(var.private_subnets)
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw[count.index % length(var.public_subnets)].id
  }
}

resource "aws_route_table_association" "associate_natgw_rtb" {
  count          = length(var.private_subnets)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.to_inet_via_natgw.*.id, count.index)
}
