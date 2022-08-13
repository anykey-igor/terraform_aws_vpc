# ---------------------------------------------------------------------------------------------------------------------
# Create AWS VPC - cloud_vpc
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_vpc" "cloud_vpc" {

  cidr_block                     = var.vpc_cidr
  instance_tenancy               = var.instance_tenancy
  enable_dns_support             = var.enable_dns_support
  enable_dns_hostnames           = var.enable_dns_hostnames
  enable_classiclink             = var.enable_classiclink
  enable_classiclink_dns_support = var.vpc_enable_classiclink_dns_support


  lifecycle {
    create_before_destroy = true
  }


  tags = merge(
    {
      Name = var.vpc_name != "" ? lower(var.vpc_name) : "${lower(var.name)}-vpc-${lower(var.environment)}"
    },
    var.tags
  )

  #  tags = {
  #    Name          = "${var.name}-vpc-${var.environment}"
  #    Orchestration = "${var.orchestration}"
  #    Environment   = "${var.environment}"
  #    CreatedBy     = "${var.createdby}"
  #  }
}