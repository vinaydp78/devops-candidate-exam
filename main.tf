provider "aws" {
  region = "eu-west-1"  # replace with the region you want to use
}


# Create private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = "vpc-0de2bfe0f5fc540e0"
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a" # replace with the AZ you want to use
}

# Create routing table
resource "aws_route_table" "private_route_table" {
  vpc_id = "vpc-0de2bfe0f5fc540e0"

  route {
    cidr_block = "0.0.0.0/0"
    # Replace with the ID of the NAT Gateway that you want to use
    # to allow traffic to reach the internet
    nat_gateway_id = "nat-07863fc48f5b99110"
  }

  tags = {
    Name = "Private Route Table"
  }
}

# Create Lambda function
resource "aws_lambda_function" "my_lambda_function_1" {
  function_name = "my-lambda-function"
  handler = "index.handler"
  runtime = "nodejs14.x"
  role = "arn:aws:iam::007974164823:role/DevOps-Candidate-Lambda-Role"
  # replace with your lambda function code
  filename = "api_vinay.zip"

  vpc_config {
    security_group_ids = [aws_security_group.my_security_group.id]
    subnet_ids         = [aws_subnet.private_subnet.id]
  }
}

# Create security group
resource "aws_security_group" "my_security_group" {
  name_prefix = "my-security-group"
  description = "Security group for my Lambda function"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-security-group"
  }
}

# Attach security group to Lambda function
#resource "aws_lambda_function" "my_lambda_function_1" {
#  security_group_ids = [aws_security_group.my_security_group.id]
#}


