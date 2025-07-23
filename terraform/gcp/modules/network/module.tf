resource "google_compute_network" "vpc_network" {
  name = var.network_name
}

resource "google_compute_subnetwork" "back" {
  name          = var.back_subnetwork_name
  ip_cidr_range = var.back_ip_range
  region        = var.google_region_name
  network       = google_compute_network.vpc_network.id
}

module "cloud_router" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "~> 7.0"
  name    = "main-router"
  project = "teachua-6147"
  network = var.network_name
  region  = "us-central1"

  nats = [{
    name                               = "main-nat-gateway"
    source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
    subnetworks = [
      {
        name                    = google_compute_subnetwork.back.id
        source_ip_ranges_to_nat = ["PRIMARY_IP_RANGE"]
      }
    ]
  }]
}
