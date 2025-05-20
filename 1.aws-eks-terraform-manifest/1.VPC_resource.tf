provider "aws" {
    region = "us-east-1"
    profile = "default"
}
resource "aws_vpc" "vpc-demo" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    instance_tenancy = "default"
    tags = {
        Name = "vpc-demo"
    }
}
resource "aws_internet_gateway" "demo-igw" {
    #vpc_id = aws_vpc.vpc-demo.id
    vpc_id = aws_vpc.vpc-demo.id
    tags = {
        Name = "demo-igw"
    }
}
resource "aws_eip" "demo-eip" {
    vpc = true
    tags = {
        Name = "demo-eip"
    }
}
resource "aws_nat_gateway" "demo-ngw" {
    allocation_id = aws_eip.demo-eip.id
    subnet_id = aws_subnet.public-subnet1.id
    tags = {
        Name = "demo-ngw"
    }
    depends_on = [ aws_internet_gateway.demo-igw ]
}
resource "aws_subnet" "public-subnet1" {
    vpc_id = aws_vpc.vpc-demo.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "public-subnet1"
    }
}
resource "aws_subnet" "public-subnet2" {
    vpc_id = aws_vpc.vpc-demo.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
    tags = {
        Name = "public-subnet2"
    }
}
resource "aws_subnet" "private-subnet1" {
    vpc_id = aws_vpc.vpc-demo.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "private-subnet1"
    }
}

resource "aws_subnet" "private-subnet2" {
    vpc_id = aws_vpc.vpc-demo.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "us-east-1b"
    tags = {
        Name = "private-subnet2"
    }
}

resource "aws_route_table" "public-route-table1" {
    vpc_id = aws_vpc.vpc-demo.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.demo-igw.id
        }
    tags = {
        Name = "public-route-table1"
    }
}
resource "aws_route_table" "public-route-table2" {
    vpc_id = aws_vpc.vpc-demo.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.demo-igw.id
        }
    tags = {
        Name = "public-route-table2"
    }
}
resource "aws_route_table_association" "rt_association1" {
    subnet_id = aws_subnet.public-subnet1.id
    route_table_id = aws_route_table.public-route-table1.id
}
resource "aws_route_table_association" "rt_association2" {
    subnet_id = aws_subnet.public-subnet2.id
    route_table_id = aws_route_table.public-route-table2.id
}

resource "aws_route_table" "private-route-table1" {
    vpc_id = aws_vpc.vpc-demo.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.demo-ngw.id
    }
    tags = {
        Name = "private-route-table1"
    }
    }
resource "aws_route_table" "private-route-table2" {
    vpc_id = aws_vpc.vpc-demo.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.demo-ngw.id
        }
    
    tags = {
        Name = "private-route-table2"
    }
}
resource "aws_route_table_association" "rt_association3" {
    subnet_id = aws_subnet.private-subnet1.id
    route_table_id = aws_route_table.private-route-table1.id
}
resource "aws_route_table_association" "rt_association4" {
    subnet_id = aws_subnet.private-subnet2.id
    route_table_id = aws_route_table.private-route-table2.id
}