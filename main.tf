# main.tf

variable "vpc_cidr_block" {}

module "example_vpc" {
  source = "./modules/vpc"

  vpc_cidr_block = var.vpc_cidr_block
}

module "example_subnet" {
  source = "./modules/subnet"

  vpc_id           = module.example_vpc.vpc_id
  public_subnet    = true
  public_subnet_cidr_block = "10.0.1.0/24"
  private_subnet   = true
  private_subnet_cidr_block = "10.0.2.0/24"
}

module "example_nat_gateway" {
  source = "./modules/nat_gateway"

  subnet_id = module.example_subnet.public_subnet_id
}

module "example_vm" {
  source = "./modules/vm"

  subnet_id = module.example_subnet.private_subnet_id
  nat_public_ip = module.example_nat_gateway.nat_public_ip
}
