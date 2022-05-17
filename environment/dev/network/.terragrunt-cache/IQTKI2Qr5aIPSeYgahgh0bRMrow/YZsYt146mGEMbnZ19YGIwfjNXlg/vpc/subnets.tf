data "aws_availability_zones" "availableAZ" {}

#=============================== Public subnet ==========================================
resource "aws_subnet" "publicsubnet" {
  count                   = length(var.publicSubnetCIDR)
  cidr_block              = tolist(var.publicSubnetCIDR)[count.index]
  vpc_id                  = aws_vpc.dev_vpc.id
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.availableAZ.names[count.index]
  tags = {
    name        = "${var.environment}-publicsubnet-${count.index + 1}"
    AZ          = data.aws_availability_zones.availableAZ.names[count.index]
    Environment = "${var.environment}-publicsubnet"
  }
}



#=============================== Internet gateway ==================================

resource "aws_internet_gateway" "internetgateway" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name = "${var.environment}-InternetGateway"
  }
}

resource "aws_route_table" "publicroutetable" {
  vpc_id = aws_vpc.dev_vpc.id
  route {
    cidr_block = var.route_cidr
    # cidr_block = var.allowed_cidr
    gateway_id = aws_internet_gateway.internetgateway.id
  }
  depends_on = [aws_internet_gateway.internetgateway]
}

resource "aws_route_table_association" "routeTableAssociationPublicRoute" {
  count          = length(var.publicSubnetCIDR)
  route_table_id = aws_route_table.publicroutetable.id
  subnet_id      = aws_subnet.publicsubnet[count.index].id
}

#=============================== NAT gateway ========================================
resource "aws_eip" "nat_eip" {
  count = length(var.publicSubnetCIDR)

}
resource "aws_nat_gateway" "nat-gateway" {
  count         = length(var.publicSubnetCIDR)
  subnet_id     = aws_subnet.publicsubnet[count.index].id
  allocation_id = aws_eip.nat_eip[count.index].id
}

resource "aws_route_table" "nat_routetable" {
  vpc_id = aws_vpc.dev_vpc.id
  count  = length(var.publicSubnetCIDR)
  route {
    cidr_block = var.route_cidr
    gateway_id = aws_nat_gateway.nat-gateway[count.index].id
  }
  depends_on = [aws_nat_gateway.nat-gateway]
}
