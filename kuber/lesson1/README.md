# Kubernetes. Причины появления. Команда kubectl

### Основная часть

#### Задание 1. Установка MicroK8S

1. Установить MicroK8S на локальную машину или на удалённую виртуальную машину.
<p align="center">
  <img width="600" height="" src="./assets/kuber_01_01.png">
</p


2. Установить dashboard.

Включаем дополнение

<p align="center">
  <img width="600" height="" src="./assets/kuber_01_02.png">
</p

3. Сгенерировать сертификат для подключения к внешнему ip-адресу.

- Вносим IP в конфиг **/var/snap/microk8s/current/certs/csr.conf.template**
<p align="center">
  <img width="600" height="" src="./assets/kuber_01_05.png">
</p>

- Обновляем сертификаты ```sudo microk8s refresh-certs --cert front-proxy-client.crt```
<p align="center">
  <img width="600" height="" src="./assets/kuber_01_06.png">
</p>


#### Задание 2. Установка и настройка локального kubectl


1. Установить на локальную машину kubectl.
<p align="center">
  <img width="600" height="" src="./assets/kuber_01_07.png">
</p>

<p align="center">
  <img width="600" height="" src="./assets/kuber_01_08.png">
</p>

2. Настроить локально подключение к кластеру.

- Узнаем данные для подключения к ноде и переносим их в локальную конфигурацию ~/.kube/config
<p align="center">
  <img width="600" height="" src="./assets/kuber_01_09.png">
</p>

3. Подключиться к дашборду с помощью port-forward.
- Запускаем port-forward

<p align="center">
  <img width="600" height="" src="./assets/kuber_01_10.png">
</p>

- Выдкргиваем токен 

<p align="center">
  <img width="600" height="" src="./assets/kuber_01_11.png">
</p>

- Переходим на WEB интерфейс

<p align="center">
  <img width="600" height="" src="./assets/kuber_01_12.png">
</p>