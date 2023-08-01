
resource "yandex_compute_instance" "vm" {
  for_each = { for key, val in var.vm_resources : key => val }

  name        = each.value.vm_name
  platform_id = "standard-v1"
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      size = each.value.disk
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  
  depends_on = [yandex_compute_instance.web]
  metadata = merge(var.public_key, local.public_key_override)

  /*metadata = {
    ssh-keys           = var.public_key
  }*/

}
