#----------------------------------------------------------------------------------------------------------------------
# Add AWS Route
#----------------------------------------------------------------------------------------------------------------------
# Create route table for public internet gateway
#----------------------------------------------------------------------------------------------------------------------
resource "aws_route" "public_internet_gateway" {
  count = var.enable_internet_gw && length(var.public_subnet_cidr) > 0 ? 1 : 0

  route_table_id         = element(aws_route_table.public_route_tables.*.id, 0)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = element(aws_internet_gateway.internet_gateway.*.id, 0)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_route_table.public_route_tables,
    aws_internet_gateway.internet_gateway
  ]
}

#----------------------------------------------------------------------------------------------------------------------#
# Create route table for private NAT gateway
#----------------------------------------------------------------------------------------------------------------------
resource "aws_route" "private_nat_gateway" {
  count = var.enable_nat_gw && length(var.private_subnet_cidr) > 0 ? (var.single_nat_gw ? 1 : (length(var.availability_zones) > 0 ? length(var.availability_zones) : length(lookup(var.availability_zones_list, var.region)))) : 0

  route_table_id         = element(aws_route_table.private_route_tables.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat_gw.*.id, count.index)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_route_table.private_route_tables,
    aws_nat_gateway.nat_gw
  ]
}

#----------------------------------------------------------------------------------------------------------------------
# Create Database route
#----------------------------------------------------------------------------------------------------------------------
#resource "aws_route" "database_custom" {
#  count = var.enable_nat_gw && length(var.private_subnet_cidr) > 0 ? (var.single_nat_gw ? 1 : (length(var.availability_zones) > 0 ? length(var.availability_zones) : length(lookup(var.availability_zones_list, var.region)))) : 0
#
#  route_table_id         = element(aws_route_table.private_route_tables.*.id, count.index)
#  destination_cidr_block = "0.0.0.0/0"
#  nat_gateway_id         = element(aws_nat_gateway.nat_gw.*.id, count.index)
#
#  lifecycle {
#    create_before_destroy = true
#    ignore_changes        = []
#  }
#
#  depends_on = [
#    aws_route_table.private_route_tables,
#    aws_nat_gateway.nat_gw
#  ]
#}