resource "aws_elb" "my-elb" {
 
		name = "my-elb"
		subnets = [aws_subnet.sn1.id,aws_subnet.sn2.id]
		
		security_groups = [aws_security_group.elb-sg.id]
		
		
		listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
		
		health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.html"
    interval            = 10 
}
}

/*     attach instance to elb          */

resource "aws_elb_attachment" "elb-attachment" {
  elb      = aws_elb.my-elb.id
  instance = aws_instance.ins-2.id
}

resource "aws_elb_attachment" "elb-attachment1" {
  elb      = aws_elb.my-elb.id
  instance = aws_instance.ins-1.id
}