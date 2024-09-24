resource "google_monitoring_notification_channel" "email_channel" {
  display_name = "Disk utilization crossed threshold"
  type         = "email"

  labels = {
    email_address = "avishekshaw144@gmail.com"  # Replace with your email
  }
}


resource "google_monitoring_alert_policy" "memory_alert" {
  display_name        = "Memory Utilization Alert"
  #notification_channel = "Disk utilization crossed threshold"  # Replace with your notification channel ID
  combiner = "OR"
  conditions {
    display_name = "Memory Utilization High"
    condition_threshold {
      filter = "metric.type=\"compute.googleapis.com/instance/disk/write_bytes_count\" AND resource.type=\"gce_instance\" AND resource.labels.instance_id=\"7771777848152174577\""
      comparison = "COMPARISON_GT"
      threshold_value = 40
      duration = "60s"
      aggregations {
        alignment_period = "60s"
        per_series_aligner = "ALIGN_RATE"
      }
    }
  }

  /*alert_strategy {
    notification_rate_limit {
      period = "60s"
    }
  }*/

  enabled = true
  notification_channels = [google_monitoring_notification_channel.email_channel.id]
}
