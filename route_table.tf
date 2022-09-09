#---------------------------------------------------------------------------------------------------------------------
# Add AWS Route table
#---------------------------------------------------------------------------------------------------------------------
# Default route table
#----------------------------------------------------------------------------------------------------------------------

resource "aws_default_route_table" "default" {
  count = var.enable_vpc && var.manage_default_route_table ? 1 : 0

  default_route_table_id = var.default_router_table_id != null ? var.default_router_table_id : element(aws_vpc.cloud_vpc.*.default_route_table_id, 0) #aws_vpc.cloud_vpc[0].default_route_table_id
  propagating_vgws       = var.default_route_table_propagating_vgws

  dynamic "route" {
    for_each = var.default_route_table_routes
    content {
      # One of the following destinations must be provided
      cidr_block      = route.value.cidr_block
      ipv6_cidr_block = lookup(route.value, "ipv6_cidr_block", null)

      # One of the following targets must be provided
      egress_only_gateway_id    = lookup(route.value, "egress_only_gateway_id", null)
      gateway_id                = lookup(route.value, "gateway_id", null)
      instance_id               = lookup(route.value, "instance_id", null)
      nat_gateway_id            = lookup(route.value, "nat_gateway_id", null)
      network_interface_id      = lookup(route.value, "network_interface_id", null)
      transit_gateway_id        = lookup(route.value, "transit_gateway_id", null)
      vpc_endpoint_id           = lookup(route.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route.value, "vpc_peering_connection_id", null)
    }
  }

  timeouts {
    create = "5m"
    update = "5m"
  }

  tags = merge(
    { "Name" = coalesce(var.default_route_table_name, var.name) },
    var.tags,
    #var.default_route_table_tags,
  )
}

#----------------------------------------------------------------------------------------------------------------------
# Create public route table
#----------------------------------------------------------------------------------------------------------------------
resource "aws_route_table" "public_route_tables" {
  count = length(var.public_subnet_cidr) > 0 ? 1 : 0

  vpc_id = var.public_route_tables_vpc_id != "" ? var.public_route_tables_vpc_id : (var.enable_vpc ? element(aws_vpc.cloud_vpc.*.id, 0) : null) #aws_vpc.cloud_vpc.0.id : null)

  propagating_vgws = var.public_route_tables_propagating_vgws

  dynamic "route" {
    iterator = route_ipv4
    for_each = var.public_route_tables_route_ipv4

    content {
      cidr_block = lookup(route_ipv4.value, "cidr_block", "0.0.0.0/0")
      gateway_id = lookup(route_ipv4.value, "gateway_id", null)

      egress_only_gateway_id    = lookup(route_ipv4.value, "egress_only_gateway_id", null)
      nat_gateway_id            = lookup(route_ipv4.value, "nat_gateway_id", null)
      local_gateway_id          = lookup(route_ipv4.value, "local_gateway_id", null)
      network_interface_id      = lookup(route_ipv4.value, "network_interface_id", null)
      transit_gateway_id        = lookup(route_ipv4.value, "transit_gateway_id", null)
      vpc_endpoint_id           = lookup(route_ipv4.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route_ipv4.value, "vpc_peering_connection_id", null)
    }
  }

  tags = merge(
    {
      Name = var.public_route_tables_name != "" ? lower(var.public_route_tables_name) : "${lower(var.name)}-public-route-tables-${lower(var.environment)}"
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

#----------------------------------------------------------------------------------------------------------------------
# Create private route table and the route to the internet
#----------------------------------------------------------------------------------------------------------------------
resource "aws_route_table" "private_route_tables" {
  #count = length(var.private_subnet_cidr) > 0 ? 1 : 0
  #count = var.single_nat_gw ? length(var.availability_zones) > 0 ? length(var.availability_zones) : element(lookup(var.availability_zones_list, var.region), count.index) : 0
  count = var.enable_nat_gw && length(var.private_subnet_cidr) > 0 ? (var.single_nat_gw ? 1 : (length(var.availability_zones) > 0 ? length(var.availability_zones) : length(lookup(var.availability_zones_list, var.region)))) : 0
  vpc_id = var.private_route_tables_vpc_id != "" ? var.private_route_tables_vpc_id : (var.enable_vpc ? element(aws_vpc.cloud_vpc.*.id, 0) : null)

  propagating_vgws = var.private_route_tables_propagating_vgws

  dynamic "route" {
    iterator = route_ipv4
    for_each = var.private_route_tables_route_ipv4

    content {
      cidr_block = lookup(route_ipv4.value, "cidr_block", "0.0.0.0/0")
      gateway_id = lookup(route_ipv4.value, "gateway_id", null)

      egress_only_gateway_id    = lookup(route_ipv4.value, "egress_only_gateway_id", null)
      nat_gateway_id            = lookup(route_ipv4.value, "nat_gateway_id", null)
      local_gateway_id          = lookup(route_ipv4.value, "local_gateway_id", null)
      network_interface_id      = lookup(route_ipv4.value, "network_interface_id", null)
      transit_gateway_id        = lookup(route_ipv4.value, "transit_gateway_id", null)
      vpc_endpoint_id           = lookup(route_ipv4.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route_ipv4.value, "vpc_peering_connection_id", null)
    }
  }

  tags = merge(
    {
      Name = var.private_route_tables_name != "" ? lower(var.private_route_tables_name) : "${lower(var.name)}-private-route-tables-${lower(var.environment)}"
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

#----------------------------------------------------------------------------------------------------------------------
# Create database route table and the route to the internet or without
#----------------------------------------------------------------------------------------------------------------------
resource "aws_route_table" "database_route_tables" {
 # count = length(var.database_subnet_cidr) > 0 ? 1 : 0
  count = var.enable_vpc && var.create_database_subnet_route_table && length(var.database_subnet_cidr) > 0 ? var.single_nat_gw || var.create_database_internet_gateway_route ? 1 : length(var.database_subnet_cidr) : 1

  vpc_id = var.database_route_tables_vpc_id != "" ? var.database_route_tables_vpc_id : (var.enable_vpc ? element(aws_vpc.cloud_vpc.*.id, 0) : null) #aws_vpc.cloud_vpc.0.id : null)

  tags = merge(
    {
      Name = var.database_route_tables_name != "" ? lower(var.database_route_tables_name) : "${lower(var.name)}-database-route-tables-${lower(var.environment)}"
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