output "sg_id"{
    value = aws_security_group.web_access_sg.id
    description = "Security Group ID"
}