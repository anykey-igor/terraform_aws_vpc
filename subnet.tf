# ---------------------------------------------------------------------------------------------------------------------
# Add AWS Subnet to VPC - public
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnet_cidr)

  cidr_block              = var.public_subnet_cidr[count.index]
  vpc_id                  = aws_vpc.cloud_vpc.id
  availability_zone = length(var.availability_zones) > 0 ? var.public_subnet_cidr[count.index] : element(lookup(var.availability_zones_list, var.region ), count.index)
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name = var.name_public_subnet != "" ? "${lower(var.name_public_subnet)}-${count.index + 1}" : "${lower(var.name)}-${lower(var.environment)}-public_subnet-${count.index + 1}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    #ignore_changes        = []
  }

    depends_on = [
    aws_vpc.cloud_vpc
  ]

}

# ---------------------------------------------------------------------------------------------------------------------
# Add AWS Subnet to VPC - private
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_cidr)

  cidr_block              = var.private_subnet_cidr[count.index]
  vpc_id                  = aws_vpc.cloud_vpc.id
  map_public_ip_on_launch = false
  availability_zone       = length(var.availability_zones) > 0 ? var.private_subnet_cidr[count.index] : element(lookup(var.availability_zones_list, var.region ), count.index)

  tags = merge(
    {
      Name = var.name_private_subnet != "" ? "${lower(var.name_private_subnet)}-${count.index + 1}" : "${lower(var.name)}-${lower(var.environment)}-private_subnet-${count.index + 1}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    #ignore_changes        = []
  }

  depends_on = [
    aws_vpc.cloud_vpc
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# Add AWS Subnet to VPC - database
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_subnet" "database_subnet" {
  count = length(var.private_subnet_cidr)

  cidr_block              = var.database_subnet_cidr[count.index]
  vpc_id                  = aws_vpc.cloud_vpc.id
  map_public_ip_on_launch = false

  tags = merge(
    {
      Name = var.name_database_subnet != "" ? "${lower(var.name_database_subnet)}-${count.index + 1}" : "${lower(var.name)}-${lower(var.environment)}-database_subnet-${count.index + 1}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    #ignore_changes        = []
  }

  depends_on = [
    aws_vpc.cloud_vpc
  ]
}