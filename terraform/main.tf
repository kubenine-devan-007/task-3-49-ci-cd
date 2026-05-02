resource "aws_vpc" "task_3_49_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "task-3-49-vpc"
  }
}

resource "aws_subnet" "task_3_49_public_subnet" {
  vpc_id                  = aws_vpc.task_3_49_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "task-3-49-public-subnet"
  }
}

resource "aws_internet_gateway" "task_3_49_igw" {
  vpc_id = aws_vpc.task_3_49_vpc.id

  tags = {
    Name = "task-3-49-igw"
  }
}

resource "aws_route_table" "task_3_49_rt" {
  vpc_id = aws_vpc.task_3_49_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.task_3_49_igw.id
  }

  tags = {
    Name = "task-3-49-rt"
  }
}

resource "aws_route_table_association" "task_3_49_rta" {
  subnet_id      = aws_subnet.task_3_49_public_subnet.id
  route_table_id = aws_route_table.task_3_49_rt.id
}

resource "aws_security_group" "task_3_49_sg" {
  name        = "task-3-49-sg"
  description = "Allow Flask app access"
  vpc_id      = aws_vpc.task_3_49_vpc.id

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "task-3-49-sg"
  }
}


