resource "aws_eip" "runner_eip" {
  instance = aws_instance.runner-server.id

  tags = {
    Name = "Release-Notes-Publisher-Core"
  }
}

resource "aws_eip" "runner2_eip" {
  instance = aws_instance.second-server.id

  tags = {
    Name = "Release-Notes-Publisher-Web"
  }
}