/* resource "aws_subnet" "private_subnet0" {
  count                   = var.private_subnet0_should_be_created ? 1 : 0
  vpc_id                  = var.vpc_id
  cidr_block              = var.private_subnet0_cidr_block
  availability_zone       = var.private_subnet0_availability_zone

  tags = {
    Name = var.private_subnet0_name
  }
}

resource "aws_subnet" "private_subnet1" {
  count                   = var.private_subnet1_should_be_created ? 1 : 0
  vpc_id                  = var.vpc_id
  cidr_block              = var.private_subnet1_cidr_block
  availability_zone       = var.private_subnet1_availability_zone

  tags = {
    Name = var.private_subnet1_name
  }
} */

resource "aws_subnet" "private_subnet" {
  for_each = var.p-subnets
 
  availability_zone_id = each.value["az"]
  cidr_block = each.value["cidr"]
  vpc_id     = var.vpc_id

  tags = {
    Name = var.private_subnet_name
  }
}
