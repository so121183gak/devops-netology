resource "yandex_compute_instance" "worker" {
  name        = "worker-${count.index + 1}"
  platform_id = "standard-v1"
  
  count = 4

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type = "network-hdd"
      size = 20
    }   
  }

    metadata = {
      user-data          = data.template_file.cloudinit.rendered
      serial-port-enable = 1
  }

  scheduling_policy { preemptible = true }

  network_interface { 
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true

  }
  allow_stopping_for_update = true
  
}