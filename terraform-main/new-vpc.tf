resource aws_vpc "vpc-3"{
		
		cidr_block = "10.0.0.0/24"
		tags = {
		Name = "vpc-3"}
}

resource aws_internet_gateway "igw-3"{
		vpc_id = aws_vpc.vpc-3.id

}

resource aws_security_group "my-sg3"{
		name = "my-sg3"
		vpc_id = aws_vpc.vpc-3.id
		
		ingress{
		
				from_port = 22
				to_port = 30
				protocol = "tcp"
				cidr_blocks = ["0.0.0.0/0"]				
		
		}
		ingress{
		
				from_port = 80
				to_port = 80
				protocol = "tcp"
				cidr_blocks = ["23.90.90.90/32","45.90.78.90/32"]				
		
		}
		
		
		
}

output "pract" {

		value = aws_vpc.vpc-3.id
		
		
}
output "pract1" {

		value = aws_security_group.my-sg3.id
				
}
output "pract2"{
		value = aws_route_table.rt1.id
}

		