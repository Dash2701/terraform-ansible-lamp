
resource "aws_route_table" "webroute" {
  vpc_id = aws_vpc.lamp_vpc.id

  tags = merge({
    Name = "webroute-${terraform.workspace}"
  }, var.default_tags)
}


resource "aws_route_table" "dbroute" {
  vpc_id = aws_vpc.lamp_vpc.id

  tags = merge({
    Name = "dbroute-${terraform.workspace}"
  }, var.default_tags)
}


