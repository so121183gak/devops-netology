resource "local_file" "hosts_cfg" {
 content = templatefile("${path.module}/hosts.tftpl",
    {
 workers = yandex_compute_instance.worker
 masters = yandex_compute_instance.master
#  storage = [yandex_compute_instance.storage]
    }
  )
 filename = "${path.module}/ansible/hosts.yaml"
}