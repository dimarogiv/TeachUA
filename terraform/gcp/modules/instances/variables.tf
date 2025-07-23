variable "compute_network" {}
variable "back_subnetwork" {}
variable "google_zone_name" {}

variable "bastion_name" {
  default = "bastion"
}
variable "controlplane_name" {
  default = "controlplane"
}
variable "back_name" {
  default = "back"
}

variable "bastion_machine_type" {
  default = "f1-micro"
}
variable "controlplane_machine_type" {
  default = "c2d-highcpu-2"
}
variable "back_machine_type" {
  default = "c2d-highcpu-2"
}

variable "bastion_init_image" {
  default = "debian-cloud/debian-11"
}
variable "controlplane_init_image" {
  default = "debian-cloud/debian-11"
}
variable "back_init_image" {
  default = "debian-cloud/debian-11"
}
