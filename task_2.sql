/*2 Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name. */

drop database if exists example;
create database example;
use example
drop table if exists users;
CREATE TABLE users 
(
  id int unsigned not null primary key auto_increment,
  name varchar(100) default 'anonymous '
 );

/* 3. Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.*/

mysqldump example > sample.sql
mysql
use example
SOURCE sample.sql
/* или mysql example < sample.sql*/

/* 4(по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. Создайте дамп единственной таблицы help_keyword базы данных mysql. Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.*/

mysqldump mysql help_keyword --where="true limit 100" > newfile.sql




