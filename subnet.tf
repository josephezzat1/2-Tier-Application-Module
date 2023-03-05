resource "aws_subnet" "public_subnet" {
  for_each = var.public-subnet
  vpc_id = data.aws_vpc.vpc_data.id
  availability_zone = each.value.availability_zone
  cidr_block = each.value.cidr

  tags = {
    "Name" = "${var.name}-public-subnet-${each.key}"
  }
}

resource "aws_subnet" "private_subnet" {
    for_each = var.private-subnet
    availability_zone = each.value.availability_zone
    cidr_block = each.value.cidr
    vpc_id = data.aws_vpc.vpc_data.id
    
  tags = {
    "Name" = "${var.name}-private-subnet-${each.key}"
  }
}

resource "aws_internet_gateway" "gw" {
    vpc_id = data.aws_vpc.vpc_data.id
    tags = {
      "Name" = "Joseph Internet Gateway"
    }
}

resource "aws_route_table" "route_table" {
  vpc_id = data.aws_vpc.vpc_data.id
  route{
    
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
    }
    tags ={
        "Name" = "Joseph Route Table"
    }
}

resource "aws_route_table_association" "route_table_association" {
  
  subnet_id = aws_subnet.public_subnet["public_sub1"].id
  route_table_id = aws_route_table.route_table.id

}