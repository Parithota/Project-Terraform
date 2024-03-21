variable "region" {
  default = "us-east-2"
}

variable "vpc_cidr_Pari" {
  default = "10.0.0.0/20"
}

variable "public_subnet_cidr" {
  default = "10.0.0.0/21"
}

variable "private_subnet_cidr" {
  default = "10.0.8.0/21"
}

variable "all_ipv4_cidr" {
  default = "0.0.0.0/0"
}

variable "windows_instance_type" {
  default = "t2.medium"
}

variable "linux_instance_type" {
  default = "t2.micro"
}

variable "linux_ami" {
  default = "ami-022661f8a4a1b91cf"
}

variable "rdp_on" {
  default = false
}

variable "vpn_cidr" {
  default = "192.168.0.0/21"
}

variable "vpc_dns" {
  default = "10.0.0.2"
}

variable "google_dns" {
  default = "8.8.8.8"
}