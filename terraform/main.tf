provider "google" {
  credentials = file(var.secret_key)
  project     = var.project_id
  region = var.region
}

resource "google_compute_instance" "centos7" {
  name         = var.centos7_name
  machine_type = var.instance_type
  zone = var.zone
  description = "the centos7 machine for test"

  tags = ["build"]

  boot_disk {
    initialize_params {
      image = var.centos7_image
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  scheduling {
    preemptible = true
    automatic_restart = false
  }

   metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }
}

resource "google_compute_instance" "ubuntu1804" {
  name         = var.ubuntu1804_name
  machine_type = var.instance_type
  zone = var.zone
  description = "the ubuntu1804 machine for test"

  tags = ["build"]

  boot_disk {
    initialize_params {
      image = var.ubuntu1804_image
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  scheduling {
    preemptible = true
    automatic_restart = false
  }

   metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }
}

resource "google_compute_instance" "ubuntu1604" {
  name         = var.ubuntu1604_name
  machine_type = var.instance_type
  zone = var.zone
  description = "the ubuntu1604 machine for test"

  tags = ["build"]

  boot_disk {
    initialize_params {
      image = var.ubuntu1604_image
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  scheduling {
    preemptible = true
    automatic_restart = false
  }

   metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }
}

output "inventory" {
  value       = "[centos7]\n${google_compute_instance.centos7.name} ansible_host=${google_compute_instance.centos7.network_interface[0].access_config[0].nat_ip} ansible_user=${var.ssh_user} ansible_ssh_private_key_file=${var.ssh_key_file} ansible_ssh_common_args='-o StrictHostKeyChecking=no'\n\n[ubuntu1804]\n${google_compute_instance.ubuntu1804.name} ansible_host=${google_compute_instance.ubuntu1804.network_interface[0].access_config[0].nat_ip} ansible_user=${var.ssh_user} ansible_ssh_private_key_file=${var.ssh_key_file} ansible_ssh_common_args='-o StrictHostKeyChecking=no'\n\n[ubuntu1604]\n${google_compute_instance.ubuntu1604.name} ansible_host=${google_compute_instance.ubuntu1604.network_interface[0].access_config[0].nat_ip} ansible_user=${var.ssh_user} ansible_ssh_private_key_file=${var.ssh_key_file} ansible_ssh_common_args='-o StrictHostKeyChecking=no'"
  description = "The inventory string to feed ansible with"
}
