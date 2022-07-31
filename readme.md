# How to working with VPC module via Terraform

Import the module and retrieve whit terraform get or terraform get --update

Add a module to your resource template main.tf

### Exaple:
```terraform
# Provider
provider "aws" {
  region = "eu-central-1"
}

# VPC module
module "vpc" {
  source               = "../terraform_aws_vpc"
  name                 = "Cloud-VPC"
  environment          = "PROD"
  # VPC
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  vpc_cidr             = "172.31.0.0/16"
}
```

# Module Input Variables
 
+ ```region``` - The region where to deploy this code (```eu-center-1```)
+ ```name``` - Name to be used on all resources as prefix (```default = TEST```)
+ ```environment``` - Environment for service (```default = TEST```)
+ ```instance_tenancy``` -  
+ ```enable_dns_support``` - 
+ ```enable_dns_hostname``` - 
+ ```enable_classiclink``` - 
+ ```vpc_cidr``` - 