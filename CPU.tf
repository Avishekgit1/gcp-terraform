
resource "google_project_service" "monitoring_api" {
  project = "the-byway-432710-h6"
  service = "monitoring.googleapis.com"
}

resource "google_monitoring_notification_channel" "email_channel" {
  display_name = "Email Notification Channel"
  type         = "email"

  labels = {
    email_address = "avishekshaw144@gmail.com"  # Replace with your email
  }
}

resource "google_monitoring_alert_policy" "cpu_alert" {
  display_name = "High CPU Utilization Alert for monitoring"
  combiner = "OR" 
  depends_on = [google_project_service.monitoring_api]

  conditions {
    display_name = "CPU utilization exceeds 50% for monitoring"

    condition_threshold {
      filter = "resource.type = \"gce_instance\" AND metric.type = \"compute.googleapis.com/instance/cpu/utilization\""
      comparison = "COMPARISON_GT"
      threshold_value = 0.5  # 50% utilization
      duration = "60s"

      aggregations {
        alignment_period = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }

     # Use "OR" or "AND" based on your requirements
  }

  notification_channels = [google_monitoring_notification_channel.email_channel.id]

  /*alert_strategy {
    notification_rate_limit {
      period              = "60s"
    #  allowed_notifications = 3
    }
  }*/
}
