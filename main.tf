provider "google" {
    credentials = file("practica11-311718-d6eefa153219.json")
    project = "practica11-311718"
    region = "us-west1"
}

resource "random_id" "instance_id" {
    byte_length = 8
}

//Creacion de maquina virtual

resource "google_compute_instance" "default" {
    name = "practica11-terraform-${random_id.instance_id.hex}"
    machine_type = "f1-micro"
    zone = "us-west1-a"
    
    boot_disk {
        initialize_params{
            image = "debian-cloud/debian-9"
        }
    }

    metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync; pip install flask"

    network_interface {
        network = "default"

        access_config {
            //read public ip
        }
    }

    metadata = {
        "ssh" = ""
    }
}