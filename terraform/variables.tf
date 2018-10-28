variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable public_key_path {
  description = "Path to the PUBLIC key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable private_key_path {
  description = "Path to the PRIVITE key used for ssh access"
}

variable zone_app {
  description = "Zone"
  default     = "europe-west1-b"
}

variable count_instance {
  description = "Count instances"
  default     = 1
}
