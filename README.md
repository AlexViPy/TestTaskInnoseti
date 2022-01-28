# test_innoseti
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


![Фото БД](https://github.com/AlexViPy/test_innoseti/raw/main/db_schema.png)
