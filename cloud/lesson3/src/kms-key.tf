resource "yandex_kms_symmetric_key" "key-a" {
  name              = "netology"
  description       = "Ключ шифрования для бакета test-picture"
  default_algorithm = "AES_128"
  rotation_period   = "8760h"
  lifecycle {
    prevent_destroy = false
  }
}