resource "google_compute_firewall" "default" {
  name    = var.firewall_name
  network = var.compute_network.name

  allow {
    protocol = var.first_protocol_to_allow
    ports    = var.allowed_tcp_ports
  }

  allow {
    protocol = var.second_protocol_to_allow
  }

  allow {
    protocol = var.third_protocol_to_allow
    ports    = var.allowed_udp_ports
  }
  
  source_ranges = var.source_ranges
}
