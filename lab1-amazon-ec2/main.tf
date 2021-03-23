provider "aws" {
  profile    = "jp"
  region     = "ap-northeast-1"
}

resource "aws_key_pair" "example-key" {
	key_name   = "example-key"
	public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC6iEfAf/xITItlSJqBNnCaw1BI+yqRPgnDSWUuGWoQJIukWmxinizySPC7ful2H+XyEbCHzkd5nPZobJwlCiF1oKEI2cFNB5ke02R//iGL1svPYj1hSKkrQECdiK2UgzBI9XI3a5ZhkNPj0BYQVOrnx3Jy/98LdP43zRS/mOADyvlGbmg8EI+Wb1TfzgRAl+z0GBPE7xMw9dGY+WlyuuLYS2NrYVPQ8FyHjcBYgB8Gd6KepntkwS/FMpF1ok66mo8G1hh9rwjTyP7AMlsiz1vxN8/PMZDwoN0tL8uuEktRA12m+x2Xp1ln4quEBwLlH5jgtUNNsSeuk3abYYqSHwti1fZv86Wf1XbbIaaJUU5tgjyqQ0ZjPY02p/7pqcZ5uI2Druyv2nX9079uYjhjZOMT+fjBQtLcglVt4gcGIak7sZwuo1nLLszZ1k8H6wTfCUTcSGMxEYzyCh4rDpTfF77PIhK47N33lwL4aH4YEdbc/hlakeF96oybsZ4OMgyclbhYoVq8s24vLWd0vUUmOemDiUm81VkzWfZHkRdFbjR6ngxlkYvacM4OCi5uSaGdztBuO+exsdCAbyB5yrX/DWeZVDUoG7fv99e/wUK6A7se8oJnhzfMYaubu0sCZLOP1xDXhbn7/M8124aacZVcs2+T/sm6jk2Kdq42jaEBqShD5w== root@localhost.localdomain"
}

resource "aws_instance" "example" {
  ami                = "ami-0bc8ae3ec8e338cbc"  
  key_name           = "example-key"
  instance_type      = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.example.id ]


  tags = {
    "Name" = "terraform-example"
  }
}


resource "aws_eip" "eip_example" {
  instance = aws_instance.example.id
  vpc  =  true

  tags = {
    "Name" = "example_eip"
  }
}

resource "aws_security_group" "example" {
  # ICMP
  ingress {
		from_port   = -1
		to_port     = -1
		protocol    = "icmp"
		cidr_blocks = ["0.0.0.0/0"]
		description = "icmp"
	}

  
  # Inbound internet access
  ingress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
		description = "inbound"
	}
	  
	# Outbound internet access
	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
    description = "outbound"
	}
	
	tags = {
		Name = "example_sg"
	}
  
}
