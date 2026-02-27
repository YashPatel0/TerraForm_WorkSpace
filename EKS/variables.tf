variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "private_subnet_1_cidr" {
    default = "10.0.1.0/24"
}

variable "availability_zone_1" {
    default = "ap-south-1a"
}

variable "private_subnet_2_cidr" {
    default = "10.0.2.0/24"
}

variable "availability_zone_2" {
    default = "ap-south-1b"
}

variable "instance_types" {
    default = ["t3.small"]
}

variable "desired_size" {
    default = 2
}

variable "max_size" {
    default = 4
}

variable "min_size" {
    default = 1
}
