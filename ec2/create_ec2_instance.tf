provider "aws" {
  profile    = "default"
  region     = "ap-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0e5c29e6c87a9644f"
  instance_type = "t3.medium"
}
