resource "tls_private_key" "private_key" {
    algorithm = "RSA"
    rsa_bits = 2048
    
}

resource "aws_key_pair" "key_pair" {
    public_key = tls_private_key.private_key.public_key_openssh
    key_name = random_pet.random_pet_name.id
  
}

resource "local_file" "private_key_pem" {
    filename = "${path.module}./Keys/Private-Key-${random_pet.random_pet_name.id}.pem"
    content = tls_private_key.private_key.private_key_pem
    file_permission = "0400"
}

resource "local_file" "public_key_pem" {
    filename = "${path.module}./Keys/Public-Key-${random_pet.random_pet_name.id}.pem"
    content = tls_private_key.private_key.private_key_pem
    file_permission = "0400"
}

