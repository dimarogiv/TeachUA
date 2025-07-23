output "compute_network" {
  value = google_compute_network.vpc_network
}

output "back_subnetwork" {
  value = google_compute_subnetwork.back
}
