variable "region" {
    default = "us-east-1"
}


variable "ami" {
    description = "AMI ID for EC2"
    default = "ami-08982f1c5bf93d976"
}


variable "instance_type" {
    description = "EC2 instance type"
    default = "t3.micro"

}

variable "key_pair_name" {
   description = "VPC key" 
   default = "VPC-key"
}