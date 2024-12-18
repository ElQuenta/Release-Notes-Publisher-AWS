resource "aws_key_pair" "runner-server-ssh" {
  key_name   = "runner-server-ssh"
  public_key = file("runner-server.key.pub")
}

resource "aws_security_group" "runner-server-sg" {
  name        = "Release-Notes_Publisher-sg"
  description = "Security group for runner EC2 instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 4000
    to_port     = 4000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
