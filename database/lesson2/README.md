# SQL

### Задание 2
- Cоздайте пользователя test-admin-user и БД test_db

```
psql -h localhost -p 5432 -U padmin -W

CREATE ROLE "test-admin-user" LOGIN SUPERUSER PASSWORD 'pass';
CREATE DATABASE test_db;
```
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже);

```
CREATE TABLE IF NOT EXISTS orders(
    id          serial PRIMARY KEY,
    name        varchar(200) NOT NULL,
    price       INTEGER
);

CREATE TABLE IF NOT EXISTS clients(
    id                   serial PRIMARY KEY,
    surname              varchar(30) NOT NULL,
    country_of_residence varchar(30) NOT NULL,
    order_number         integer REFERENCES orders
);
```

- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db;
```
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO test-admin-user;
```

- создайте пользователя test-simple-user;
```
CREATE ROLE "test-simple-user" LOGIN PASSWORD 'pass';
```

- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE этих таблиц БД test_db
```
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO "test-simple-user";
```

### Задание 3
- Используя SQL-синтаксис, наполните таблицы следующими тестовыми данными:

```
INSERT INTO 
    orders (name,price) 
VALUES
    ('Шоколад',10),
    ('Принтер',3000),
    ('Книга',500),
    ('Монитор',7000),
    ('Гитара',4000);
INSERT 0 5

INSERT INTO 
    clients (surname,country_of_residence) 
VALUES
    ('Иванов Иван Иванович','USA'),
    ('Петров Петр Петрович','Canada'),
    ('Иоганн Себастьян Бах','Japan'),
    ('Ронни Джеймс Дио','Russia'),
    ('Ritchie Blackmore','Russia');
INSERT 0 5
```

- вычислите количество записей для каждой таблицы.
```
SELECT count(*) FROM orders;
SELECT count(*) FROM clients;
```

### Задание 4
- Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

```
UPDATE clients
SET order_number = (SELECT id FROM orders WHERE name = 'Монитор')
WHERE surname = 'Петров Петр Петрович';
UPDATE clients
SET order_number = (SELECT id FROM orders WHERE name = 'Гитара')
WHERE surname = 'Иоганн Себастьян Бах';
UPDATE clients
SET order_number = (SELECT id FROM orders WHERE name = 'Книга')
WHERE surname = 'Иванов Иван Иванович';
```

### Задание 5
- Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 (используя директиву EXPLAIN).
```
EXPLAIN SELECT * FROM clients WHERE order_number IS NOT NULL;
```

### Задание 6
- Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов
```
docker exec  postgres12 pg_dump -U padmin test_db > ~/test_db_dump.xml
```
- Поднимите новый пустой контейнер с PostgreSQL. Восстановите БД test_db в новом контейнере.

```
CREATE DATABASE test_db;
CREATE ROLE "test-admin-user" LOGIN SUPERUSER PASSWORD 'pass';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO "test-admin-user";
CREATE ROLE "test-simple-user" LOGIN PASSWORD 'pass';
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO "test-simple-user";
psql -U padmin test_db -f /opt/test_db_dump.xml
```

