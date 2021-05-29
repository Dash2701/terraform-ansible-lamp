
resource "aws_subnet" "websubnets" {
  count                = var.az_count
  vpc_id               = aws_vpc.lamp_vpc.id
  cidr_block           = cidrsubnet(aws_vpc.lamp_vpc.cidr_block, 2, count.index)
  availability_zone_id = data.aws_availability_zones.available.zone_ids[count.index]

  tags = merge(
    {
      "Name" : "web-subnet-${count.index}-${terraform.workspace}"
  }, var.default_tags)

}

resource "aws_subnet" "dbsubnets" {
  count                = var.az_count
  vpc_id               = aws_vpc.lamp_vpc.id
  cidr_block           = cidrsubnet(aws_vpc.lamp_vpc.cidr_block, 2, count.index + 2)
  availability_zone_id = data.aws_availability_zones.available.zone_ids[count.index]

  tags = merge(
    {
      "Name" : "db-subnet-${count.index}-${terraform.workspace}"
  }, var.default_tags)

}


resource "aws_db_subnet_group" "databasegroup" {
  name       = "lampdb"
  subnet_ids = aws_subnet.dbsubnets.*.id

  tags = merge(
    {
      "Name" : "db-subnetgroup-${terraform.workspace}"
  }, var.default_tags)
}