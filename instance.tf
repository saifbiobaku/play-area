# Create a Key pair for logging into all the instances in us-east-1
resource "aws_key_pair" "PAC-7-keyPair" {
  provider   = aws.region-us-east-1
  key_name   = "pac-7-key-pair"
  public_key = file("aws_authorized_keys.pub")
}
# Create and bootstrap all the EC2 instances in us-east-1
resource "aws_instance" "PAC-7-instance" {
  provider                    = aws.region-us-east-1
  count                       = var.instance_count
  ami                         = "ami-0c02fb55956c7d316"
  instance_type               = var.instance-type
  vpc_security_group_ids      = [aws_security_group.PAC-7-SG.id]
  key_name                    = aws_key_pair.PAC-7-keyPair.id
  subnet_id                   = aws_subnet.PAC-7-subnet.id
  associate_public_ip_address = true
  tags = {
    "Name" = "PAC-7-${count.index + 1}"
  }
  depends_on = [
    aws_main_route_table_association.route_vpc
  ]
  provisioner "local-exec" {
    command = <<EOF
    aws --profile ${var.profile} ec2 wait instance-status-ok --region ${var.aws_region} --instance-ids ${self.id} 
    ansible-playbook --extra-vars 'passed_in_hosts=${self.public_ip}' ansible_templates/initial-installation.yml
    EOF
  }

}