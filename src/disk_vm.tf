resource "yandex_compute_disk" "vol" {
  name        = "disk-${count.index + 1}"

  count = 3

  type = "network-hdd"
  zone = var.default_zone
  size = 1

}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = "standard-v1"

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type = "network-hdd"
      size = 5
    }   
  }

  metadata = {ssh-keys = "ubuntu:${local.ssh-keys}"}

  scheduling_policy { preemptible = true }

  network_interface { 
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.vol.*.id
    content {
      //device_name = secondary_disk.value.name
      disk_id     = secondary_disk.value
      mode        = "READ_WRITE"
    }
  }
  allow_stopping_for_update = true
  
}