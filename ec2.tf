resource "aws_instance" "runner-server" {
  ami           = "ami-0453ec754f44f9a4a"  # AMI de Amazon Linux
  instance_type = "t2.micro"

  tags = {
    Name        = "Release-Notes-Publisher-Core"
    Environment = "dev"
    Project     = "pipeline"
  }

  user_data = <<-EOF
              #!/bin/bash
              # Instalar Docker
              sudo yum update -y
              sudo amazon-linux-extras enable docker
              sudo yum install -y docker
              sudo systemctl enable docker
              sudo systemctl start docker

              # Añadir al usuario ec2-user al grupo docker
              sudo usermod -aG docker ec2-user

              # Instalar herramientas adicionales si es necesario
              sudo yum install -y git

              # Configurar GitHub Actions Runner
              mkdir actions-runner && cd actions-runner
              curl -o actions-runner-linux-x64-2.321.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.321.0/actions-runner-linux-x64-2.321.0.tar.gz
              echo "ba46ba7ce3a4d7236b16fbe44419fb453bc08f866b24f04d549ec89f1722a29e  actions-runner-linux-x64-2.321.0.tar.gz" | shasum -a 256 -c
              tar xzf ./actions-runner-linux-x64-2.321.0.tar.gz

              # Configuración del runner
              ./config.sh --url https://github.com/EIQuenta/Release-Notes-Publisher-core --token ${var.NRP_core_token}
              ./run.sh &
              EOF

  user_data_replace_on_change = true
  key_name                    = aws_key_pair.runner-server-ssh.key_name
  vpc_security_group_ids      = [aws_security_group.runner-server-sg.id]
}

resource "aws_instance" "second-server" {
  ami           = "ami-0453ec754f44f9a4a"  # AMI de Amazon Linux
  instance_type = "t2.micro"

  tags = {
    Name        = "Terraform-Second-Server"
    Environment = "dev"
    Owner       = "angeloquenta@gmail.com"
    Team        = "DevOps"
    Project     = "pipeline"
  }

  user_data = <<-EOF
              #!/bin/bash
              # Instalar Docker
              sudo yum update -y
              sudo amazon-linux-extras enable docker
              sudo yum install -y docker
              sudo systemctl enable docker
              sudo systemctl start docker

              # Añadir al usuario ec2-user al grupo docker
              sudo usermod -aG docker ec2-user

              # Instalar herramientas adicionales si es necesario
              sudo yum install -y git
              
              # Configurar GitHub Actions Runner
              mkdir actions-runner && cd actions-runner
              curl -o actions-runner-linux-x64-2.321.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.321.0/actions-runner-linux-x64-2.321.0.tar.gz
              echo "ba46ba7ce3a4d7236b16fbe44419fb453bc08f866b24f04d549ec89f1722a29e  actions-runner-linux-x64-2.321.0.tar.gz" | shasum -a 256 -c
              tar xzf ./actions-runner-linux-x64-2.321.0.tar.gz

              # Configuración del runner
              ./config.sh --url https://github.com/ElQuenta/Release-Notes-Publisher-web --token ${var.NRP_web_token}
              ./run.sh &
              EOF

  user_data_replace_on_change = true
  key_name                    = aws_key_pair.runner-server-ssh.key_name
  vpc_security_group_ids      = [aws_security_group.runner-server-sg.id]
}