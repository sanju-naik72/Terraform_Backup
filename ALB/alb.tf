resource "aws_lb_target_group" "tg" {
    count = 2
  name = "target-${count.index}"
  port = var.port
  protocol = var.protocol
  vpc_id = aws_vpc.my-vpc.id
  health_check {
     interval            = var.interval
     port                = var.port
     protocol            = var.protocol
     healthy_threshold   = var.healthy_threshold
     unhealthy_threshold = var.unhealthy_threshold
   }
}

resource aws_security_group "my-enlb-assig"{
		
		vpc_id = aws_vpc.my-vpc.id
		name = "my-elb-assign"
		tags = {
		Name = "my-elb-asg-assign"}
		
		
		ingress{
					
					from_port = 80
					to_port = 80
					protocol = "tcp"
					cidr_blocks = ["0.0.0.0/0"]
		
		}
		
		egress{
					
					from_port = 0
					to_port = 0
					protocol = "-1"
					cidr_blocks = ["0.0.0.0/0"]
		}

}

resource "aws_lb" "my-alb" {
  name = "app-LB"
  security_groups = [aws_security_group.my-enlb-assig.id]
  subnets = slice(var.sub,0,length(data.aws_availability_zones.az.names))
}

resource "aws_lb_listener" "listener-LB" {
  port = 80
  protocol = "HTTP"
  load_balancer_arn = aws_lb.my-alb.arn

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.*.arn[0]
  }
}


resource "aws_lb_listener_rule" "alb-rule" {
  listener_arn = aws_lb_listener.listener-LB.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.*.arn[1]
  }

  condition {
    path_pattern {
      values = ["/sanju/*"]
    }
  }


}
resource "aws_lb_listener_rule" "alb-rule-1" {
  listener_arn = aws_lb_listener.listener-LB.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.*.arn[0]
  }

  condition {
    path_pattern {
      values = ["/swathi/*"]
    }
  }

}

resource "aws_lb_listener_rule" "alb-rule-2" {
  listener_arn = aws_lb_listener.listener-LB.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.*.arn[1]
  }

  condition {
    path_pattern {
      values = ["/aws/*"]
    }
  }

}