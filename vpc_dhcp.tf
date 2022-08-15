#---------------------------------------------------------------------------------------------------------------------
# AWS VPC DHCP
#
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options
# https://docs.aws.amazon.com/vpc/latest/userguide/DHCPOptionSetConcepts.html
#---------------------------------------------------------------------------------------------------------------------
resource "aws_vpc_dhcp_options" "vpc_dhcp_options" {
  count = var.enable_dhcp ? 1 : 0

  domain_name          = var.vpc_dhcp_options_domain_name
  domain_name_servers  = var.vpc_dhcp_options_domain_name_servers
  ntp_servers          = var.vpc_dhcp_options_ntp_servers
  netbios_name_servers = var.vpc_dhcp_options_netbios_name_servers
  netbios_node_type    = var.vpc_dhcp_options_netbios_node_type

  tags = merge(
    {
      Name = var.vpc_dhcp_name != "" ? lower(var.vpc_dhcp_name) : "${lower(var.name)}-vpc-dhcp-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}

#---------------------------------------------------------------------------------------------------------------------
# AWS DHCP Options Set Association
#
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options_association
#---------------------------------------------------------------------------------------------------------------------
resource "aws_vpc_dhcp_options_association" "vpc_dhcp_options_association" {
  count = var.enable_dhcp ? 1 : 0

  vpc_id          = var.vpc_dhcp_options_association_vpc_id != "" ? var.vpc_dhcp_options_association_vpc_id : (var.enable_vpc ? element(aws_vpc.cloud_vpc.*.id, count.index) : null)
  dhcp_options_id = var.vpc_dhcp_options_association_dhcp_options_id != "" ? var.vpc_dhcp_options_association_dhcp_options_id : element(aws_vpc_dhcp_options.vpc_dhcp_options.*.id, count.index)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpc.cloud_vpc,
    aws_vpc_dhcp_options.vpc_dhcp_options
  ]
}