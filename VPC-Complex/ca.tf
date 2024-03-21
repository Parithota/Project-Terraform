locals {
  cert_path = "${path.module}/.cert/"
}

resource "tls_private_key" "ca-pvt" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "ca-pvt-key" {
  filename        = "${local.cert_path}ca-pvt.pem"
  content         = tls_private_key.ca-pvt.private_key_pem
  file_permission = "0400"
}

resource "tls_self_signed_cert" "ca" {
  private_key_pem = tls_private_key.ca-pvt.private_key_pem

  subject {
    common_name  = "Pariveshita.Thota"
    organization = "Indus Valley, Inc"
  }
  is_ca_certificate = true

  validity_period_hours = 3600

  allowed_uses = [
    "digital_signature",
    "key_encipherment",
    "cert_signing",
  ]
}

resource "local_file" "ca-cert-file" {
  filename        = "${local.cert_path}ca.crt"
  content         = tls_self_signed_cert.ca.cert_pem
  file_permission = "0400"
}

resource "tls_private_key" "server-pvt" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "server-pvt" {
  filename        = "${local.cert_path}server-pvt.pem"
  content = tls_private_key.server-pvt.private_key_pem
  file_permission = "0400"
}

resource "tls_cert_request" "server-req" {
  private_key_pem = tls_private_key.server-pvt.private_key_pem


subject {
  common_name = "Pari.AWS"
  organization = "Indus Valley, Inc"
}  
}

resource "tls_locally_signed_cert" "server" {
cert_request_pem = tls_cert_request.server-req.cert_request_pem
ca_private_key_pem = tls_private_key.ca-pvt.private_key_pem
ca_cert_pem = tls_self_signed_cert.ca.cert_pem
 
 validity_period_hours = 3600

   allowed_uses = [
    "digital_signature",
    "key_encipherment",
    "cert_signing",
  ]
}

resource "local_file" "server-cert" {
filename = "${local.cert_path}server.crt"
content = tls_locally_signed_cert.server.cert_pem
file_permission = "0400"
}

resource "tls_private_key" "client-pvt" {
  algorithm = "RSA"
  rsa_bits = 2048
}

resource "local_file" "client-pvt-file" {
  filename = "${local.cert_path}client-pvt.pem"
  content = tls_private_key.client-pvt.private_key_pem
  file_permission = "0400"
}
  
resource "tls_cert_request" "client-req" {
  private_key_pem = tls_private_key.client-pvt.private_key_pem

  subject {
    common_name = "Pari.Home"
    organization = "Indus Valley, Inc"
  }
  
}

resource "tls_locally_signed_cert" "client-crt" {
  cert_request_pem = tls_cert_request.client-req.cert_request_pem
  ca_private_key_pem = tls_private_key.ca-pvt.private_key_pem
  ca_cert_pem = tls_self_signed_cert.ca.cert_pem

  validity_period_hours = 3600

   allowed_uses = [
    "digital_signature",
    "key_encipherment",
    "cert_signing",
  ]
  
}

resource "local_file" "client-crt-file" {
filename = "${local.cert_path}client.crt"
content = tls_locally_signed_cert.client-crt.cert_pem
file_permission = "0400"
}

resource "aws_acm_certificate" "server" {
  private_key = tls_private_key.server-pvt.private_key_pem
  certificate_body = tls_locally_signed_cert.server.cert_pem
  certificate_chain = tls_self_signed_cert.ca.cert_pem 
}

resource "aws_acm_certificate" "client" {
  private_key = tls_private_key.client-pvt.private_key_pem
  certificate_body = tls_locally_signed_cert.client-crt.cert_pem
  certificate_chain = tls_self_signed_cert.ca.cert_pem
}