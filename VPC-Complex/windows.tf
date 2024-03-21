resource "aws_instance" "Windows-Web-EC2" {
  ami                         = data.aws_ami.windows-ami.image_id
  instance_type               = var.windows_instance_type
  subnet_id                   = aws_subnet.Public-Subnet.id
  vpc_security_group_ids             = [aws_security_group.WebSG.id]
  key_name = aws_key_pair.key_pair.key_name
  get_password_data = true
  associate_public_ip_address = true

  tags = {
    "Name" = format("WindowsWeb-%s", random_pet.random_pet_name.id)
  }
}

resource "aws_eip_association" "Windows_eip_assoc" {
  instance_id   = aws_instance.Windows-Web-EC2.id
  allocation_id = aws_eip.windows_eip.id
}

resource "local_file" "password" {
  filename = "./Keys/Windows-${random_pet.random_pet_name.id}.pass"
  content = rsadecrypt(aws_instance.Windows-Web-EC2.password_data, tls_private_key.private_key.private_key_pem)
  file_permission = "0400"
}

resource "local_file" "rdp" {
  filename = "${path.module}/.rdp/Keys/${random_pet.random_pet_name.id}.rdp"
  content = <<-RDP_CONTENT
  auto connect:i:1
  full address:s:${aws_eip.windows_eip.public_ip}
  username:s: Administrator
  audiomode:i:2
  audiocapturemode:i:1
  RDP_CONTENT
  file_permission = "0400"
}

locals {
  trigger_value = var.rdp_on ? "${timestamp()}" : null

}
resource "null_resource" "edp_exec" {
  triggers = {
    "always_run" = local.trigger_value
  }
provisioner "local-exec" {
  command = "start ${local_file.rdp.filename}"
}
  depends_on = [ local_file.rdp ]
}