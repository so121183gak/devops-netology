resource "local_file" "hosts_cfg" {
 content = templatefile("${path.module}/hosts.tftpl",
    {
 workers = yandex_compute_instance.worker
 masters = yandex_compute_instance.master
    }
  )
 filename = "${path.module}/ansible/kubespray/inventory/mycluster/hosts.yaml"
}