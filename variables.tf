variable "region" {
  default = "us-west-2"
}

variable "ec2_ssh_key_name" {
  default = "ec2-key"
}

variable "ec2_provisioning_ssh_connection_key_path" {
  default = "/mnt/c/Users/andre/aws/ec2-key.pem"
}

variable "authorized_ips_range" {
  default = [
    "0.0.0.0/0",
  ]
}

variable "vpc_cidr_block" {
  default = "172.32.0.0/16"
}

variable "ubuntu_version" {
  default = "bionic-18.04"
}