resource aws_launch_configuration "my-lc2"{
		
			name = "my-lauch-configuration"
			image_id = "ami-0567e0d2b4b2169ae"
			instance_type = "t2.micro"
			
			user_data = "${file("./new 1.sh")}"
			security_groups = [aws_security_group.my-enlb-assig.id]
			key_name = "oct27"
}
resource aws_autoscaling_group "asg-assign"{
                count = 2
				name = "asg-assign-${count.index}"
				launch_configuration = aws_launch_configuration.my-lc2.name
				vpc_zone_identifier = [aws_subnet.sub-net.*.id[length(data.aws_availability_zones.az.names)]]
                target_group_arns = [aws_lb_target_group.tg.*.id[count.index]]
				desired_capacity   = var.desire
				max_size           = var.max
				min_size           = var.min
}