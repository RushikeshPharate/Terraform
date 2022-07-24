
variable "sg_name" {
}

variable "ec2_name" {
  
}

resource "aws_instance" "my-first-server"{
    ami= "ami-052efd3df9dad4825"
    instance_type = "t2.micro"
    security_groups = [ "${var.sg_name}" ]
    tags = {
    Name = "${var.ec2_name}"
  }

}
