variable "AWS_REGION" {
  default = "eu-west-2"
}
variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "keypair_name" {}


variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}
variable "AMIS" {
  type = "map"
  default = {
    #eu-west-2 = "ami-e05a4d84"
    eu-west-2 = "ami-122c3d76"
    eu-west-1 = "ami-061b1560"
    us-east-1 = "ami-46c1b650"
  }
}
