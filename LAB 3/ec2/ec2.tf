resource "aws_instance" "test_instances" {
  instance_type               = var.ec2["instance_type"]
  ami                         = var.ec2["ami_id"]
  key_name                    = "ronaldo-key"
  associate_public_ip_address = false
  # user_data                   = data.template_file.php-install.rendered
  # subnet_id                   = count.index % 2 == 0 ? aws_subnet.private_subnet[0].id : aws_subnet.private_subnet[1].id
  subnet_id = local.public_subnet_id[0]
  vpc_security_group_ids      = [aws_security_group.allow_http_https_from_internet.id, aws_security_group.allow_ssh_sg.id]
  root_block_device {
    delete_on_termination = "true"
    volume_size           = "10"
    volume_type           = "gp3"
    iops                  = "3000"
    throughput            = "125"
  }

  tags = {
    Name = "BDI Training EC2 Instance"
  }
}
