/* Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
Заполните их текущими датой и временем.
 */

update users set created_at = CURRENT_TIMESTAMP, updated_at = current_timestamp;

/* Таблица users была неудачно спроектирована. 
Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". 
Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения. */

alter table users 
   modify column created_at datetime,
   modify column updated_at datetime;
  
/* В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы.
Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
Однако, нулевые запасы должны выводиться в конце, после всех записей. */

select * from storehouses_products 
order by case value when value > 0 then value end asc,
case when value=0 then value end;


  