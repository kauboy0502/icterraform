resource "random_shuffle" "subnets" {
    input = var.subnetpublic
    result_count = 1
  
}

resource "tls_private_key" "ec2key" {
    algorithm = "RSA"
    rsa_bits = 4096
}
resource "local_file" "ec2pemkey" {
    filename = "ec2-key.pem"
    content = tls_private_key.ec2key.private_key_pem
}
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = tls_private_key.ec2key.public_key_openssh
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = random_shuffle.subnets.result[0]
  associate_public_ip_address = true
  key_name = aws_key_pair.deployer.id
  vpc_security_group_ids = [var.sgs]
  


  tags = {
    Name = "HelloWorld"
  }
}