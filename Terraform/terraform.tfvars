region              = "us-west-1"

vpc_cidr            = "10.0.0.0/16"
public_subnet_cidr  = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"
az                  = "us-west-1c"

my_ip               = "203.0.113.5/32"  # Replace with your actual public IP

ami_id              = "ami-0f8e81a3da6e2510a"  # Ubuntu 20.04 LTS in us-east-1
instance_type       = "t2.micro"
key_name            = "Reshma-keypair"     # Replace with your EC2 key name
