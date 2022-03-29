/*          Create a Launch Configuration               */

resource "aws_launch_configuration" "my-lc"{
 
		name = "my-lc"
		image_id = "ami-0567e0d2b4b2169ae"
		instance_type = "t2.micro"
		security_groups =  [aws_security_group.elb-sg.id]
		key_name = "oct27"

}

/*             Create AutoScalingGroup                    */

resource "aws_autoscaling_group" "my-asg"{

		name = "my-asg"
		launch_configuration = aws_launch_configuration.my-lc.name
		vpc_zone_identifier = [aws_subnet.sn3.id,aws_subnet.sn4.id]
		load_balancers = [aws_elb.my-elb.id]
		
		desired_capacity = 3
		min_size = 2
		max_size = 5


}

/*          create a schedule policy and attach to ASG             */

resource "aws_autoscaling_schedule" "my-schedule"{
		
		autoscaling_group_name = aws_autoscaling_group.my-asg.name
		scheduled_action_name = "my-schedule"
		desired_capacity = 5
		min_size = 3
		max_size = 7
		start_time = "2021-11-24T06:45:00Z"
		end_time = "2021-12-11T00:00:00Z"

}