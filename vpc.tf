provider "aws" {
  region = "ap-south-1"  # Adjust the region as needed
}

# Create the VPC with a Class A IP range
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"  # Class A IP range
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}

# Create a secondary CIDR block within the same Class A range
resource "aws_vpc_ipv4_cidr_block_association" "class_a_secondary_cidr" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.1.0.0/24"  # Secondary Class A IP range
}

# Create a public subnet within the Class A IP range
resource "aws_subnet" "public_subnet" {
  vpc_id              = aws_vpc.my_vpc.id
  cidr_block          = "10.0.0.0/24"  # Subnet within Class A IP range
  availability_zone   = "ap-south-1b"  # Adjust the availability zone as needed
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet"
  }
}

# Create a private subnet within the secondary Class A IP range
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.1.0.0/24"  # Subnet within the secondary Class A IP range
  availability_zone = "ap-south-1b"  # Adjust the availability zone as needed
  tags = {
    Name = "Private Subnet"
  }
}

# Create an Internet Gateway and attach it to the VPC
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "Internet Gateway"
  }
}

