#---------------------------------------------------
# Create VPC
#---------------------------------------------------
resource "aws_vpc" "cloud_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_classiclink   = var.enable_classiclink

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name          = "${var.name}-${var.environment}"
    Orchestration = "${var.orchestration}"
    Environment   = "${var.environment}"
    CreatedBy     = "${var.createdby}"
  }
}