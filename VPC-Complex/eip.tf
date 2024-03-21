resource "aws_eip" "nat_EIP" {

  tags = {
    "Name" = format("Nat-%s", random_pet.random_pet_name.id)
  }
}

resource "aws_eip" "windows_eip" {

  tags = {
    "Name" = format("Windows-%s", random_pet.random_pet_name.id)
  }
}
