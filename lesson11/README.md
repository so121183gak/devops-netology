# Использование Terraform в команде

### Задание 1
- Проверьте код с помощью tflint и checkov. Перечислите, какие типы ошибок обнаружены в проекте (без дублей).

**TFlint**
```
Warning: Missing version constraint for provider "yandex" in `required_providers` (terraform_required_providers)

  on main.tf line 3:
   3:     yandex = {
   4:       source = "yandex-cloud/yandex"
   5:     }

Warning: Module source "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main" uses a default branch as ref (main) (terraform_module_pinned_source)

  on main.tf line 33:
  33:   source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"

Warning: [Fixable] variable "vpc_name" is declared but not used (terraform_unused_declarations)

  on variables.tf line 28:
  28: variable "vpc_name" {
```

**Checkov**
```
Check: CKV_YC_2: "Ensure compute instance does not have public IP."
        FAILED for resource: module.test-vm.yandex_compute_instance.vm[0]
        File: /.external_modules/github.com/udjin10/yandex_compute_instance/main/main.tf:24-73
        Calling File: /main.tf:32-48

Check: CKV_YC_11: "Ensure security group is assigned to network interface."
        FAILED for resource: module.test-vm.yandex_compute_instance.vm[0]
        File: /.external_modules/github.com/udjin10/yandex_compute_instance/main/main.tf:24-73
        Calling File: /main.tf:32-48

Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
        FAILED for resource: test-vm
        File: /main.tf:32-48


```

### Задание 2
- Повторите демонстрацию лекции: настройте YDB, S3 bucket, yandex service account, права доступа и мигрируйте state проекта в S3 с блокировками. Предоставьте скриншоты процесса в качестве ответа.

<p align="center">
  <img width="600" height="" src="./assets/tr_05_01.png">
</p>

<p align="center">
  <img width="600" height="" src="./assets/tr_05_02.png">
</p>

<p align="center">
  <img width="600" height="" src="./assets/tr_05_03.png">
</p>

<p align="center">
  <img width="600" height="" src="./assets/tr_05_04.png">
</p>

<p align="center">
  <img width="600" height="" src="./assets/tr_05_05.png">
</p>

<p align="center">
  <img width="600" height="" src="./assets/tr_05_06.png">
</p>

<p align="center">
  <img width="600" height="" src="./assets/tr_05_07.png">
</p>

<p align="center">
  <img width="600" height="" src="./assets/tr_05_08.png">
</p>

- Откройте в проекте terraform console, а в другом окне из этой же директории попробуйте запустить terraform apply.
Пришлите ответ об ошибке доступа к state.

<p align="center">
  <img width="600" height="" src="./assets/tr_05_09.png">
</p>

- Принудительно разблокируйте state. Пришлите команду и вывод.
```
terraform force-unlock 0f846994-70aa-05e1-b94c-8fe08fc019e3
Do you really want to force-unlock?
  Terraform will remove the lock on the remote state.
  This will allow local Terraform commands to modify this state, even though it
  may still be in use. Only 'yes' will be accepted to confirm.

  Enter a value: yes

Terraform state has been successfully unlocked!

The state has been unlocked, and Terraform commands should now be able to
obtain a new lock on the remote state.

```

### Задание 3
- Пришлите ссылку на PR для ревью.
https://github.com/so121183gak/devops-netology/pull/2

### Задание 4
- Напишите переменные с валидацией и протестируйте их, заполнив default верными и неверными значениями. Предоставьте скриншоты проверок из terraform console

```
variable "test_ip" {
  type        = string
  default     = "192.168.0.1"
  description = "ip-адрес"
  validation {
    condition = can(regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$", var.test_ip))
    error_message = "Invalip IP adres"
  }
}
```

- type=string, description="ip-адрес" — проверка, что значение переменной содержит верный IP-адрес с помощью функций cidrhost() или regex(). Тесты: "192.168.0.1" и "1920.1680.0.1";

<p align="center">
  <img width="600" height="" src="./assets/tr_05_11.png">
</p>

<p align="center">
  <img width="600" height="" src="./assets/tr_05_12.png">
</p>

```
variable "test_list_ip" {
  type        = list(string)
  default     = ["192.168.0.1", "1.1.1.1", "127.0.0.1"]
  description = "список ip-адресов"
  validation {
    condition = can([for ip in var.test_list_ip : regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$", ip)])
    error_message = "Invalip IP adres"
  }
}
```
- type=list(string), description="список ip-адресов" — проверка, что все адреса верны. Тесты: ["192.168.0.1", "1.1.1.1", "127.0.0.1"] и ["192.168.0.1", "1.1.1.1", "1270.0.0.1"].

<p align="center">
  <img width="600" height="" src="./assets/tr_05_13.png">
</p>

<p align="center">
  <img width="600" height="" src="./assets/tr_05_14.png">
</p>

### Весь код можно посмотреть по ссылке
https://github.com/so121183gak/devops-netology/tree/terraform-05/src