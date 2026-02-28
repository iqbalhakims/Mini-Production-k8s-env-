## vpc

resource "aws_vpc" "k8s_vpc" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "k8s_subnet" {
    vpc_id = aws_vpc.k8s_vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
}

#internet gateway + routing

resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.k8s_vpc.id
}

resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.k8s_vpc.id
}

resource "aws_route" "internet" {
    route_table_id = aws_route_table.rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "rta" {
    subnet_id = aws_subnet.k8s_subnet.id
    route_table_id = aws_route_table.rt.id
}

#security group

resource "aws_security_group" "k8s_sg" {
    vpc_id = aws_vpc.k8s_vpc.id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 6443
        to_port     = 6443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 0
        to_port     = 65535
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

#ec2 instances

resource "aws_instance" "controlplane" {
    ami                    = var.ami
    instance_type          = var.instance_type
    subnet_id              = aws_subnet.k8s_subnet.id
    vpc_security_group_ids = [aws_security_group.k8s_sg.id]
    key_name = var.key_name_controlplane
    user_data = file("userdata.sh")

    tags = {
        Name = "k8s-controlplane"
        Role = "controlplane"
    }
}
resource "aws_key_pair" "deployer" {
  key_name   = var.key_name_controlplane
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_instance" "workers" {
    count                  = 2
    ami                    = var.ami
    instance_type          = var.instance_type
    subnet_id              = aws_subnet.k8s_subnet.id
    vpc_security_group_ids = [aws_security_group.k8s_sg.id]
    key_name = var.key_name_controlplane

    tags = {
        Name = "k8s-worker-${count.index + 1}"
        Role = "worker"
    }

}