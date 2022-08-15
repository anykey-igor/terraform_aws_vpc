output "instance_tenancy" {
    value = aws_vpc.cloud_vpc.instance_tenancy
}

output "vpc_id" {
    value = aws_vpc.cloud_vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.cloud_vpc.cidr_block
}

output "region_use" {
  value = var.region

}