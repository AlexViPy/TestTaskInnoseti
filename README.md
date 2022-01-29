![Инносети](https://github.com/AlexViPy/test_innoseti/raw/main/img/label.jpeg)
Тестовое задание для организации "Инносети"

Для того, чтобы развернуть такое же окружение на своей машине необходимо:

1. Склонировать репозиторий к себе
2. Запустить PostgreSql командой:
```
docker-compose up
```
3. Сделать и запустить виртуальное окружение python:
```
python3 venv venv
source venv/bin/activate
```
4. Установить необходимые зависимости:
```
pip install -r requirements.txt
```

После того как развернули окружение:

1. В соотвествии с тестовым заданием необходимо создать БД и загрузить в нее данные в формате csv, для этого выподняем команду (все запросы выполнялись в БД test_ansi):
```
python3 upload_raw_data.py data/счета_ansi.csv test_ansi
```
Сырые данные сохраняются в таблицу stg_test_ansi.

В соответствии с заданием необходимо было привести БД к 3 НФ. Необходимые требования к 3 НФ:
- соблюдение требований 1НФ и 2НФ;
- отсутствие транзитивной зависимости;

Исходя из требований посчитал необходимым разделить таблицу на 4 сущности (справочника):
- dim_accounts (информация по счетам)
- dim_authors (информация по автору)
- dim_resp_employees (информация по ответственному сотруднику)
- dim_products (информация по продукту)

Тем самым получается стандартная схема "звезды", которая представлена на схеме:

![Фото БД](https://github.com/AlexViPy/test_innoseti/raw/main/img/db_schema.png)

- :white_check_mark: Скрипт по созданию таблиц - [create_tables.sql](https://github.com/AlexViPy/test_innoseti/blob/main/scripts/create_table.sql)
- :white_check_mark: Выполненные задания по sql - [tasks.sql](https://github.com/AlexViPy/test_innoseti/blob/main/scripts/tasks.sql)

