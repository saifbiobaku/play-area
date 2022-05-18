# Create a security group for all
resource "aws_security_group" "PAC-7-SG" {
  provider    = aws.region-us-east-1
  vpc_id      = aws_vpc.PAC-7.id
  name        = "PAC7-sg-1"
  description = "Security group allows https and ssh traffic"
  ingress {
    cidr_blocks = [var.external_ip]
    description = "Allow ssh"
    from_port   = 22
    #prefix_list_ids  = ["value"]
    protocol = "tcp"
    #security_groups  = ["value"]
    #self             = false
    to_port = 22
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow http"
    from_port   = 80
    #prefix_list_ids  = ["value"]
    protocol = "tcp"
    #security_groups  = ["value"]
    self    = false
    to_port = 80
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS"
    from_port   = 443
    #prefix_list_ids  = ["value"]
    protocol = "tcp"
    #security_groups  = ["value"]
    #self             = false
    to_port = 443
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all"
    from_port   = 0
    #prefix_list_ids  = ["value"]
    protocol = "-1"
    #security_groups  = ["value"]
    self    = false
    to_port = 0
  }
  tags = {
    "Name" = "PAC-7-SG"
  }
}
