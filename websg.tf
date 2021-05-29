resource "aws_security_group" "websg" {
  name        = "websg-${terraform.workspace}"
  description = "controls access to the LB"
  vpc_id      = aws_vpc.lamp_vpc.id
  tags = merge(
    {
      "Name" : "websg-${terraform.workspace}"
    }, var.default_tags
  )
}


resource "aws_security_group_rule" "lb_to_web" {
  security_group_id        = aws_security_group.websg.id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.lbsg.id
}



resource "aws_security_group_rule" "debuglaptop" {
  security_group_id = aws_security_group.websg.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["${var.personal_laptop_ip}/32"]
}

resource "aws_security_group_rule" "ssh" {
  security_group_id = aws_security_group.websg.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.personal_laptop_ip}/32"]

}


resource "aws_security_group_rule" "icmp" {
  security_group_id = aws_security_group.websg.id
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["${var.personal_laptop_ip}/32"]

}



resource "aws_security_group_rule" "web_egress" {
  security_group_id = aws_security_group.websg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

