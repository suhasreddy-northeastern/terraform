provider "aws" {
  region     = "us-east-1"  # Replace with your desired AWS region
  access_key = "your-access-key"  # Optional: Use IAM roles or environment variables for better security
  secret_key = "your-secret-key"  # Optional: Use IAM roles or environment variables for better security
}

resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "ExampleVPC"
  }
}

resource "aws_subnet" "example_subnet" {
  vpc_id     = aws_vpc.example_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "ExampleSubnet"
  }
}

resource "aws_security_group" "example_sg" {
  name   = "ExampleSecurityGroup"
  vpc_id = aws_vpc.example_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Replace with your desired IP range
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ExampleSecurityGroup"
  }
}

resource "aws_instance" "example_instance" {
  ami                    = "ami-0c94855ba95c71c99"  # Amazon Linux 2 AMI (update to the latest AMI ID for your region)
  instance_type         = "t2.micro"                # Adjust instance type as needed
  subnet_id             = aws_subnet.example_subnet.id
  vpc_security_group_ids = [aws_security_group.example_sg.id]
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 50  # Adjust volume size as needed
  }

  key_name = "example_key_pair"  # Replace with your existing key pair name

  tags = {
    Name = "ExampleInstance"
  }
}