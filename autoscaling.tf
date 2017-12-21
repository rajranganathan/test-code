resource "aws_launch_configuration" "jenkins-lcfg" {
  name_prefix          = "jenkins-lcfg"
  image_id             = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type        = "t2.micro"
  key_name             = "${aws_key_pair.keypair.key_name}"
  security_groups      = ["${aws_security_group.jenkins-instance-sg.id}"]
  user_data            = "#!/bin/bash\nyum -y install nginx\nsystemctl start nginx\nmkdir -p /var/www/html/\nMYIP=`ifconfig | grep 'addr:10' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'this is: '$MYIP > /var/www/html/index.html\nsystemctl reload nginx"
  lifecycle              { create_before_destroy = true }
}

resource "aws_autoscaling_group" "jenkins-asg" {
  name                 = "jenkins-asg"
  vpc_zone_identifier  = ["${aws_subnet.main-private-1.id}", "${aws_subnet.main-private-2.id}"]
  launch_configuration = "${aws_launch_configuration.jenkins-lcfg.name}"
  min_size             = 1
  max_size             = 2
  health_check_grace_period = 400
  health_check_type = "ELB"
  load_balancers = ["${aws_elb.public-elb.name}"]
  force_delete = true

  tag {
      key = "Name"
      value = "Jenkins Server"
      propagate_at_launch = true
  }
}

