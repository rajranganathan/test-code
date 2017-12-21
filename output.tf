output "ELB:" {
	value = "${aws_elb.hsb-elb.dns_name}"
}

output "BASTION:" {
        value = "${aws_instance.bast-instance.public_ip}"
}
