# Проект Clickhouse + Vector + Lighthouse

## Функционал
Данный **playbook** развернет на инстансе **Clickhouse**, **Vector** и **lighthouse**, данная связка поможет в сборе логов, метрик и отображения собранной информации. В этой связке **Clickhouse** это **NoSQl** база данных, **Vector** необходим для обработки логов и метрик, а **Clickhouse**  поможет показать наши логи через web интерфейс.

## Запуск скрипта
```
ansible-playbook -i  <inventory-path>/prod.yml site.yml
```

## Tags (теги)
| Тег | Описание |
| :-----:|:-----:|
| `clickhouse` | Скачает и установит clickhouse нужной версии и создаст базу данных с таблицей |
| `vector` | Скачает и установит vector нужной версии, настроит vector используя файл конфигурации jinja2 из папки templates |
| `lighthouse` | Скачает и установит lighthouse, настроит lighthouse используя файл конфигурации lighthouse из папки templates, устанавливает и настраивает http сервер nginx |


Примеры запусков с использованием тега:
```
ansible-playbook -i  <inventory-path>/prod.yml site.yml --tags vector
```
```
ansible-playbook -i  <inventory-path>/prod.yml site.yml --tags clickhouse
```
```
ansible-playbook -i  <inventory-path>/prod.yml site.yml --tags lighthouse
```

## Tasks (задания)
Так же в данном playbook можно выполнять отдельно tasks (задания):
<br>

| Имя | Задание | Описание |
| :-----:| :-----:|:-----:|
|Clickhouse| `Get clickhouse distrib` | это задание скачает Clickhouse даст права на скаченные файлы, установит его, создаст базу данных, таблицу в ней и перезапустит службу. |
|Vector| `Get vector distrib` | это задание скачает Vector даст права на скаченные файлы, установит его и настроит vector используя файл конфигурации jinja2 из папки templates. |
|Lighthouse| `Lighthouse copy from git` | Скачает файлы lighthouse, и кладет их в папку которую будет обрабатывать nginx с определенными правами. |
|Nginx| `Nginx Install epel-release` | Скачает устанавливает и настраивает http сервер nginx. |


Примеры запусков с использованием tasks:
```
ansible-playbook -i  <inventory-path>/prod.yml site.yml --start-at-task 'Get clickhouse distrib'
```
```
ansible-playbook -i  <inventory-path>/prod.yml site.yml --start-at-task 'Get vector distrib'
```
```
ansible-playbook -i  <inventory-path>/prod.yml site.yml --start-at-task 'Lighthouse copy from git'
```
```
ansible-playbook -i  <inventory-path>/prod.yml site.yml --start-at-task 'Nginx Install epel-release'
```
