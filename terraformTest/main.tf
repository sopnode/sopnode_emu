terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
    # tls = {
    #   source  = "hashicorp/tls"
    #   version = "3.1.0"
    # }
  }
}

provider "google" {
  project     = var.project
  credentials = file(var.credentials_file)
  region      = var.region
  zone        = var.zone
}
# provider "tls" {
#   // no config needed
# }


# resource "tls_private_key" "ssh" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "local_file" "ssh_private_key_pem" {
#   content         = tls_private_key.ssh.private_key_pem
#   filename        = ".ssh/google_compute_engine"
#   file_permission = "0600"
# }

# resource "google_compute_network" "vpc_network" {
#   name = "interalnet"
# }
resource "google_compute_address" "static_ip1" {
  name = "switch1"
}
resource "google_compute_address" "static_ip2" {
  name = "switch2"
}
resource "google_compute_address" "static_ip3" {
  name = "switch3"
}

resource "google_compute_subnetwork" "subnet1" {
  name          = "test-subnetwork"
  ip_cidr_range = "192.168.12.0/24"
  region        = "us-central1"
  network       = "default"
}
resource "google_compute_subnetwork" "subnet2" {
  name          = "test2-subnetwork"
  ip_cidr_range = "192.168.22.0/24"
  region        = "us-central1"
  network       = "network1"
}

resource "google_compute_firewall" "allow_ssh" {
  name          = "allow-ssh"
  network       = "default"
  target_tags   = ["allow-ssh"] // this targets our tagged VM
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
resource "google_compute_firewall" "allow_onos_stratum" {
  name          = "allow-onos-stratum"
  network       = "default"
  target_tags   = ["allow-onos-stratum"] // this targets our tagged VM
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["9559", "5005", "8101", "8181"]
  }
}

# data "google_client_openid_userinfo" "me" {}

resource "google_compute_instance" "switch1" {
  name         = "sw1"
  machine_type = "e2-medium"
  tags         = ["allow-ssh", "allow-onos-stratum", "default-allow-http","default-allow-https"] // this receives the firewall rule

  metadata = {
    #ssh-keys = "${split("@", data.google_client_openid_userinfo.me.email)[0]}:${tls_private_key.ssh.public_key_openssh}"
    enable-oslogin = "TRUE"
  }

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20220712"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet1.name
    network_ip = "192.168.12.5"
    access_config {
      nat_ip = google_compute_address.static_ip1.address
    }
  }
}

resource "google_compute_instance" "switch2" {
  name         = "sw2"
  machine_type = "e2-medium"
  tags         = ["allow-ssh", "allow-onos-stratum", "default-allow-http","default-allow-https"] // this receives the firewall rule

  metadata = {
    #ssh-keys = "${split("@", data.google_client_openid_userinfo.me.email)[0]}:${tls_private_key.ssh.public_key_openssh}"
    enable-oslogin = "TRUE"
  }

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20220712"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet2.name
    network_ip = "192.168.22.2"
    access_config {
      nat_ip = google_compute_address.static_ip2.address
    }
  }
    network_interface {
    subnetwork = google_compute_subnetwork.subnet1.name
    network_ip = "192.168.12.3"
    }
  
}

resource "google_compute_instance" "switch3" {
  name         = "sw3"
  machine_type = "e2-medium"
  tags         = ["allow-ssh", "allow-onos-stratum", "default-allow-http","default-allow-https"] // this receives the firewall rule

  metadata = {
    #ssh-keys = "${split("@", data.google_client_openid_userinfo.me.email)[0]}:${tls_private_key.ssh.public_key_openssh}"
    enable-oslogin = "TRUE"
  }

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20220712"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet2.name
    network_ip = "192.168.22.3"
    access_config {
      nat_ip = google_compute_address.static_ip3.address
    }
  }
}