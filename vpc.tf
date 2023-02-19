resource "google_compute_network" "vpc" {
  name    = "vpc"
  project = "fatma120d"
  auto_create_subnetworks = false
}
