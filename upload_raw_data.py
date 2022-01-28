from sys import argv
import logging
import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy_utils import database_exists, create_database

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
)

script, data_path, db_name = argv

def upload_raw_data(data_path: str, db_name: str):
    df = pd.read_csv(data_path, sep=';', encoding='windows-1251')
    df.rename(columns = {'Номер_Счета': 'account_number',
                         'Дата_Счета': 'account_data',
                         'Комментарий_к_счету': 'comment_to_the_account',
                         'Счет_выставлен': 'account_issued',
                         'Плательщик': 'payer',
                         'Автор': 'author',
                         'Отвественный_сотрудник': 'responsible_employee',
                         'Плановая_дата_оплаты': 'planned_payment_date',
                         'Плановая_дата_поставки': 'planned_delivery_date',
                         'Наименование_товара': 'product_name',
                         'Код_товара': 'product_code',
                         'Количество_товара': 'product_counts',
                         'Цена_за_единицу_товара': 'unit_price'}, inplace=True)
    engine = create_engine(f'postgresql://postgres:password@localhost:15432/{db_name}')
    
    if not database_exists(engine.url):
        logging.info(f'Create DB {db_name}')
        create_database(engine.url)
    
    logging.info('Upload to PostgreSQL')
    try:
        df.to_sql('stg_test_ansi', engine, if_exists='replace', index=False)
    except Exception as error:
        logging.warning('Data not loaded, please look at the error: %s', error)
    logging.info('Data uploaded successfully')


if __name__ == '__main__':
    upload_raw_data(data_path, db_name)