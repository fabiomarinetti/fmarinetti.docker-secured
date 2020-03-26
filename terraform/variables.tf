########## GCE DRIVER #########

# the secret key
variable "secret_key" {
  default = "secret.json"
}

# the google cloud project_id
variable "project_id" {
  default = "ansible-272015"
}

# the region used for the test infrastructure
variable "region" {
  default = "us-east1"
}

# the zone used for the test infrastructure
variable "zone" {
  default = "us-east1-c"
}

########## INSTANCES #########

# the centos7 instance name
variable "centos7_name" {
  default = "abbeyroad"
}

# the centos7 image
variable "centos7_image" {
  default = "centos-cloud/centos-7"
}

# the ubuntu bionic instance name
variable "ubuntu1804_name" {
  default = "revolver"
}

# the ubuntu bionic 18.04 lts image
variable "ubuntu1804_image" {
  default = "ubuntu-os-cloud/ubuntu-1804-lts"
}

# the ubuntu xenial instance name
variable "ubuntu1604_name" {
  default = "letitbe"
}

# the ubuntu xenial 16.04 lts image
variable "ubuntu1604_image" {
  default = "ubuntu-os-cloud/ubuntu-1604-lts"
}

# the instance type
variable "instance_type" {
  default = "f1-micro"
}

# the ssh user
variable "ssh_user" {
  default = "fabio"
}

# the ssh key
variable "ssh_key_file" {
  default = "/root/.ssh/id_rsa"
}

# the ssh public key
variable "ssh_pub_key_file" {
  default = "/root/.ssh/id_rsa.pub"
}
