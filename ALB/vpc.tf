
data "aws_availability_zones" "az" {
}



resource "aws_vpc" "my-vpc"{
    cidr_block = var.vpc-var
    tags = {

            Name = "my-vpc"
        }
}

resource "aws_subnet" "sub-net"{
        count = length(data.aws_availability_zones.az.names)*2

        vpc_id = aws_vpc.my-vpc.id
        availability_zone = element(data.aws_availability_zones.az.names,count.index)
        cidr_block = cidrsubnet(var.vpc-var,8,count.index)

        
}







resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.my-vpc.id

    tags = {
        Name = "my-igw"
    }
}

resource "aws_eip" "eip"{

}

resource "aws_nat_gateway" "nat"{
    allocation_id = aws_eip.eip.id
    subnet_id = aws_subnet.sub-net.*.id[0]

    tags = {
        Name = "my-nat"
    }
}




resource "aws_route_table" "rt1"{
    vpc_id = aws_vpc.my-vpc.id

    route{
        gateway_id = aws_internet_gateway.igw.id
        cidr_block = "0.0.0.0/0"
    }

    tags = {
        Name = "Pub-rt"
    }
} 

resource "aws_route_table" "rt2"{
    
    vpc_id = aws_vpc.my-vpc.id

    route{
        gateway_id = aws_nat_gateway.nat.id
        cidr_block = "0.0.0.0/0"
    }

    tags = {
        Name = "prv-rt"
    }
} 



 
  


resource "aws_route_table_association" "rt-sub"{
    count = length(data.aws_availability_zones.az.names)
    route_table_id = aws_route_table.rt1.id
    subnet_id = aws_subnet.sub-net.*.id[count.index]

}
resource "aws_route_table_association" "rt-sub1"{
    count = length(data.aws_availability_zones.az.names)
    route_table_id = aws_route_table.rt2.*.id[0]
    subnet_id = aws_subnet.sub-net.*.id[count.index+length(data.aws_availability_zones.az.names)]

}

