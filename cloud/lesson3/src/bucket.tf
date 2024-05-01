# Создание корзины 
resource "yandex_storage_bucket" "test-bucket" {
  access_key    = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key    = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket        = "test-picture-lksjdhgfskjfghs"
  acl           = "public-read"
  force_destroy = "true"
  max_size   = 1073741824
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key-a.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

# Создаем обьект в корзине
resource "yandex_storage_object" "image-object" {
  access_key    = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key    = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket        = yandex_storage_bucket.test-bucket.bucket
  # bucket        = "test-picture-lksjdhgfskjfghs"
  acl           = "public-read"
  key           = "test.png"
  source        = "~/test.png"
  depends_on    = [yandex_storage_bucket.test-bucket]
  object_lock_legal_hold_status = "OFF"
}

