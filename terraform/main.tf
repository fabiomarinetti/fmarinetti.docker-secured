provider "google" {
  credentials = file(var.secret_key)
  project     = var.project_id
  region = var.region
}

resource "google_compute_instance" "instance" {
  name         = var.instance_name
  machine_type = var.instance_type
  zone = var.zone

  boot_disk {
    initialize_params {
      image = var.image
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
  value       = "[${google_compute_instance.instance.name}]\ninstance ansible_host=${google_compute_instance.instance.network_interface[0].access_config[0].nat_ip} ansible_user=${var.ssh_user} ansible_ssh_private_key_file=${var.ssh_key_file} ansible_ssh_common_args='-o StrictHostKeyChecking=no'"
  description = "The inventory string to feed ansible with"
}
