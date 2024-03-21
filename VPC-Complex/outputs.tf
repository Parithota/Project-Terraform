output "Random_Pet_Name" {
    value  = random_pet.random_pet_name.id
}

output "Random_Bytes_BaseX64" {
    value = random_bytes.random_bytes.base64
    sensitive = true
}

output "Random_Bytes_HEX" {
   value = random_bytes.random_bytes.hex
   sensitive = true
}

output "Random_Id_Var" {
    value = random_id.random_id_var.b64_url
}

output "Random_Password" {
    value = random_password.random_password_var
    sensitive = true
}

output "Random_Shuffle" {
    value = random_shuffle.random_shuffle_var
}

output "Random_UUID" {
    value = random_uuid.random_uuid_var.id
}

output "Windows-ami" {
  value = data.aws_ami.windows-ami.image_id
}

output "Windows-publicIP" {
  value = aws_instance.Windows-Web-EC2.public_ip
}

output "Amazon-Linux-ami" {
    value = data.aws_ami.Amazon-Linux-ami.image_id
}

output "Windows-Password-enc" {
  value = aws_instance.Windows-Web-EC2.password_data
}

output "Windows-Password-dnc" {
  value = rsadecrypt(aws_instance.Windows-Web-EC2.password_data, tls_private_key.private_key.private_key_pem)
  sensitive = true
}