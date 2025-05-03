output "web_server_ip" {
  description = "Public IP of the web server EC2 instance"
  value       = module.ec2.web_public_ip
}
