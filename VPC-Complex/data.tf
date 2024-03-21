
data "http" "MyIP" {
  url = "http://ipinfo.io/json"
}

output "My-Public-IP" {
    value = "${jsondecode(data.http.MyIP.response_body)["ip"]}"
}

data "aws_ami" "windows-ami" {
  most_recent = true

  filter {
    name = "name"
    values = ["Windows_Server-2022-English-Full-Base-*"]
  }
}

data "aws_ami" "Amazon-Linux-ami" {
  most_recent = true

  filter {
    name = "name"
    values = ["Amazon Linux*"]
  }

}