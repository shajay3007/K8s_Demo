variable "ec2type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "instances" {
  description = "List of instances to create"
  type        = map(object({
    instance_type = string
    user_data     = string
    tags          = map(string)
  }))
  default = {
    sonar = {
      instance_type = "t2.micro"  # Replace with placeholder, will override in resource block
      user_data     = "sonar_user_data.sh"
      tags          = { Name = "Sonar-Instance", Role = "sonar" }
    }
    nexus = {
      instance_type = "t2.micro"  # Replace with placeholder, will override in resource block
      user_data     = "Nexus_user_data.sh"
      tags          = { Name = "Nexus-Instance", Role = "nexus" }
    }
  }
}


resource "aws_security_group" "app_sg" {
  name        = "app-security-group"
  description = "Allow required inbound traffic"

  # Define a list of allowed ports
  dynamic "ingress" {
    for_each = [22, 80, 443, 9000, 8081]  # List of required ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]  # Change this to restrict access in production
    }
  }

  # Kubernetes Port Range (30000-32767)
  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "App-SG"
  }
}


# Create EC2 instances using for_each
resource "aws_instance" "instances" {
  for_each      = var.instances
  ami           = var.ami_id
  instance_type = var.ec2type
  key_name      = var.ssh_key_name
  user_data     = file(each.value.user_data)

  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tags = each.value.tags
}
