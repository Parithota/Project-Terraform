resource "aws_security_group" "WebSG" {
  name = format("WindowsWeb-%s", random_pet.random_pet_name.id)
  vpc_id = aws_vpc.VPC-01.id
  
  ingress {
    description = "Allows RDP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [format("%s/32", "${jsondecode(data.http.MyIP.response_body)["ip"]}")]
  }

  ingress {
    description = "Allows HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.all_ipv4_cidr]
  }

  ingress {
    description = "Allows HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.all_ipv4_cidr]
  }

  egress {
    description = "Allow access to all IPV4 & all protocols"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.all_ipv4_cidr]
  }

  tags = {
    "Name" = random_pet.random_pet_name.id
  }
}

resource "aws_security_group" "LinuxSG" {
  name   = format("LinuxDB-%s", random_pet.random_pet_name.id)
  vpc_id = aws_vpc.VPC-01.id

  ingress {
    description = "Allow access to SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.all_ipv4_cidr]
  }

  ingress {
    description = "Allow access to mysql"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.all_ipv4_cidr]
  }

  egress {
    description = "Allow access to internet and all protocols"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_ipv4_cidr]
  }

  tags = {
    "Name" = random_pet.random_pet_name.id
  }
}
