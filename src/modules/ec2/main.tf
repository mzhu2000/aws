data "aws_ami" "amzn2_linux" {
  #executable_users = ["self"]
  most_recent      = true
  #name_regex       = "^amzn2-ami-hvm-2.0-\\d{8}.\\d{1}"
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-arm64-gp2"]
  }

  filter {
    name   = "is-public"
    values = ["true"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

/* data "aws_subnet_ids" "private" {
  vpc_id = var.vpc_id

  tags = {
    Tier = "private"
  }
} */

data "aws_subnets" "private" {
  filter {
    name = "vpc-id"
    values = [var.vpc_id]
  }

  filter {
    name   = "tag:Name"
    values = ["mzhu2000 Private Subnet"]
  }
/*
  tags = {
    Tier = "mzhu2000 Private Subnet"
  } */
} 

/* Key
Value
Name	Private-subnet-p-subnet-1 */

resource random_id index {
  keepers = {
    force = uuid()
  }
  byte_length = 2
}

locals {
  //  We need to convert the subnet ids from a set to list
  subnet_ids_list         = tolist(data.aws_subnets.private.ids)
  //  Using random_id and modulo you can a random index into the subnet_ids list
  subnet_ids_random_index = random_id.index.dec % length(data.aws_subnets.private.ids)
  instance_subnet_id      = local.subnet_ids_list[local.subnet_ids_random_index]
}

resource "aws_instance" "ec2" {
  count                       = var.ec2_should_be_created ? 1 : 0

  #ami                         = var.ec2_ami
  ami                         = data.aws_ami.amzn2_linux.id
  instance_type               = var.ec2_instance_type

  #subnet_id                   = var.public_subnet_id
  subnet_id                   = local.instance_subnet_id
  vpc_security_group_ids      = [aws_security_group.ec2_security_group.id]
  associate_public_ip_address = true

  key_name                    = aws_key_pair.ec2_key_pair.key_name

  user_data = <<EOF
  #! /bin/bash
  sudo yum update
  sudo amazon-linux-extras install -y
  sudo yum install -y httpd mysql logrotate nc busybox
  sudo amazon-linux-extras install -y python3.8
  pip3 install --upgrade --user awscli
  sudo systemctl start httpd
  sudo systemctl is-enabled httpd || sudo systemctl enable httpd
  echo "<h1>Deployed EC2 With Terraform</h1>" | sudo tee /var/www/html/index.html
  EOF

  user_data_replace_on_change = true

  tags = {
    Name = var.ec2_name
  }
}

resource "aws_security_group" "ec2_security_group" {
  name        = var.ec2_security_group_name
  description = var.ec2_security_group_description

  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.2.0/24", "10.0.3.0/24", "0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
/*
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } */

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.ec2_security_group_name
  }
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = var.ec2_ssh_key_name
  public_key = file(var.ec2_ssh_public_key_path)
}
