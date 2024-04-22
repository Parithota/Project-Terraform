# Project-Terraform
Terraform is HashiCorp's infrastructure as code tool. It lets you define resources and infrastructure in human-readable, declarative configuration files, and manages your infrastructure's lifecycle.

To deploy infrastructure with Terraform:

Scope - Identify the infrastructure for your project.

Author - Write the configuration for your infrastructure.

Initialize - Install the plugins Terraform needs to manage the infrastructure.

Plan - Preview the changes Terraform will make to match your configuration.

Apply - Make the planned changes.

# Track your infrastructure
Terraform uses the state file to determine the changes to make to your infrastructure so that it will match your configuration.

# Collaborate
Terraform allows you to collaborate on your infrastructure with its remote state backends.

# Installation
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

# Resources
https://developer.hashicorp.com/tutorials/library?product=terraform

# Documentation
https://developer.hashicorp.com/terraform/docs

# Initialization
Run the terraform init command to initialize a working directory that contains a Terraform configuration. After initialization, you will be able to perform other commands, like terraform plan and terraform apply.

# Planning
 terraform plan presents a description of the changes necessary to achieve the desired state.

 # Applying
 terraform apply performs a fresh plan right before applying changes, and displays the plan to the user when asking for confirmation.

 # Destroying
 The terraform destroy command destroys all of the resources being managed by the current working directory and workspace, using state data to determine which real world objects correspond to managed resources.
