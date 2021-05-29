resource "aws_vpc" "lamp_vpc" {
  cidr_block = var.vpc_cidr

  tags = merge(
    {
      "Name" : "lamp-vpc-${terraform.workspace}"
  }, var.default_tags)
}



# get the current availability zones 
data "aws_availability_zones" "available" {
  state = "available"
}