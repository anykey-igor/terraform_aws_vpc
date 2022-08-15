#---------------------------------------------------------------------------------------------------------------------
# Add AWS NAT Gateway
#---------------------------------------------------------------------------------------------------------------------
resource "aws_nat_gateway" "nat_gw" {
  count = var.enable_nat_gw ? (var.single_nat_gw ? 1 : (length(var.availability_zones) > 0 ? length(var.availability_zones) : length(lookup(var.availability_zones_list, var.region)))) : 0

  subnet_id         = element(aws_subnet.public_subnets.*.id, (var.single_nat_gw ? 0 : count.index))
  allocation_id     = element(aws_eip.nat_eip.*.id, (var.single_nat_gw ? 0 : count.index))
  connectivity_type = var.nat_gw_connectivity_type  # default in AWS "public"

  tags = merge(
    {
      Name = var.nat_gw_name != "" ? lower(var.nat_gw_name) : "${lower(var.name)}-nat-gw-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_eip.nat_eip,
    aws_subnet.public_subnets
  ]
}