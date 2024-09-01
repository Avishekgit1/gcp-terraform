terraform {
  backend "gcs" {
    bucket  = "backendtf-bucket"
    prefix  = "terraform/state"
  }
}
