provider "aws" {
  profile    = "jp"
  region     = "ap-northeast-1"
}

resource "aws_instance" "example" {
  ami           = "ami-059b6d3840b03d6dd"  
  instance_type = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.instance.id ]

  user_data = <<-EOF
                #!/bin/bash
                echo "hello world" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF

  tags = {
    "Name" = "terraform-example"
  }
}

resource "aws_security_group" "instance" {
    name = "terraform-example-instance"

    ingress {
      cidr_blocks = [ "0.0.0.0/0" ]
      description = "mono"
      from_port = var.server_port
      protocol = "TCP"
      to_port = var.server_port
    }      
}
