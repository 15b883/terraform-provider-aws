provider "aws" {
    profile = "jp"
    region  = "ap-northeast-1"
}

resource "aws_instance" "example" {
    ami           = "ami-0bc8ae3ec8e338cbc"
    instance_type = "t2.micro"

    tags = {
        Name = "example"
    }
} 
