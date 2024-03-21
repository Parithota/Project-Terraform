resource "aws_vpc" "VPC-01" {
  cidr_block = var.vpc_cidr_Pari

  tags = {
    "Name" = random_pet.random_pet_name.id
  }
}

resource "aws_subnet" "Public-Subnet" {
  vpc_id     = aws_vpc.VPC-01.id
  cidr_block = var.public_subnet_cidr

  tags = {
    "Name" = format("public-%s", random_pet.random_pet_name.id)
  }
}

resource "aws_internet_gateway" "igw" {
  tags = {
    "Name" = random_pet.random_pet_name.id
  }
}

resource "aws_internet_gateway_attachment" "igw_attach" {
  vpc_id              = aws_vpc.VPC-01.id
  internet_gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.VPC-01.id
  route {
    cidr_block = var.all_ipv4_cidr
    gateway_id = aws_internet_gateway.igw.id
  }
  route {
    cidr_block = var.vpc_cidr_Pari
    gateway_id = "local"
  }
  tags = {
    "Name" = format("public-%s", random_pet.random_pet_name.id)
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.VPC-01.id
  route {
    cidr_block = var.vpc_cidr_Pari
    gateway_id = "local"
  }
  route {
    cidr_block = var.all_ipv4_cidr
    gateway_id = aws_nat_gateway.Public_NAT_Gateway_Public_Subnet.id

  }
  tags = {
    "Name" = format("private-%s", random_pet.random_pet_name.id)
  }
}

resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id      = aws_subnet.Public-Subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_rt_assoc" {
  subnet_id = aws_subnet.Private-Subnet.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_nat_gateway" "Public_NAT_Gateway_Public_Subnet" {
  subnet_id = aws_subnet.Public-Subnet.id
  allocation_id = aws_eip.EIP.id

  tags = {
  "Name" = random_pet.random_pet_name.id
  }
}
resource "aws_eip" "EIP" {
}

resource "aws_subnet" "Private-Subnet" {
  vpc_id     = aws_vpc.VPC-01.id
  cidr_block = var.private_subnet_cidr

  tags = {
    "Name" = format("private-%s", random_pet.random_pet_name.id)
  }
}
