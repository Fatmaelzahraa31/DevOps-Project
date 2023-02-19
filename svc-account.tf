resource "google_service_account" "svc" {
  account_id = "svc"
  project = "fatma120d"
}

resource "google_project_iam_binding" "iam" {
  project = "fatma120d"
  role    = "roles/container.admin"
  members = [
  "serviceAccount:${google_service_account.svc.email}"
  ]
}