terraform{
  required_providers {
    aws ={
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
    
  region = "us-east-1"
  profile = "default"
  shared_credentials_files = ["~/.aws/credentials" ]

}

resource "aws_instance" "ubuntu-inst" {
    ami = "ami-01d08089481510ba2"
    instance_type = "t2.micro"
    vpc_security_group_ids = [ aws_security_group.sg.id ]
    key_name = "key"
    user_data = "${file("apache.sh")}"
}
resource "aws_default_vpc" "default_vpc" {
  
}
resource "aws_security_group" "sg" {
  name = "sc-grp"
 vpc_id = aws_default_vpc.default_vpc.id

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress{
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]

  }
  
  egress  { 
    from_port = 0
    to_port = 0 
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "ssh-key" {
  key_name = "key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC42c570PjbOWV20Pp3YXCqyom0zh1XueFMxEpT++M3bzHb9YA5glo0RK7ID7Qcgp6vEBxLyTg5QsQzSWy5A5DcX4e+Vhnst/88HVefCKGJaZMrxZbXikF7nPVd6BpUHB1UgZxBWCGt/z/tekqYJ6ehNWnXqYdAHj7fORD8Qoh8vDr/7rkves7L1diDpSW2Dvfqi2+MLJzyBgJfQEGRj0aznfFi8ptxr5ibM3R6VucI22e6HJdbPAq8jrCarQYmOnVDJBsmIJV84cUj+CDmovyWQS5xbWbCyAMmZu+WCh+Q2pmvja4x+x4S4Oxdc6qHU6vm+MTC65M14Fn/9aA6NTEPRthtJm8Il7T9a2onT8Fn69R+hN98dNeAw31Bm3Zi41BaetuqeSa1izEa/hSxtyPL3Fl59x9eaSzt0WW2FOcmAAHi4Ecf91O//6bHWl/Cf1gJx01lCn7ayhZ41VSaLdOEDuKmiIo8NOgB7huxXAo1nQs23SqCdGlMdbjtIh4FuiU= sofiia@sofiia-VirtualBox"
}