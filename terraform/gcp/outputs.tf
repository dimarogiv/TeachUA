output "global_address" {
  value = module.gcp_instances[0].controlplane.network_interface.0.access_config[0].nat_ip
}

output "bastion_ip" {
  value = module.gcp_instances[0].bastion.network_interface.0.access_config[0].nat_ip
}

# Database outputs for GCP
output "database_connection" {
  value = var.cloud_platform == "gcp" ? (
    length(module.gcp_database) > 0 ? module.gcp_database[0].database_connection : null
  ) : null
  description = "Database connection details"
  sensitive   = true
}

output "jdbc_connection_string" {
  value = var.cloud_platform == "gcp" ? (
    length(module.gcp_database) > 0 ? module.gcp_database[0].jdbc_connection_string : null
  ) : null
  description = "JDBC connection string"
}
