# ---------------------------------------------------------------------------------------------------------------------
# General Variables
# ---------------------------------------------------------------------------------------------------------------------
variable "region" {
  description = "The region where to deploy this code (e.g. eu-center-1)"
  default     = "eu-central-1"
}
variable "vpc_id" {
  default = ""
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
    eu-central-1 = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  }
}
variable "availability_zone_id" {
  description = "(Optional) The AZ ID of the subnet."
  default     = null
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
# Variable for Config VPC Variables
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
  default     = "default"
}
variable "enable_dns_support" {
  description = "(Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults true."
  type        = bool
  default     = true
}
variable "enable_dns_hostnames" {
  description = "(Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false."
  type        = bool
  default     = true
}
variable "enable_classiclink" {
  description = "(Optional) A boolean flag to enable/disable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic. See the ClassicLink documentation for more information. Defaults false. Dedicated tenancy VPCs cannot be enabled for ClassicLink by default"
  type        = bool
  default     = false
}
variable "vpc_enable_classiclink_dns_support" {
  description = "(Optional) A boolean flag to enable/disable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic."
  default     = false
}

# ---------------------------------------------------------------------------------------------------------------------
# Variable for Config Public Subnet
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
# Variable for Config Private Subnet
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
# Variable for Config DataBase Subnet
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
# Variable for AWS Internet Gateway
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
# Variable for AWS NAT
# ---------------------------------------------------------------------------------------------------------------------
variable "enable_nat_gw" {
  description = "Allow Nat GateWay to/from private network"
  type        = bool
  default     = false
}
variable "single_nat_gw" {
  description = "should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = false
}
variable "nat_gw_name" {
  description = "Set name for NAT GW"
  type        = string
  default     = ""
}
variable "nat_gw_connectivity_type" {
  description = "(Optional) Connectivity type for the gateway. Valid values are private and public. Defaults to public"
  default     = "public"
}

# ---------------------------------------------------------------------------------------------------------------------
# Variable for Create DHCP
#
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options
# https://docs.aws.amazon.com/vpc/latest/userguide/DHCPOptionSetConcepts.html
# ---------------------------------------------------------------------------------------------------------------------
variable "enable_dhcp" {
  description = "Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type"
  type        = bool
  default     = false
}
variable "vpc_dhcp_name" {
  description = "Set name for VPC DHCP"
  type        = string
  default     = ""
}
variable "vpc_dhcp_options_domain_name" {
  description = "(Optional) the suffix domain name to use by default when resolving non Fully Qualified Domain Names. In other words, this is what ends up being the search value in the /etc/resolv.conf file."
  type        = string
  default     = ""
}
variable "vpc_dhcp_options_domain_name_servers" {
  description = "(Optional) List of name servers to configure in /etc/resolv.conf. If you want to use the default AWS nameservers you should set this to AmazonProvidedDNS."
  type        = list(string)
  default     = ["AmazonProvidedDNS"]
}
variable "vpc_dhcp_options_ntp_servers" {
  description = "(Optional) List of NTP servers to configure."
  type        = list(string)
  default     = []
}
variable "vpc_dhcp_options_netbios_name_servers" {
  description = "(Optional) List of NETBIOS name servers."
  type        = list(string)
  default     = []
}
variable "vpc_dhcp_options_netbios_node_type" {
  description = "(Optional) The NetBIOS node type (1, 2, 4, or 8). AWS recommends to specify 2 since broadcast and multicast are not supported in their network. For more information about these node types, see RFC 2132."
  default     = ""
}

#--------------------------------------------------------------------------------------------------------------------
# Variable for DHCP Options Set Association
#---------------------------------------------------------------------------------------------------------------------
variable "vpc_dhcp_options_association_dhcp_options_id" {
  description = "The ID of the DHCP Options Set to associate to the VPC."
  default     = ""
}
variable "vpc_dhcp_options_association_vpc_id" {
  description = "Set VPC_ID for dhcp options association"
  default     = ""
}

#---------------------------------------------------------------------------------------------------------------------
# Variable for AWS EIP
#---------------------------------------------------------------------------------------------------------------------
variable "enable_eip" {
  description = "Allow creation elastic eip"
  default     = false
}
variable "nat_eip_name" {
  description = "Set name for NAT EIP"
  default     = ""
}
variable "nat_eip_vpc" {
  description = "(Optional) Boolean if the EIP is in a VPC or not."
  default     = true
}
variable "nat_eip_instance" {
  description = "(Optional) EC2 instance ID."
  default     = null
}
variable "nat_eip_network_interface" {
  description = "(Optional) Network interface ID to associate with."
  default     = null
}
variable "nat_eip_associate_with_private_ip" {
  description = "(Optional) A user specified primary or secondary private IP address to associate with the Elastic IP address. If no private IP address is specified, the Elastic IP address is associated with the primary private IP address."
  default     = null
}

#---------------------------------------------------------------------------------------------------------------------
# Variable for AWS VPC Network ACL
#---------------------------------------------------------------------------------------------------------------------
variable "enable_network_acl" {
  description = "Enable network acl for VPC usage"
  type        = bool
  default     = false
}

variable "network_acl_name" {
  description = "Set name for VPC network acl"
  type        = string
  default     = ""
}

variable "network_acl_subnet_ids" {
  description = "(Optional) A list of Subnet IDs to apply the ACL to"
  default     = null
}

variable "network_acl_vpc_id" {
  description = "Set vpc_id for NACL"
  default     = ""
}

variable "network_acl_ingress" {
  description = "(Optional) Specifies an ingress rule. Parameters defined below. This argument is processed in attribute-as-blocks mode."
  default     = []
}

variable "network_acl_egress" {
  description = "(Optional) Specifies an egress rule. Parameters defined below. This argument is processed in attribute-as-blocks mode."
  default     = []
}

#---------------------------------------------------------------------------------------------------------------------
# Variable for AWS VPC Network ACL rule
#
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule
#---------------------------------------------------------------------------------------------------------------------
variable "enable_network_acl_rule" {
  description = "Enable VPC network acl rule usage"
  type        = bool
  default     = false
}
variable "network_acl_rule_parameter" {
  description = "Set NACLs rules."
  default = [
    {
      network_acl_id = null
      rule_number    = null
      protocol       = null
      rule_action    = null

      egress          = null
      cidr_block      = null
      ipv6_cidr_block = null
      from_port       = null
      to_port         = null
      icmp_type       = null
      icmp_code       = null
    }
  ]
}

#---------------------------------------------------------------------------------------------------------------------
# Variable for AWS Default Route Table
#---------------------------------------------------------------------------------------------------------------------
variable "manage_default_route_table" {
  description = "Should be true to manage default route table"
  type        = bool
  default     = false
}
variable "default_router_table_id" {
  description = "default router table ID"
  default = null
}
variable "default_route_table_name" {
  description = "Name to be used on the default route table"
  type        = string
  default     = null
}
variable "default_route_table_propagating_vgws" {
  description = "List of virtual gateways for propagation"
  type        = list(string)
  default     = []
}
variable "default_route_table_routes" {
  description = "Configuration block of routes. See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table#route"
  type        = list(map(string))
  default     = []
}
#---------------------------------------------------------------------------------------------------------------------
# Variable for AWS Public route tables
#---------------------------------------------------------------------------------------------------------------------
variable "public_route_tables_name" {
  description = "Set name for public route tables"
  default     = ""
}
variable "public_route_tables_propagating_vgws" {
  description = "A list of VGWs the public route table should propagate."
  default     = null
}
variable "public_route_tables_vpc_id" {
  description = "The VPC ID."
  default     = ""
}
variable "public_route_tables_route_ipv4" {
  description = "The CIDR block of the route for IPv4."
  default     = []
}
variable "public_route_tables_route_ipv6" {
  description = "(Optional) The Ipv6 CIDR block of the route."
  default     = []
}

#---------------------------------------------------------------------------------------------------------------------
# Variable for AWS Private Route Tables
#---------------------------------------------------------------------------------------------------------------------
variable "private_route_tables_name" {
  description = "Set name for private route tables"
  default     = ""
}
variable "private_route_tables_propagating_vgws" {
  description = "A list of VGWs the private route table should propagate."
  default     = null
}
variable "private_route_tables_vpc_id" {
  description = "The VPC ID."
  default     = ""
}
variable "private_route_tables_route_ipv4" {
  description = "The CIDR block of the route for IPv4."
  default     = []
}
variable "private_route_tables_route_ipv6" {
  description = "(Optional) The Ipv6 CIDR block of the route."
  default     = []
}

#---------------------------------------------------------------------------------------------------------------------
# Database route tables
#---------------------------------------------------------------------------------------------------------------------
variable "enable_database_route_tables" {
  description = "Enable database Route Tables"
  default     = false
}
variable "database_route_tables_name" {
  description = "Set name for custom Route Tables"
  default     = ""
}
variable "database_route_tables_vpc_id" {
  description = "The VPC ID."
  default     = ""
}
variable "database_route_tables_propagating_vgws" {
  description = "(Optional) A list of virtual gateways for propagation."
  default     = null
}

variable "database_route_tables_route_ipv4" {
  description = "The CIDR block of the route for IPv4."
  default     = []
}

variable "database_route_tables_route_ipv6" {
  description = "(Optional) The Ipv6 CIDR block of the route."
  default     = []
}

#---------------------------------------------------
# AWS Route Table Associations
#---------------------------------------------------
variable "enable_custom_route_table_associations" {
  description = "Enable custom route table associations usage"
  default     = false
}

variable "custom_route_table_associations_stack" {
  description = "Set route table associations"
  default     = []
}