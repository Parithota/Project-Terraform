resource "random_pet" "random_pet_name" {
    length = 3
}

resource "random_bytes" "random_bytes" {
length = 10
}

resource "random_id" "random_id_var" {
byte_length = 8
}

resource "random_password" "random_password_var" {
    length = 10
}

resource "random_shuffle" "random_shuffle_var" {
    input = ["Pari", "harsha", "chaitu"]
}

resource "random_string" "random_string_var" {
    length = 12
}

resource "random_uuid" "random_uuid_var" {
}