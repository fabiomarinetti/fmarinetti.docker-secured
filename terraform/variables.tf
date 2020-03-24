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

########## INSTANCE #########

# the instance name
variable "instance_name" {
  default = "instance1"
}

# the image for the instance name
variable "image" {
  default = "centos-cloud/centos-7"
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
