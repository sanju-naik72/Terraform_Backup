resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags={"Name"="my-vpc"}
}








/* create a subnets in vpc */

resource "aws_subnet" "sn1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone ="ap-south-1b"
  tags = {
    Name = "SN1.pub"
  }
}
resource "aws_subnet" "sn2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone ="ap-south-1a"

  tags = {
    Name = "SN2.pub"
  }
}
resource "aws_subnet" "sn3" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone ="ap-south-1b"

  tags = {
    Name = "SN3"
  }
}
resource "aws_subnet" "sn4" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone ="ap-south-1a"

  tags = {
    Name = "SN4"
  }
}






/*     Internet Gateway & NAT Gateway         */

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw"
  }
}


resource "aws_nat_gateway" "mynat" {
	allocation_id = aws_eip.myeip.allocation_id
	subnet_id = aws_subnet.sn1.id
	tags={
	Name = "my-nat"
	}
}









/*     elasticIP       */
resource "aws_eip" "myeip" {
 
}








/* Create route tables */

resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.vpc.id
  tags ={Name = "route.pub"}
  
   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  
}


resource "aws_route_table" "rt2" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.mynat.id
  }

}




/*     route table association     */

resource "aws_route_table_association" "rtassociation" {
  subnet_id      = aws_subnet.sn1.id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_route_table_association" "rtassociation1" {
  subnet_id      = aws_subnet.sn2.id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_route_table_association" "rtassociation2" {
  subnet_id      = aws_subnet.sn3.id
  route_table_id = aws_route_table.rt2.id
}
resource "aws_route_table_association" "rtassociation3" {
  subnet_id      = aws_subnet.sn4.id
  route_table_id = aws_route_table.rt2.id
}