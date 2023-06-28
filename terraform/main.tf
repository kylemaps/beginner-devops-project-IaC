terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.digitalocean_token
}

resource "digitalocean_droplet" "vps" {
  name   = "mapz vps"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
  image  = "ubuntu-18-04-x64"
}

output "droplet_ipv4_address" {
  value = digitalocean_droplet.vps.ipv4_address
}

resource "digitalocean_domain" "yourdomain" {
  name = "mapuekyle.com"
}

resource "digitalocean_record" "yourdomain_record" {
  domain = digitalocean_domain.yourdomain.name
  type   = "A"
  name   = "@"
  value  = digitalocean_droplet.vps.ipv4_address
}