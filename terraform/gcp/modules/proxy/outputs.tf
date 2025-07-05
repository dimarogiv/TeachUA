#output "back_global_forwarding_rule_ip" {
#  value = google_compute_global_forwarding_rule.back
#}

output "front_global_forwarding_rule_ip" {
  value = google_compute_global_forwarding_rule.front
}
