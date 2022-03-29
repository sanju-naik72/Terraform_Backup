resource "aws_security_group" "my-sg"{
	vpc_id = aws_vpc.vpc.id
	
	
	ingress{
				from_port = 22
				to_port = 22
				protocol = "tcp"
				cidr_blocks = ["0.0.0.0/0"]
	
	}
	
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
	
	tags = {
	Name = "my-sg"
	}
}

/*         SECURITY GROUP FOR ELB           */



resource "aws_security_group" "elb-sg"{
	vpc_id = aws_vpc.vpc.id
	
	
	
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
	
	tags = {
	Name = "ELB-SG"
	}
}