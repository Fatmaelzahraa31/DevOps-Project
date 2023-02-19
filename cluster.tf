resource "google_container_cluster" "my_cluster" {
  name               = "my-cluster"
  network            = google_compute_network.vpc.id
  subnetwork         = google_compute_subnetwork.subnet.id
  location           = "us-central1"
  remove_default_node_pool = true
  initial_node_count = 1

  # Set the cluster to private
  private_cluster_config {
    enable_private_endpoint = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
    enable_private_nodes    = true
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
    service_account = google_service_account.svc.email
  }

  ip_allocation_policy { 
    cluster_secondary_range_name = "cluster-range"
     services_secondary_range_name = "svc-range"
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = "10.0.4.0/24"
      display_name = "cidr-range"
    }
  }

    addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "fatma120d.service.id.goog"
  }
}

resource "google_container_node_pool" "node-pool" {
  name       = "node-pool"
  location   = "us-central1"
  cluster    = google_container_cluster.my_cluster.id
  node_count = 1
  management {
    auto_repair = true
    auto_upgrade = true
      }
  
  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
    preemptible  = true
    machine_type = "e2-medium"
    service_account = google_service_account.svc.email
  }
}