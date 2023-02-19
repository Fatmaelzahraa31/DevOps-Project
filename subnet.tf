resource "google_compute_subnetwork" "subnet" {
  name          = "subnet"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.my_vpc.id
  region        = "us-central1"
  routing_mode  = "REGIONAL"
  access_config {
    public_ip = "none"
  }
  secondary_ip_range {
     range_name = "cluster-range"
    ip_cidr_range = "10.0.2.0/24"
  }
  secondary_ip_range {
     range_name = "svc-range"
    ip_cidr_range = "10.0.3.0/24"
  }
}