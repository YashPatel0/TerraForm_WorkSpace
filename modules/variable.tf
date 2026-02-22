variable "region" {
  default = "ap-south-1"
}

# For RDS module

variable "allocated_storage" {
    description = "The allocated storage in GB"
   type        = number
   default     = 20
}

variable "max_allocated_storage" {
   description = "The maximum allocated storage in GB"
   type        = number
   default     = 50

}

variable "instance_class" {
   description = "instance type"
   type = string
   default = "db.t3.micro"
}

variable "username"{
    description = "username for RDS instance"
    default = "yashadmin"
}

variable "password"{
    description = "password for RDS instance"
    default = "Yash1234"
}

# For S3 module

variable "bucket" {
    description = "bucket name"
    default = "my-practice--yash-bucket"
}