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


/* (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае.
 Месяцы заданы в виде списка английских названий ('may', 'august') Я так и не смогла разобраться в том, какой должен быть синтаксис для получения списка. */

select * from users where DATE_FORMAT(birthday_at, '%m') in ('may', 'august');

/*(по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
Отсортируйте записи в порядке, заданном в списке IN */

select * from users WHERE id IN (5, 1, 2) order by FIELD(id, 5, 1, 2);


-- Подсчитайте средний возраст пользователей в таблице users

select round(avg(timestampdiff(YEAR, birthday_at, now())), 0) AS aver_age from users;

/* Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
Следует учесть, что необходимы дни недели текущего года, а не года рождения.*/

select date_format(date(CONCAT_WS('-', YEAR(NOW()), month(birthday_at), day(birthday_at))), '%W') as birthday,
count(*) as quantity
from users group by birthday order by quantity;
  



  


  
