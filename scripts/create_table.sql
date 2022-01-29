create table dim_accounts as (
select account_number as account_number_id, account_data, comment_to_the_account, account_issued, payer
from stg_test_ansi sta group by 1,2,3,4,5
);
alter table dim_accounts add constraint account_number_id_pk primary key (account_number_id);


create table dim_products as (
select product_name, product_code, product_counts, unit_price
from stg_test_ansi sta 
);
alter table dim_products add column product_id serial primary key;


create table dim_resp_employees as (
select responsible_employee, planned_payment_date, planned_delivery_date 
from stg_test_ansi sta group by 1, 2, 3
);
alter table dim_resp_employees add column responsible_employee_id serial primary key;


create table dim_authors as (
select author 
from stg_test_ansi sta group by 1
);
alter table dim_authors add column author_id serial primary key;

create table f_ansi as (
select 
	sta.account_number account_number_id
	, da2.author_id
	, dre.responsible_employee_id
	, dp.product_id 
from stg_test_ansi sta 
join dim_accounts da on sta.account_number = da.account_number_id 
join dim_authors da2 on sta.author = da2.author
join dim_resp_employees dre on sta.responsible_employee = dre.responsible_employee 
join dim_products dp on sta.product_name = dp.product_name 
);

alter table f_ansi add  constraint account_number_id_fk FOREIGN KEY (account_number_id) REFERENCES dim_accounts (account_number_id) ON DELETE CASCADE;
alter table f_ansi add  constraint author_id_fk FOREIGN KEY (author_id) REFERENCES dim_authors (author_id) ON DELETE CASCADE;
alter table f_ansi add  constraint responsible_employee_id_fk FOREIGN KEY (responsible_employee_id) REFERENCES dim_resp_employees (responsible_employee_id) ON DELETE CASCADE;
alter table f_ansi add  constraint product_id_fk FOREIGN KEY (product_id) REFERENCES dim_products (product_id) ON DELETE CASCADE;