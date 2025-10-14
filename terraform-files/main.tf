resource "aws_instance" "banking-server" {
  ami = "ami-02d26659fd82cf299"
  instance_type = "t2.micro"
  key_name = "mumbai"
  vpc_security_group_ids = ["sg-0a978a913a9ca7c0d"]
  connection {
     type = "ssh"
     user = "ubuntu"
     private_key = file("./mumbai.pem")
     host = self.public_ip
     }
  provisioner "remote-exec" {
     inline = ["echo 'wait to start the instance' "]
  }
  tags = {
     Name = "test-server"
     }
  provisioner "local-exec" {
     command = "echo ${aws_instance.test-server.public_ip} > inventory"
     }
  provisioner "local-exec" {
     command = "ansible-playbook /var/lib/jenkins/workspace/Banking-project/terraform-files/ansibleplaybook.yml"
     }
  }
