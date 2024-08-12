# Security Group tp allow SSH trafic from the internet 
resource "aws_security_group" "allow_ssh_sg" {
  name        = "allow_ssh"
  description = "Allow SSH trafic from internet"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22 # SSH port
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group to allow PgSQL traffic from private subnet to RDS instance
resource "aws_security_group" "allow_to_pg_rds" {
  name        = "allow_pg_rds"
  description = "Allow PgSQL trafic to RDS instance"
  vpc_id      = aws_vpc.main_vpc.id
  ingress {
    from_port   = 5342 # PgSQL port
    to_port     = 5342
    protocol    = "tcp"
    cidr_blocks = var.private_subnets
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# Security Group to allow HTTP and HTTPS traffic from the internet
resource "aws_security_group" "allow_http_https_from_internet" {
  name        = "allow_http_https_from_internet"
  description = "Allow HTTPS Traffic from internet"
  vpc_id      = aws_vpc.main_vpc.id
  ingress {
    from_port   = 80 # HTTP port
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443 # HTTP port
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
