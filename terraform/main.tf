provider "google" {
 version = "1.4.0"
 project ="${var.project}"
 region = "${var.region}"
}
resource "google_compute_instance" "app" {
  count        = "${var.count_instance}"  
  name         = "reddit-app-${count.index+1}"
  machine_type = "g1-small"
  zone         = "${var.zone_app}"
  tags = ["reddit-app"]  

  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"

    # использовать ephemeral IP для доступа из Интернет
    access_config {}
  }
  
  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

  connection {
    type        = "ssh"
    user        = "wrx"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

resource "google_compute_firewall" "firewall_puma" {
 name = "allow-puma-default"
 # Название сети, в которой действует правило
 network = "default"
 # Какой доступ разрешить
 
 allow {
  protocol = "tcp"
  ports = ["9292"]
 }
 
 # Каким адресам разрешаем доступ
 source_ranges = ["0.0.0.0/0"]
 
 # Правило применимо для инстансов с перечисленными тэгами
 target_tags = ["reddit-app"]
}

resource "google_compute_project_metadata" "ssh-keys" {
  metadata {
    ssh-keys = "wrx1:${file(var.public_key_path)}wrx2:${file(var.public_key_path)}wrx3:${file(var.public_key_path)}"
  }
}
