# Проект Clickhouse+Vector

## Функционал
Данный **playbook** развернет на инстансе **Clickhouse** и **Vector**, данная связка поможет в сборе логов и метрик. В этой связке **Clickhouse** это **NoSQl** база данных а **Vector** необходим для обработки логово и метрик.

## Запуск скрипта
```
ansible-playbook -i  <inventory-path>/prod.yml site.yml
```

## Tags (теги)
В данном playbook доступны следующие теги:
- `clickhouse` (Скачает и установит clickhouse нужной версии и создаст базу данных с таблицей)
- `vector` (Скачает и установит vector нужной версии, настроит vector используя файл конфигурации jinja2 из папки templates)


Примеры запусков с использованием тега:
```
ansible-playbook -i  <inventory-path>/prod.yml site.yml --tags vector
```
```
ansible-playbook -i  <inventory-path>/prod.yml site.yml --tags clickhouse
```

## Tasks (задания)
Так же в данном playbook можно выполнять отдельно tasks (задания):
<br>

`Get clickhouse distrib` - это задание скачает Clickhouse даст права на скаченные файлы, установит его, создаст базу данных, таблицу в ней и перезапустит службу.

`Get vector distrib` - это задание скачает Vector даст права на скаченные файлы, установит его и настроит vector используя файл конфигурации jinja2 из папки templates.


Примеры запусков с использованием tasks:
```
ansible-playbook -i  <inventory-path>/prod.yml site.yml --start-at-task 'Get clickhouse distrib'
```
```
ansible-playbook -i  <inventory-path>/prod.yml site.yml --list-tasks 'Get vector distrib'
```
