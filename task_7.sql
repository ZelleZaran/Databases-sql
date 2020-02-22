use shop

/*Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине. */

INSERT into orders (user_id) VALUES
  (6),
  (5),
  (5),
  (4),
  (1);

select concat(name, ' ', birthday_at) as clients from users where users.id in (select user_id from orders);

/* Выведите список товаров products и разделов catalogs, который соответствует товару. */


select * from products join catalogs using (id);


/*Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
 * Поля from, to и label содержат английские названия городов, поле name — русское. 
 Выведите список рейсов flights с русскими названиями городов.
 */
  
drop table if exists flights;
create table flights(
id serial primary key,
`from` varchar(25),
`to` varchar(25)) 
;
  
insert into flights (`from`,`to`) values

('moscow','omsk'),
('irkutsk','kazan'),
('irkutsk','moscow'),
('omsk','irkutsk'),
('moscow','kazan'),
('orsk','moscow');

drop table if exists cities;
create table cities(
label varchar(25),
name varchar(25), 
primary key (label, name))
;

insert into cities (label,name) values
('moscow','Москва'),
('irkutsk','Иркутск'),
('novgorod','Новгород'),
('kazan','Казань'),
('omsk','Омск'),
('orsk','Орск');



alter table flights
add constraint fk_from
foreign key (`from`)
references cities (label)
on delete cascade
on update cascade;

alter table flights
add constraint fk_to
foreign key (`to`)
references cities (label)
on delete cascade
on update cascade;


select a.name as `from`, b.name as `to`
from flights as c join cities a on a.label = c.`from`
inner join cities b on b.label = c.`to`
order by c.id
