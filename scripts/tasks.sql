--1. Получить количество счетов по каждому ответственному сотруднику:

select 
	responsible_employee
	, count(account_number_id) as accounts_count_for_employee
from f_ansi join dim_resp_employees dre using (responsible_employee_id)
group by 1

--2. Получить ТОП 3 самых популярных по количеству в выставленных счетах товаров за июнь 2020 года:

with products as (
select 
	product_name
	, product_counts
from f_ansi join dim_products on f_ansi.product_id = dim_products.product_id
join dim_accounts on f_ansi.account_number_id = dim_accounts.account_number_id  
where account_issued = 'Да'
and account_data between '2020-06-01' and '2020-06-30'
order by 2 desc limit 3
)
select product_name from products

--3. Получить ТОП 3 самых непопулярных по количеству в выставленных счетах товаров за июнь 2020 года:

with products as (
select 
	product_name
	, product_counts
from f_ansi join dim_products on f_ansi.product_id = dim_products.product_id
join dim_accounts on f_ansi.account_number_id = dim_accounts.account_number_id  
where account_issued = 'Да'
and account_data between '2020-06-01' and '2020-06-30'
order by 2 asc limit 3
)
select product_name from products

--4. Получить сумму по всем товарам во всех счетах, где встречается "Виртуальный_товар_1":

select
	sum(unit_price) price
from f_ansi join dim_products on f_ansi.product_id = dim_products.product_id
join dim_accounts on f_ansi.account_number_id = dim_accounts.account_number_id
where product_name = 'Виртуальный_товар_1'

--5. Получить всех ответственных сотрудников по всем счетам, где встречается "Виртуальный_товар_1":

select
	responsible_employee 
from f_ansi join dim_products on f_ansi.product_id = dim_products.product_id
join dim_resp_employees on f_ansi.responsible_employee_id = dim_resp_employees.responsible_employee_id
where product_name = 'Виртуальный_товар_1'

--6. Получить количество счетов в разрезе каждого месяца и года, упорядочить по возрастанию периода:

select
	count(*) over (partition by date_part('month', account_data::date) order by 1 asc) month_counts,
	count(*) over (partition by date_part('year', account_data::date) order by 1 asc) year_counts
from f_ansi join dim_products on f_ansi.product_id = dim_products.product_id
join dim_accounts on f_ansi.account_number_id = dim_accounts.account_number_id

--7. Удалить все не выставленные счета:

delete from dim_accounts where account_issued = 'Нет';
select * from f_ansi;

--8. Увеличить цену товара «Виртуальный_товар_6» в 2 раза, в каждом счете, где ответственным сотрудником является "Сотрудник_5":

update dim_products 
	set unit_price = sq.unit_price*2
from (select 
		unit_price
from f_ansi join dim_products on f_ansi.product_id = dim_products.product_id
join dim_resp_employees on f_ansi.responsible_employee_id = dim_resp_employees.responsible_employee_id
where product_name = 'Виртуальный_товар_6' and responsible_employee='Сотрудник_5') sq
where product_name = 'Виртуальный_товар_6';