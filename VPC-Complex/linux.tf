resource "aws_instance" "Linux-EC2" {
  ami                    = var.linux_ami
  instance_type          = var.linux_instance_type
  subnet_id              = aws_subnet.Private-Subnet.id
  vpc_security_group_ids = [aws_security_group.LinuxSG.id]
  key_name = aws_key_pair.key_pair.key_name
  associate_public_ip_address = false

tags = {
    "Name" = format("Linux-%s", random_pet.random_pet_name.id)
}
}
