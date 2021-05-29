data "aws_ami" "ubuntu" {

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}


resource "aws_instance" "lampsetup" {
  count                       = var.az_count
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.websubnets[count.index % var.az_count].id
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.websg.id]
  associate_public_ip_address = true


  root_block_device {
    volume_size           = var.root_volume_size
    delete_on_termination = true
    encrypted             = true
    volume_type           = "gp2"

    tags = merge({
      Name = "rootVolume-${count.index}-${terraform.workspace}"
    }, var.default_tags)
  }


  user_data = file("installAnsibleUbuntu.sh")


  tags = merge({
    Name = "Lamp-${count.index}-${terraform.workspace}"
  }, var.default_tags)
}
 