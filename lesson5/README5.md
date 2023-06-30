# Введение в виртуализацию

### 1. Задача
- Скриншот страницы с образом
<p align="center">
  <img width="800" height="400" src="./assets/yc_01.png">
</p>

### 2. Задача
- Страница свойств виртуальной машины
<p align="center">
  <img width="800" height="600" src="./assets/yc_02.png">
</p>


### 3. Задача
- Вывод команды docker ps
```
[root@centos-ansible ~]# docker ps
CONTAINER ID   IMAGE                              COMMAND                  CREATED          STATUS                    PORTS                                                                              NAMES
2d94c51d151d   prom/pushgateway:v1.2.0            "/bin/pushgateway"       30 minutes ago   Up 30 minutes             9091/tcp                                                                           pushgateway
8393d0748581   prom/node-exporter:v0.18.1         "/bin/node_exporter …"   30 minutes ago   Up 30 minutes             9100/tcp                                                                           nodeexporter
7bb5602759a1   stefanprodan/caddy                 "/sbin/tini -- caddy…"   30 minutes ago   Up 30 minutes             0.0.0.0:3000->3000/tcp, 0.0.0.0:9090-9091->9090-9091/tcp, 0.0.0.0:9093->9093/tcp   caddy
b15cca0a7d57   prom/prometheus:v2.17.1            "/bin/prometheus --c…"   30 minutes ago   Up 30 minutes             9090/tcp                                                                           prometheus
e60b4ef095a2   prom/alertmanager:v0.20.0          "/bin/alertmanager -…"   30 minutes ago   Up 30 minutes             9093/tcp                                                                           alertmanager
406f77e19214   grafana/grafana:7.4.2              "/run.sh"                30 minutes ago   Up 30 minutes             3000/tcp                                                                           grafana
e9632e837d17   gcr.io/cadvisor/cadvisor:v0.47.0   "/usr/bin/cadvisor -…"   30 minutes ago   Up 30 minutes (healthy)   8080/tcp 
```

### 4. Задача
- Cкриншот работающего веб-интерфейса Grafana
<p align="center">
  <img width="800" height="600" src="./assets/yc_04.png">
</p>



