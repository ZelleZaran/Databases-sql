/* 1 Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, задав в нем логин и пароль, который указывался при установке.*/

student@Ubuntu-MySQL-VirtualBox:~$ mysql -u root -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 7
Server version: 5.7.25-0ubuntu0.16.04.2 (Ubuntu)

Copyright (c) 2000, 2019, Oracle and/or its affiliates. All rights reserved.

mysql> /q

student@Ubuntu-MySQL-VirtualBox:~$ nano .my.cnf
student@Ubuntu-MySQL-VirtualBox:~$ cat .my.cnf
[mysql]
user=root
password=master



/*2 Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name. */

CREATE DATABASE example;

SHOW VARIABLES LIKE 'datadir';

/* student@Ubuntu-MySQL-VirtualBox:~$ sudo chmod o+rwsx /var/lib/mysql/
student@Ubuntu-MySQL-VirtualBox:/var/lib/mysql$ cd example
bash: cd: example: Отказано в доступе
student@Ubuntu-MySQL-VirtualBox:/var/lib/mysql$ sudo chmod o+rwsx example
student@Ubuntu-MySQL-VirtualBox:/var/lib/mysql$ cd example
student@Ubuntu-MySQL-VirtualBox:/var/lib/mysql/example$ */

use example
DROP TABLE IF EXISTS users;
CREATE TABLE users 
(
  id int,
  name varchar(100)
 ); 


/* 3. Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.*/

mysqldump example > sample.sql

mysql

use example
SOURCE sample.sql


/* 4(по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. Создайте дамп единственной таблицы help_keyword базы данных mysql. Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.*/

student@Ubuntu-MySQL-VirtualBox:~$ mysqldump mysql help_keyword --where="true limit 100" > newfile.sql




