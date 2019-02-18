resource "aws_instance" "app_server" {
  count                  = 1
  ami                    = "${var.app_server_ami}"
  instance_type          = "t2.2xlarge"
  key_name               = "${var.key_name}"
  subnet_id              = "${module.my_vpc.private_subnets[0]}"
  vpc_security_group_ids = ["${aws_security_group.app_server.id}"]

  tags {
    Name = "my_app_server"
    vpc  = true
  }

  lifecycle {
    ignore_changes = ["key_name"]
  }

  root_block_device {
    volume_size           = 30
    volume_type           = "gp2"
    delete_on_termination = true
  }
}

resource "aws_security_group" "app_server" {
  name = "${var.app_server_SG_name}"

  vpc_id = "${module.my_vpc.vpc_id}"

  tags {
    Name = "${var.app_server_SG_name}"
  }
}

# allow ssh coming from bastion to boxes in vpc
resource "aws_security_group_rule" "allow_ssh_from_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.app_server.id}"
  source_security_group_id = "${aws_security_group.bastion.id}"
}

resource "aws_security_group_rule" "allow_all_from_alb" {
  type                     = "ingress"
  protocol                 = "all"
  from_port                = 0
  to_port                  = 65535
  security_group_id        = "${aws_security_group.app_server.id}"
  source_security_group_id = "${aws_security_group.public_sg.id}"
}

resource "aws_security_group_rule" "app_server_allow_all_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  security_group_id = "${aws_security_group.app_server.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}
