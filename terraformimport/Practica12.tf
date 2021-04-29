provider "google" {
    credentials = file("practica11-311718-d6eefa153219.json")
    project = "practica11-311718"
    region = "us-west1"
    zone = "us-west1-a"
}

resource "google_compute_instance" "Practica12VM" {
  
}

resource "random_id" "instance_id" {
    byte_length = 8
}