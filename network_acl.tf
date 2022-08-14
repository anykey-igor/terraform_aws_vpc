#---------------------------------------------------------------------------------------------------------------------
# Add AWS Network ACL
#
# https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule
#---------------------------------------------------------------------------------------------------------------------
resource "aws_network_acl" "network_acl" {
  count = var.enable_network_acl ? 1 : 0

  vpc_id     = var.network_acl_vpc_id != "" ? var.network_acl_vpc_id : (var.enable_vpc ? aws_vpc.cloud_vpc.id : null)
  subnet_ids = var.network_acl_subnet_ids != null ? var.network_acl_subnet_ids : concat(aws_subnet.public_subnets.*.id, aws_subnet.private_subnets.*.id, aws_subnet.database_subnets.*.id,)
  # Terraform provides both a standalone network ACL association resource and a network ACL resource with a subnet_ids attribute.
  #Do not use the same subnet ID in both a network ACL resource and a network ACL association resource. Doing so will cause a conflict of associations and will overwrite the association.

  dynamic "ingress" {
    iterator = ingress
    for_each = var.network_acl_ingress

    content {
      from_port       = lookup(ingress.value, "from_port", 0)
      to_port         = lookup(ingress.value, "to_port", 0)
      rule_no         = lookup(ingress.value, "rule_no", 100)
      action          = lookup(ingress.value, "action", "allow")
      protocol        = lookup(ingress.value, "protocol", -1)
      cidr_block      = lookup(ingress.value, "cidr_block", "0.0.0.0/0")
      ipv6_cidr_block = lookup(ingress.value, "ipv6_cidr_block", "::/0")
      icmp_type       = lookup(ingress.value, "icmp_type", 0)
      icmp_code       = lookup(ingress.value, "icmp_code", 0)
    }
  }

  dynamic "egress" {
    iterator = egress
    for_each = var.network_acl_egress

    content {
      from_port       = lookup(egress.value, "from_port", 0)
      to_port         = lookup(egress.value, "to_port", 0)
      rule_no         = lookup(egress.value, "rule_no", 100)
      action          = lookup(egress.value, "action", "allow")
      protocol        = lookup(egress.value, "protocol", -1)
      cidr_block      = lookup(egress.value, "cidr_block", "0.0.0.0/0")
      ipv6_cidr_block = lookup(egress.value, "ipv6_cidr_block", "::/0")
      icmp_type       = lookup(egress.value, "icmp_type", 0)
      icmp_code       = lookup(egress.value, "icmp_code", 0)
    }
  }
  tags = merge(
    {
      Name = var.network_acl_name != "" ? lower(var.network_acl_name) : "${lower(var.name)}-network-acl-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpc.cloud_vpc
  ]
}

#---------------------------------------------------------------------------------------------------------------------
# AWS VPC network acl rule
#---------------------------------------------------------------------------------------------------------------------
resource "aws_network_acl_rule" "network_acl_rule" {
  count = var.enable_network_acl_rule ? length(var.network_acl_rule_parameter) : 0

  network_acl_id = lookup(var.network_acl_rule_parameter[count.index], "network_acl_id", (var.enable_network_acl ? element(aws_network_acl.network_acl.*.id, 0) : null))
  rule_number    = lookup(var.network_acl_rule_parameter[count.index], "rule_number", null)
  protocol       = lookup(var.network_acl_rule_parameter[count.index], "protocol", null)
  rule_action    = lookup(var.network_acl_rule_parameter[count.index], "rule_action", null)

  egress          = lookup(var.network_acl_rule_parameter[count.index], "egress", null)
  cidr_block      = lookup(var.network_acl_rule_parameter[count.index], "cidr_block", (var.enable_vpc ? element(aws_vpc.cloud_vpc.*.cidr_block, 0) : null))
  ipv6_cidr_block = lookup(var.network_acl_rule_parameter[count.index], "ipv6_cidr_block", null)
  from_port       = lookup(var.network_acl_rule_parameter[count.index], "from_port", null)
  to_port         = lookup(var.network_acl_rule_parameter[count.index], "to_port", null)
  icmp_type       = lookup(var.network_acl_rule_parameter[count.index], "icmp_type", null)
  icmp_code       = lookup(var.network_acl_rule_parameter[count.index], "icmp_code", null)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpc.cloud_vpc,
    aws_network_acl.network_acl
  ]
}