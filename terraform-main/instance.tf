resource "aws_instance" "ins-1"{
		
		ami = "ami-0567e0d2b4b2169ae"
		associate_public_ip_address = true
		subnet_id = aws_subnet.sn1.id
		instance_type = "t2.micro"
		key_name = "oct27"
		vpc_security_group_ids  = [aws_security_group.my-sg.id]
		
		tags={
		Name = "ins-1"}
}	


resource "aws_instance" "ins-2"{
		
		ami = "ami-0567e0d2b4b2169ae"
		associate_public_ip_address = true
		subnet_id = aws_subnet.sn2.id
		instance_type = "t2.micro"
		key_name = "oct27"
		vpc_security_group_ids  = [aws_security_group.my-sg.id]
		
		tags={
		Name = "ins-2"}
}	