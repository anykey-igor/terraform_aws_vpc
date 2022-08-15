#---------------------------------------------------------------------------------------------------------------------
# Add AWS internet gateway
#
# https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
#---------------------------------------------------------------------------------------------------------------------
resource "aws_internet_gateway" "internet_gateway" {
  count = var.enable_internet_gw && length(var.public_subnet_cidr) > 0 ? 1 : 0

  vpc_id = var.internet_gw_vpc_id != "" ? var.internet_gw_vpc_id : (var.enable_vpc ? element(aws_vpc.cloud_vpc.*.id, 0) : null)

  tags = merge(
    {
      Name = var.internet_gw_name != "" ? lower(var.internet_gw_name) : "${lower(var.name)}-internet-gw-${lower(var.environment)}"
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