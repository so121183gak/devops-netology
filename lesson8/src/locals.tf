locals {
  web_platform_name = "${var.vm_yandex_compute_instance_global_name}-${var.vm_web_yandex_compute_instance_platform_name}"
  db_platform_name = "${var.vm_yandex_compute_instance_global_name}-${var.vm_db_yandex_compute_instance_platform_name}"  
  vm_metadata_override = {ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"}
}
