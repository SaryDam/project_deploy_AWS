provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "instance" {
  ami                    = "ami-04b70fa74e45c3917"
  instance_type          = "t2.micro"
  key_name               = "myKey"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id, aws_security_group.allow_web.id]

  tags = {
    Name = "HTTP",
    tags = "ubuntu"
  }
}

resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_web" {
  name = "allow_web"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
