resource "google_compute_instance_template" "back_temp" {
  name = "back-temp"
  disk {
    auto_delete  = true
    boot         = true
    device_name  = "persistent-disk-0"
    mode         = "READ_WRITE"
    source_image = "projects/debian-cloud/global/images/family/debian-11"
    type         = "PERSISTENT"
  }
  labels = {
    managed-by-cnrm = "true"
    group_instance  = "back-group"
  }
  machine_type = var.back_machine_type
  metadata = {
    startup-script = "echo hello"
  }
  network_interface {
    network    = var.compute_network.self_link
    subnetwork = "back-subnet"
  }
  region = "us-central1"
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    provisioning_model  = "STANDARD"
  }
  service_account {
    email  = "default"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/pubsub", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }
}

resource "google_compute_instance_group_manager" "back_group" {
  name = "back-group"
  zone = var.google_zone_name
  version {
    instance_template = google_compute_instance_template.back_temp.id
    name              = "primary"
  }
  base_instance_name = "back"
  target_size        = 2
  update_policy {
    type                  = "PROACTIVE"
    minimal_action        = "REPLACE"
    max_surge_fixed       = 1
    max_unavailable_fixed = 0
  }
}

resource "google_compute_instance" "controlplane" {
  name         = var.controlplane_name
  machine_type = var.controlplane_machine_type

  boot_disk {
    initialize_params {
      image = var.controlplane_init_image
    }
  }

  network_interface {
    network = var.compute_network.name
    access_config {
    }
  }
}

resource "google_compute_instance" "bastion" {
  name         = var.bastion_name
  machine_type = var.bastion_machine_type

  boot_disk {
    initialize_params {
      image = var.bastion_init_image
    }
  }

  network_interface {
    network = var.compute_network.name
    access_config {
    }
  }
}
