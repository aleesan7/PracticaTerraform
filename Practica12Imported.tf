provider "google" {
    credentials = file("practica12-312004-27a066a46a07.json")
    project = "practica12-312004"
    region = "us-west1"
    zone = "us-west1-a"
}

resource "random_id" "instance_id" {
    byte_length = 8
}

resource "google_compute_instance" "Practica12VM" {
    can_ip_forward          = false
    deletion_protection     = false
    enable_display          = false
    machine_type            = "f1-micro"
    metadata                = {
        "ssh-keys" = <<-EOT
            ka_sa:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDO3rXBJYNlvc41sf0+DnCQKDJizARO7TZNpjtC90FSCmK9HgX1HzJYcUXmJtZ2QjzwyKrg7iOlU/fcbQ+75ZlboDRyaUghQb+w9ZDLMKzjNFwx22UMt9w4Xu7ngY9QAe7QaItNMUi2sTUCsvpB3+T0Ugk8aOFKKmP94hxVAI4iGBXI7LrXsfLjSBwTV0oDEMaWAZXwAhI8BVu2Yu3EkyaE8F8oZOzk+n2fGGq3QV47/2Z/AKKOubnokY1gjYI79huhFlD//iRswGU3CdqLZ2S1M9QqBGxa3XNWddqvNt3c+kbJsBMK9+pOjWoTfzr5xLnLGkLNKus9gep5PUO+9xnvlokX3y+rg4yOsaW+an99G7KTihzu434IFcpw0QDohFo4UiA+MAjObOJp3AnoptS6dT4Ngdtn0dliHWPVnZ6yBECNojP3LP/VT787EUFfwA2fZCnZ2B4KuBxs4sd3JvqHwnX44dPXcAgB68NZbw4qFI9sWD5OzzTgKchepq6Kg4U= ka_sa
        EOT
    }
    metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync; pip install flask"
    name                    = "practica12-terraform-${random_id.instance_id.hex}"
    zone                    = "us-west1-a"

    boot_disk {
        auto_delete = true
        device_name = "persistent-disk-0"
        mode        = "READ_WRITE"

        initialize_params {
            image  = "https://www.googleapis.com/compute/v1/projects/debian-cloud/global/images/debian-9-stretch-v20210420"
            labels = {}
            size   = 10
            type   = "pd-standard"
        }
    }

    network_interface {
        network            = "default"

        access_config {

        }
    }

    scheduling {
        automatic_restart   = true
        min_node_cpus       = 0
        on_host_maintenance = "MIGRATE"
        preemptible         = false
    }

    timeouts {}
}

output "ip" {
  value = google_compute_instance.Practica12VM.network_interface.0.access_config.0.nat_ip
}