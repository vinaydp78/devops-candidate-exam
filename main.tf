

resource “aws_subnet” “prod-subnet-public-1” {
    vpc_id = "vpc-0de2bfe0f5fc540e0"
    cidr_block = “10.0.1.0/24”
    map_public_ip_on_launch = “true” //it makes this a public subnet
    availability_zone = “eu-west-2a”
    tags {
        Name = “prod-subnet-public-1”
    }
}

resource "aws_route_table" "prod-public-crt" {
    vpc_id = "vpc-0de2bfe0f5fc540e0"
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "10.0.1.0/24" 
        //CRT uses this IGW to reach internet
        gateway_id = "nat-07863fc48f5b99110" 
    }
    
    tags {
        Name = "prod-public-crt"
    }
}

resource "aws_security_group" "example" {
  name_prefix = "example-sg"
  vpc_id = vpc-0de2bfe0f5fc540e0
 
  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }
 
  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }
}


resource "aws_iam_role" "example" {
  name = "example-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}
 
resource "aws_iam_policy" "example" {
  name        = "example-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Resource = ["arn:aws:logs:*:*:*"]
    },{
      Effect = "Allow"
      Action = [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface"
      ]
      Resource = ["*"]
    }]
  })
}
 
resource "aws_iam_role_policy_attachment" "example" {
  policy_arn = aws_iam_policy.example.arn
  role = aws_iam_role.example.name
}

resource "aws_lambda_function" "example" {
  function_name    = "example-lambda"
  filename         = "api_vinay.py"
  source_code_hash = filebase64sha256("lambda_function_payload.zip")
  handler          = "index.handler"
  role             = aws_iam_role.example.arn
  runtime          = "nodejs14.x"
  vpc_config {
    subnet_ids = [aws_subnet.example.id]
    security_group_ids = [aws_security_group.example.id]
  }
}