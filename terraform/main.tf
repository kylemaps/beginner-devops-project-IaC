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

/* resource "digitalocean_ssh_key" "default" {
  name       = "My public key"
  public_key = file("/.ssh/id_rsa.pub")
} */

resource "digitalocean_droplet" "vps" {
  name      = "maps-vps"
  region    = "nyc1"
  size      = "s-1vcpu-1gb"
  image     = "ubuntu-18-04-x64"
  ssh_keys  = [data.digitalocean_ssh_key.terraform.id]
  #ssh_keys  = [digitalocean_ssh_key.default.fingerprint]

  connection {
  host        = self.ipv4_address
  user        = "root"
  type        = "ssh"
  private_key = file(var.pvt_key)
  timeout     = "2m"
  }
}

data "digitalocean_ssh_key" "terraform" {
  name = "mySshKey"
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
