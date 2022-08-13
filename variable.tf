# ---------------------------------------------------------------------------------------------------------------------
# General Variables
# ---------------------------------------------------------------------------------------------------------------------
variable "region" {
  description = "The region where to deploy this code (e.g. eu-center-1)"
  default     = "eu-central-1"
}
variable "availability_zones" {
  description = "A list of Availability zones in the region"
  type        = list(string)
  default     = []
}
variable "availability_zones_list" {
  description = "A list of Availability zones in the region"
  default = {
    us-east-1    = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
    us-east-2    = ["us-east-2a", "eu-east-2b", "eu-east-2c"]
    ca-central-1 = ["ca-central-1a", "ca-central-1b", "ca-central-1c"]
  }
}
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "DEMO"
}
variable "environment" {
  description = "Environment for service"
  default     = "TEST"
}
variable "orchestration" {
  description = "Type of Orchestration"
  default     = "Terraform"
}
variable "createdby" {
  description = "Created by"
  default     = "Anikeiev Ihor"
}
variable "tags" {
  description = "A list of tag blocks."
  type        = map(string)
  default     = {}
}

# ---------------------------------------------------------------------------------------------------------------------
# Config VPC Variables
# ---------------------------------------------------------------------------------------------------------------------
variable "enable_vpc" {
  description = "Enable VPC usage"
  default     = false
}
variable "vpc_name" {
  description = "Name to be used on all resources as prefix"
  default     = "Cloud-VPC"
}
variable "vpc_cidr" {
  description = "CIDR for the whole VPC"
  type        = string
  #default     = "10.0.0.0/16"
}
variable "instance_tenancy" {
  description = "(Optional) A tenancy option for instances launched into the VPC"
  default     = default
}
variable "enable_dns_support" {
  description = "(Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults true."
  type = bool
  default     = true
}
variable "enable_dns_hostnames" {
  description = "(Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false."
  type = bool
  default     = true
}
variable "enable_classiclink" {
  description = "(Optional) A boolean flag to enable/disable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic. See the ClassicLink documentation for more information. Defaults false. Dedicated tenancy VPCs cannot be enabled for ClassicLink by default"
  type = bool
  default     = false
}
variable "vpc_enable_classiclink_dns_support" {
  description = "(Optional) A boolean flag to enable/disable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic."
  default     = true
}

# ---------------------------------------------------------------------------------------------------------------------
# Config Variable Public Subnet
# ---------------------------------------------------------------------------------------------------------------------
variable "public_subnet_cidr" {
  description = "CIDR list for Public Subnets"
  type        = list(string)
  default     = []
}
variable "name_public_subnet" {
  description = "Name for Public Subnets"
  default     = "Cloud_Public_subnet"
}

# ---------------------------------------------------------------------------------------------------------------------
# Config Variable Private Subnet
# ---------------------------------------------------------------------------------------------------------------------
variable "private_subnet_cidr" {
  description = "CIDR list for Private Subnets"
  type        = list(string)
  default     = []
}
variable "name_private_subnet" {
  description = "Name for private subnets"
  default     = "Cloud_Private_subnet"
}

# ---------------------------------------------------------------------------------------------------------------------
# Config Variable DataBase Subnet
# ---------------------------------------------------------------------------------------------------------------------
variable "database_subnet_cidr" {
  description = "CIDR list for DataBase Subnets"
  type        = list(string)
  default     = []
}
variable "name_database_subnet" {
  description = "Name for DataBase subnets"
  default     = "Cloud_Database_subnet"
}

# ---------------------------------------------------------------------------------------------------------------------
# Add AWS internet gateway
# ---------------------------------------------------------------------------------------------------------------------
variable "enable_internet_gw" {
  description = "Allow Internet GateWay to/from public network"
  type        = bool
  default     = false
}
variable "internet_gw_name" {
  description = "Name for internet gw"
  type        = string
  default     = ""
}
variable "internet_gw_vpc_id" {
  description = "The VPC ID to create in."
  default     = ""
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS NAT
# ---------------------------------------------------------------------------------------------------------------------
variable "enable_nat_gw" {
  description = "Allow Nat GateWay to/from private network"
  type = bool
  default     = false
}
variable "single_nat_gw" {
  description = "should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type = bool
  default     = false
}
variable "nat_gw_name" {
  description = "Set name for NAT GW"
  type = string
  default     = ""
}
variable "nat_gw_connectivity_type" {
  description = "(Optional) Connectivity type for the gateway. Valid values are private and public. Defaults to public"
  default     = "public"
}

# ---------------------------------------------------------------------------------------------------------------------
# Create DHCP
# ---------------------------------------------------------------------------------------------------------------------
variable "enable_dhcp" {
  description = "Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type"
  type = bool
  default     = false
}

variable "vpc_dhcp_name" {
  description = "Set name for VPC DHCP"
  type = string
  default     = ""
}

variable "vpc_dhcp_options_domain_name" {
  description = "(Optional) the suffix domain name to use by default when resolving non Fully Qualified Domain Names. In other words, this is what ends up being the search value in the /etc/resolv.conf file."
  type = string
  default     = ""
}

variable "vpc_dhcp_options_domain_name_servers" {
  description = "(Optional) List of name servers to configure in /etc/resolv.conf. If you want to use the default AWS nameservers you should set this to AmazonProvidedDNS."
  type = list(string)
  default     = ["AmazonProvidedDNS"]
}

variable "vpc_dhcp_options_ntp_servers" {
  description = "(Optional) List of NTP servers to configure."
  default     = []
}

variable "vpc_dhcp_options_netbios_name_servers" {
  description = "(Optional) List of NETBIOS name servers."
  default     = []
}

variable "vpc_dhcp_options_netbios_node_type" {
  description = "(Optional) The NetBIOS node type (1, 2, 4, or 8). AWS recommends to specify 2 since broadcast and multicast are not supported in their network. For more information about these node types, see RFC 2132."
  default     = ""
}

# ---------------------------------------------------------------------------------------------------------------------
# DHCP Options Set Association
# ---------------------------------------------------------------------------------------------------------------------
variable "vpc_dhcp_options_association_dhcp_options_id" {
  description = "The ID of the DHCP Options Set to associate to the VPC."
  default     = ""
}

variable "vpc_dhcp_options_association_vpc_id" {
  description = "Set VPC_ID for dhcp options association"
  default     = ""
}
