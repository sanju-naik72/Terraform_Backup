variable "vpc-var"{
    default = "10.0.0.0/16"
    
}

variable "tag" {
    default = "web"
}

output "sub-id" {
    value = aws_subnet.sub-net.*.id
}

variable "sub" {
  sub-id = aws_subnet.sub-net.*.id
}
