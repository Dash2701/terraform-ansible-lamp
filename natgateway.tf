
/* resource "aws_eip" "gweip" {
  count      = var.nat_count
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
  tags = merge({
    Name = "eip-${count.index}-${terraform.workspace}"
  }, var.default_tags)
}


resource "aws_nat_gateway" "ngw" {
  count         = var.nat_count
  subnet_id     = element(aws_subnet.lbsubnet.*.id, count.index)
  allocation_id = element(aws_eip.gweip.*.id, count.index)
  tags = merge({
    Name = "ngw=${count.index}-${terraform.workspace}"
  }, var.default_tags)
} */