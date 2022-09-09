#---------------------------------------------------
# AWS Route Table Associations
#---------------------------------------------------
# public
resource "aws_route_table_association" "public_route_table_associations" {
  count = length(var.public_subnet_cidr)

  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.public_route_tables.*.id, count.index)

  depends_on = [
    aws_route_table.public_route_tables,
    aws_subnet.public_subnets
  ]
}

# private
resource "aws_route_table_association" "private_route_table_associations" {
  count = length(var.private_subnet_cidr)

  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = element(aws_route_table.private_route_tables.*.id, count.index)

  depends_on = [
    aws_route_table.private_route_tables,
    aws_subnet.private_subnets
  ]
}

# Database
resource "aws_route_table_association" "database_route_table_associations" {
  count = length(var.database_subnet_cidr)

  subnet_id      = aws_subnet.database_subnets[count.index].id
  route_table_id = element(aws_route_table.database_route_tables.*.id, count.index)

  depends_on = [
    aws_route_table.database_route_tables,
    aws_subnet.database_subnets
  ]
}


# custom
#resource "aws_route_table_association" "custom_route_table_associations" {
#  count = var.enable_database_route_tables ? length(var.custom_route_table_associations_stack) : 0
#
#  subnet_id      = lookup(var.custom_route_table_associations_stack[count.index], "subnet_id", null)
#  route_table_id = lookup(var.custom_route_table_associations_stack[count.index], "route_table_id", (var.enable_custom_route_tables ? element(aws_route_table.custom_route_tables.*.id, 0) : null))
#
#  depends_on = [
#    aws_route_table.custom_route_tables
#  ]
#}