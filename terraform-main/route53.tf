resource "aws_route53_zone" "my-r53" {
  name = "abc.com"
  vpc {
    vpc_id = aws_vpc.vpc.id
  }
}

resource "aws_route53_record" "record-53" {
  zone_id = aws_route53_zone.my-r53.zone_id
  name =  "abc.com"
  type    = "A"
  
  
  alias {
   
			name = aws_elb.my-elb.dns_name
			zone_id = aws_elb.my-elb.zone_id
			evaluate_target_health = true
  
  }
}