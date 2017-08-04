resource "aws_security_group" "myinstance-sg" {
  vpc_id = "${aws_vpc.main.id}"
  name = "myinstancesg"
  description = "security group for my instance"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      #cidr_blocks = ["0.0.0.0/0"]
      security_groups = ["${aws_security_group.bastion-sg.id}"]
  } 

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      security_groups = ["${aws_security_group.elb-sg.id}"]
  }

  tags {
    Name = "myinstancesg"
  }
}
resource "aws_security_group" "elb-sg" {
  vpc_id = "${aws_vpc.main.id}"
  name = "elbsg"
  description = "security group for load balancer"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 
  tags {
    Name = "elbsg"
  }
}

resource "aws_security_group" "bastion-sg" {
  vpc_id = "${aws_vpc.main.id}"
  name = "bastionsg"
  description = "security group for bastion"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "bastionsg"
  }
}

