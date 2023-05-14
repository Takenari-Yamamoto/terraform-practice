provider "google" {
  credentials = file(var.credentials)
  project     = var.project_id
  region      = "us-central1"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "n1-standard-1"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external IP.
    }
  }
}
