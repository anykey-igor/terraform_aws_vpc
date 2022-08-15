#---------------------------------------------------------------------------------------------------------------------
# AWS EIP
#---------------------------------------------------------------------------------------------------------------------
resource "aws_eip" "nat_eip" {
  count = var.enable_nat_gw ? (var.single_nat_gw ? 1 : (length(var.availability_zones) > 0 ? length(var.availability_zones) : length(lookup(var.availability_zones_list, var.region)))) : 0

  vpc               = var.nat_eip_vpc
  instance          = var.nat_eip_instance
  network_interface = var.nat_eip_network_interface

  tags = merge(
    {
      Name = var.nat_eip_name != "" ? lower(var.nat_eip_name) : "${lower(var.name)}-nat-eip-${count.index + 1}-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}