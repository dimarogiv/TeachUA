variable "compute_network" {}

variable "firewall_name" {
  default = "main-firewall"
}
variable "first_protocol_to_allow" {
  default = "tcp"
}
variable "second_protocol_to_allow" {
  default = "icmp"
}
variable "third_protocol_to_allow" {
  default = "udp"
}
variable "allowed_tcp_ports" {
  default = ["22", "3001", "3002", "80", "8080", "443", "6443"]
}
variable "allowed_udp_ports" {
  default = ["8472"]
}
variable "source_ranges" {
  default = ["0.0.0.0/0"]
}
