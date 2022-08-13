terraform {
  required_version = ">= 1.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
}
#ami-0c9354388bb36c088 Ubuntu 20.04 LTS


#module "s3" {
#  //source      = "git@github.com:anykey-igor/terraform_aws_s3.git"
#  source = "../terraform_aws_s3"
#  name        = "Terraform-Remote-State-S3-Bucket"
#  environment = "PROD"
#  #S3
#  aws_s3_bucket_name = "remote-state"
#
#  table_dynamodb_name     = "remote-state-table"
#  dynamodb_t_billing_mode = "PAY_PER_REQUEST"
#
#  enable_versioning = "Enabled"
#
#  force_destroy = "true"
#}

module "vpc" {
  #General
  source             = "../"
  name               = "Cloud-VPC"
  environment        = "PROD"
  availability_zones = ["eu-central-1a"]

  # VPC
  enable_vpc           = true
  vpc_name             = "My_VPC"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_classiclink   = false
  vpc_cidr             = "172.31.0.0/16"

  #Subnet
  name_public_subnet        = "My_public_subnet"
  public_subnet_cidrs       = ["172.31.10.0/24", "172.31.10.0/24", "172.31.10.0/24"]
  #map_public_ip_on_launch  = true #autoallocation public IP: default = true

  name_private_subnet       = "My_private_subnet"
  private_subnet_cidrs      = ["172.31.20.0/24", "172.31.21.0/24", "172.31.21.0/24"]
  #map_public_ip_on_launch  = true #autoallocation public IP: default = false

  name_database_subnet      = "My_database_subnet"
  database_subnet_cidr      = ["172.31.30.0/24", "172.31.31.0/24", "172.31.32.0/24"]
  #map_public_ip_on_launch  = false  #autoallocation public IP: default = false

  allowed_ports           = ["80", "443"]
  enable_all_egress_ports = "false"
  map_public_ip_on_launch = "true" #autoallocation public IP

  # Internet Gateway
  enable_internet_gateway = true

  # NAT
  enable_nat_gateway = true
  single_nat_gateway = true

  # DHCP
  enable_dhcp                          = true
  vpc_dhcp_options_domain_name         = "ec2.local"
  vpc_dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  # NACLs
  enable_network_acl  = true
  network_acl_ingress = []
  network_acl_egress  = []

  # EIP
  enable_eip = "false"
}
