resource "google_compute_firewall" "firewall_ssh" {
  name    = "default-allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = "${var.source_ranges}"
}

resource "google_compute_firewall" "firewall_http" {
  name    = "default-allow-http-hw10"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  
  source_ranges = ["0.0.0.0/0"]
}
