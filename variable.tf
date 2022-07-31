#-----------------------------------------------------------
# Variable: global or default
#-----------------------------------------------------------
variable "region" {
  description = "The region where to deploy this code (e.g. eu-center-1)"
  default     = "eu-central-1"
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    #type        = list
    #default     = ["10.0.0.0/16"]
}

variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "Cloud-App"
}

variable "instance_tenancy" {
    description = "instance tenancy"
    default     = "default"
}

variable "enable_dns_support" {
    description = "Enabling dns support"
    default     = "true"
}

variable "enable_dns_hostnames" {
    description = "Enabling dns hostnames"
    default     = "true"
}

variable "enable_classiclink" {
    description = "Enabling classiclink"
    default     = "false"
}

variable "environment" {
    description = "Environment for service"
    default     = "TEST"
}

variable "orchestration" {
    description = "Type of Orchestration"
    default = "Terraform"
}

variable "createdby" {
    description = "Created by"
    default     = "Anikeiev Ihor"
}
