variable "network_name" {
  default = "terraform-network"
}

variable "back_subnetwork_name" {
  default = "back-subnet"
}

variable "back_ip_range" {
  default = "10.2.0.0/16"
}

variable "google_region_name" {}
