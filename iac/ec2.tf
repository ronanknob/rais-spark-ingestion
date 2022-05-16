# AMI do Ubunto para uso no Aiflow
data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    owners = [ "099720109477" ] # O Owner da imagem é a canonical
}

# Instância EC2 que hospeda o Airflow
resource "aws_instance" "aiflow-server" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  key_name = var.key_pair_name
  associate_public_ip_address = true
  security_groups = [aws_security_group.airflow_sg.id]
  subnet_id = var.airflow_subnet_id

  tags = {
    "OWNER" = "RONAN"
  }
}

# SG do Airflow Server
resource "aws_security_group" "airflow_sg" {
  name = "airflow_sg"
  description = "Allow traffic on port 8080 for airflow"
  vpc_id = var.vpc_id

  ingress {
        description = "Airflow UI port"
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
        ipv6_cidr_blocks = [ "::/0" ]
    }

    ingress {
        description = "SSH port"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
        ipv6_cidr_blocks = [ "::/0" ]
    }

     ingress {
        description = "Flower UI port"
        from_port = 5555
        to_port = 5555
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
        ipv6_cidr_blocks = [ "::/0" ]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

  tags = {
    "OWNER" = "RONAN"
  }

}