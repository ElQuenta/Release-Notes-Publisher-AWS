resource "aws_eip" "runner_eip" {
  instance = aws_instance.runner-server.id

  tags = {
    Name = "Runner-ElasticIP"
  }
}

resource "aws_eip" "runner2_eip" {
  instance = aws_instance.second-server.id

  tags = {
    Name = "Runner-ElasticIP"
  }
}