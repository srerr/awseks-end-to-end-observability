resource "aws_security_group" "ssh_access" {
  name        = "allow_ssh"
  vpc_id = aws_vpc.vpc-demo.id
  description = "Allow SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow access from any IP (Modify for security)
  }
}

resource "aws_instance" "web" {
  ami                    = "ami-04b4f1a9cf54c11d0" # Replace with a valid Ubuntu AMI ID for your region
  instance_type          = "t2.micro"
  key_name               = "nodegroup_login" # Replace with your existing AWS key pair name
  vpc_security_group_ids = [aws_security_group.ssh_access.id]
  associate_public_ip_address = true
  subnet_id = aws_subnet.public-subnet2.id

  tags = {
    Name = "Ubuntu-EC2"
  }
}

output "instance_ip" {
  value = aws_instance.web.public_ip
}
 