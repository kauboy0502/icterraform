terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.48.0"
    }
     random = {
      source = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

provider "random" {
  
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules-tf/vpc"
}

module "ec2" {
    source = "./modules-tf/ec2"
    depends_on = [
      module.vpc
    ]
    subnetpublic = module.vpc.pub_subnets
    sgs = module.vpc.security_group_ic
}


module "rds" {
  source = "./modules-tf/rds"
  sgs=module.vpc.security_group_ic
  dbsubgrp = module.vpc.pri_subnets
  depends_on = [
    module.vpc
  ]
  
}
