resource "aws_instance" "bastion" {
  count                       = 1
  ami                         = "${var.bastion_server_ami}"
  instance_type               = "t1.micro"
  associate_public_ip_address = true
  key_name                    = "${var.key_name}"
  source_dest_check           = false
  subnet_id                   = "${module.my_vpc.public_subnets[0]}"
  vpc_security_group_ids      = ["${aws_security_group.bastion.id}"]

  tags {
    Name = "my_bastion"
    vpc  = true
  }
}

resource "aws_security_group" "bastion" {
  name = "${var.bastion_SG_name}"

  vpc_id = "${module.my_vpc.vpc_id}"

  tags {
    Name = "${var.bastion_SG_name}"
  }
}

resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = "${aws_security_group.bastion.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_all_traffic" {
  type              = "ingress"
  protocol          = "all"
  from_port         = 0
  to_port           = 65535
  security_group_id = "${aws_security_group.bastion.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion_allow_all_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  security_group_id = "${aws_security_group.bastion.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}
