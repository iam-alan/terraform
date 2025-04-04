provider "aws" {
  region = "ap-south-1"  # Change this to the desired region
}

resource "aws_security_group" "example_sg" {
  name        = "security-for-nothing"
  description = "Example security group for Terraform"

  // Inbound rules
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP access from anywhere
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/24"]  # Replace with your trusted IP range for SSH access
  }

  // Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "example_instance" {
  ami           = "ami-002f6e91abff6eb96"  # Replace with a valid AMI ID in your region
  instance_type = "t2.micro"  # You can change this to your desired instance type
  vpc_security_group_ids = ["sg-07792524e77559fb3"]
  key_name      = "enthino"  # Replace with your existing key pair name

tags= {
  Name= "Mygroup"
 }
}
