resource "google_compute_firewall" "firewall" {
  name        = "firewall"
  project     = "fatma120d"
  network     = google_compute_network.vpc.id
  direction   = "INGRESS"
  priority    = 1000
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }
}