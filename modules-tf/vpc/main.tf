resource "aws_vpc" "icvpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    name = "mainvpc"
  }
}

resource "aws_internet_gateway" "icigw" {
  vpc_id = aws_vpc.icvpc.id

  tags = {
    name = "mainigw"
  }
}

resource "aws_subnet" "subnet_pub" {
  count = length(var.pubsubnet)
  vpc_id     = aws_vpc.icvpc.id
  cidr_block = element(var.pubsubnet,count.index)
  availability_zone = element(var.azones,count.index)

  tags = {
    name = "subnet-public"
  }
}


resource "aws_subnet" "subnet_pri" {
  count = length(var.prisubnet)
  vpc_id     = aws_vpc.icvpc.id
  cidr_block = element(var.prisubnet,count.index)
  availability_zone = element(var.azones,count.index)

  tags = {
    name = "subnet-private"
  }
}

resource "aws_route_table" "rtpub" {
  vpc_id = aws_vpc.icvpc.id

  tags = {
    name = "icrtpub"
  }
}

resource "aws_route" "pubroute" {
  route_table_id            = aws_route_table.rtpub.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.icigw.id
  depends_on                = [aws_route_table.rtpub]
}

resource "aws_route_table_association" "pubsubassoc" {
  count = length(var.pubsubnet)
  subnet_id      = element(aws_subnet.subnet_pub.*.id,count.index)
  route_table_id = aws_route_table.rtpub.id
}

resource "aws_eip" "iceip" {
  vpc = true
  depends_on = [
    aws_internet_gateway.icigw
  ]

}

resource "aws_nat_gateway" "icnat" {
  allocation_id = aws_eip.iceip.id
  subnet_id     = element(aws_subnet.subnet_pub.*.id,0)
  depends_on = [
    aws_internet_gateway.icigw
  ]
  
}



resource "aws_route_table" "rtpri" {
  vpc_id = aws_vpc.icvpc.id

  tags = {
    name = "icrtpri"
  }
}

resource "aws_route" "priroute" {
    route_table_id = aws_route_table.rtpri.id
    nat_gateway_id = aws_nat_gateway.icnat.id
    destination_cidr_block = "0.0.0.0/0"
  
}

resource "aws_route_table_association" "prisubassoc" {
  count = length(var.prisubnet)
  subnet_id      = element(aws_subnet.subnet_pri.*.id,count.index)
  route_table_id = aws_route_table.rtpri.id
}

resource "aws_security_group" "default" {
  name        = "vpc-default-sg"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = aws_vpc.icvpc.id
  depends_on  = [aws_vpc.icvpc]
  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
    
  }
  
  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
    
  }

}