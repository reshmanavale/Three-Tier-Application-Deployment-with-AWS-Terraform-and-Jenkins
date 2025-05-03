resource "aws_instance" "web" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.web_sg_id]
  associate_public_ip_address = true
  key_name                    = var.key_name
  tags = {
    Name = "travelmemory-web"
  }
}

resource "aws_instance" "db" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.db_sg_id]
  key_name               = var.key_name
  tags = {
    Name = "travelmemory-db"
  }
}
