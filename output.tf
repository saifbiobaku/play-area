# Output public ip address for agent-n

output "agent-public-ip" {
  value = {
    for instance in aws_instance.PAC-7-instance :
    instance.id => instance.public_ip
  }
}