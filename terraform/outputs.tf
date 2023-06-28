output "domain_name" {
  value = digitalocean_domain.yourdomain.name
}

output "domain_records" {
  value = digitalocean_record.yourdomain_record
}