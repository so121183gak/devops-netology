# Создаем сервисный аккаунт для работы в Object Storage
resource "yandex_iam_service_account" "sa" {
  name = "sa"
}

# Назначаем роли сервисному аккаунту для работы с Object Storage
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

# Создаем статический ключ доступа
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}



# Создаем сервисный аккаунт для работы Instance Group 
resource "yandex_iam_service_account" "sa-ig" {
  name = "sa-ig"
}
# Назначение роли сервисному аккаунту для работы с Instance Group 
resource "yandex_resourcemanager_folder_iam_member" "sa-ig-editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa-ig.id}"
}