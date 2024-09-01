

###########Basicbucket#######
resource "google_storage_bucket" "simonbucket009" {
  name          = "simonbucket0065"
  location       = "US"  # Change the location if needed
  force_destroy  = true  # Optional: Allows you to delete the bucket even if it contains objects

  # You can define other settings here, such as lifecycle rules, versioning, etc.
}

output "bucket_name" {
  value = google_storage_bucket.simonbucket009.name
}
