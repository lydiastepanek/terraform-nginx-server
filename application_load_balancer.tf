resource "aws_alb" "load_balancer" {
  name               = "load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.alb_sg.id}"]
  subnets            = ["${module.my_vpc.public_subnets}"]

  tags {
    Name = "load_balancer"
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "public access security group"
  vpc_id      = "${module.my_vpc.vpc_id}"

  tags {
    Name = "alb_sg"
  }
}

resource "aws_security_group_rule" "allow_all" {
  type              = "ingress"
  protocol          = "all"
  from_port         = 0
  to_port           = 65535
  security_group_id = "${aws_security_group.alb_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_alb_target_group" "target_group" {
  name     = "target-group"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = "${module.my_vpc.vpc_id}"

  depends_on = [
    "aws_alb.load_balancer",
  ]

  health_check {
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    interval            = "30"
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "5"
  }

  tags {
    Name = "target_group"
  }
}

resource "aws_lb_target_group_attachment" "target_group_attachment" {
  target_group_arn = "${aws_alb_target_group.target_group.arn}"
  target_id        = "${aws_instance.app_server.id}"
  port             = 80
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = "${aws_alb.load_balancer.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.target_group.arn}"
    type             = "forward"
  }
}
