resource "aws_ec2_client_vpn_endpoint" "vpn-st" {
  description = "Pari AWS Client VPN"
  server_certificate_arn = aws_acm_certificate.server.arn
  client_cidr_block      = var.vpn_cidr
  split_tunnel           = true
  vpc_id                 = aws_vpc.VPC-01.id

  #Configure Login Banner text for the VPN
  client_login_banner_options {
    banner_text = "Welcome to Pari's AWS VPN"
    enabled     = true
  }

  #Sets the authentication method to certificate bases authentication
  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.client.arn
  }

  #Disables connection login
  connection_log_options {
    enabled = false
  }

  #Specifies DNS Servers
  dns_servers = [var.vpc_dns, var.google_dns]

tags = { 
  "Name" = random_pet.random_pet_name.id
}
}

# Add authorization rules to allow all users
resource "aws_ec2_client_vpn_authorization_rule" "vpn-auth" {
    target_network_cidr = var.vpc_cidr_Pari
    client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn-st.id 
    authorize_all_groups = true

}
 
# Associate a subnet (any subnet in vpc) id with client VPN endpoint for network access
resource "aws_ec2_client_vpn_network_association" "vpn-subnet-assoc" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn-st.id
  subnet_id = aws_subnet.Public-Subnet.id
}