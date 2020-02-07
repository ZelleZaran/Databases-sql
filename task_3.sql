DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY, 
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамилия', 
    email VARCHAR(120) UNIQUE,
    phone BIGINT, 
    INDEX users_phone_idx(phone),
    INDEX users_firstname_lastname_idx(firstname, lastname)
);

DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
	user_id SERIAL PRIMARY KEY,
    gender CHAR(1),
    birthday DATE,
	photo_id BIGINT UNSIGNED NULL,
    created_at DATETIME DEFAULT NOW(),
    hometown VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(id) 
    	ON UPDATE CASCADE 
    	ON DELETE restrict 
);

DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(), -- можно будет даже не упоминать это поле при вставке
    INDEX messages_from_user_id (from_user_id),
    INDEX messages_to_user_id (to_user_id),
    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests (
	-- id SERIAL PRIMARY KEY, -- изменили на композитный ключ (initiator_user_id, target_user_id)
	initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
   
    `status` ENUM('requested', 'approved', 'unfriended', 'declined'),
    
	requested_at DATETIME DEFAULT NOW(),
	confirmed_at DATETIME,
	
    PRIMARY KEY (initiator_user_id, target_user_id),
	INDEX (initiator_user_id), 
    INDEX (target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id),
    FOREIGN KEY (target_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS communities;
CREATE TABLE communities(
	id SERIAL PRIMARY KEY,
	name VARCHAR(150),

	INDEX communities_name_idx(name)
);

DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities(
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
  
	PRIMARY KEY (user_id, community_id), 
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (community_id) REFERENCES communities(id)
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
	id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

   
);

DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL PRIMARY KEY,
    media_type_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
  	body text,
    filename VARCHAR(255),
    size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX (user_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
);

DROP TABLE IF EXISTS likes;
CREATE TABLE likes(
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_id) REFERENCES media(id)

);

DROP TABLE IF EXISTS `photo_albums`;
CREATE TABLE `photo_albums` (
	`id` SERIAL,
	`name` varchar(255) DEFAULT NULL,
    `user_id` BIGINT UNSIGNED DEFAULT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
  	PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `photos`;
CREATE TABLE `photos` (
	id SERIAL PRIMARY KEY,
	`album_id` BIGINT unsigned NOT NULL,
	`media_id` BIGINT unsigned NOT NULL,

	FOREIGN KEY (album_id) REFERENCES photo_albums(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

/*Практическое задание по теме “Введение в проектирование БД”
Написать крипт, добавляющий в БД vk, которую создали на занятии, 3 новые таблицы (с перечнем полей, указанием индексов и внешних ключей)*/

-- 1. Подарки. Сейчас в вк уже нет этого функионала, но я все-таки решила сделать таблицу.

drop table if exists get_gift;
create table get_gift(
      id SERIAL PRIMARY KEY,
      gift_name VARCHAR(100),
      gift JSON,
      `category` ENUM('birthday','new_year','flowers', 'hearts', 'other'),
      price DECIMAL(8,2),
      
      index (gift_name)
);


drop table if exists gifts;
create table gifts(
     giver_user_id BIGINT unsigned NOT null,
     reciever_user_id BIGINT unsigned NOT null,
     gift_id BIGINT unsigned NOT null,
     giving_date DATETIME default now(),
     
     PRIMARY KEY (giver_user_id, reciever_user_id),
     
     FOREIGN KEY (giver_user_id) REFERENCES users(id),
     FOREIGN KEY (reciever_user_id) REFERENCES users(id),
     FOREIGN KEY (gift_id) REFERENCES get_gift(id)
);

-- 2. Игры

drop table if exists get_game;
create table get_game(
     id SERIAL PRIMARY key,
     `genre` ENUM('shooter', 'quest', 'races', 'logic_games', 'RPG', 'sims', 'other'),
     game_name VARCHAR(100),
     describtion text,
     game_app JSON,
     created_at DATETIME default now(),
     updated_at DATETIME default null,
     community_id BIGINT unsigned NOT null,
     
     FOREIGN KEY (community_id) REFERENCES communities(id),
     index (game_name)
);



drop table if exists games;
create table games(
     user_id SERIAL,
     game_id BIGINT unsigned NOT null,
     score INT default null,
    
     
     PRIMARY KEY (user_id, game_id),
     
     FOREIGN KEY (user_id) REFERENCES users(id),
     FOREIGN KEY (game_id) REFERENCES get_game(id)  
);


-- 3. Товары.

drop table if exists merchandise_categories;
create table merchandise_categories(
      id SERIAL,
      category_name VARCHAR(100),
      primary key (id, category_name),
      index (category_name)
);      



drop table if exists merchandise;
create table merchandise(
      user_id SERIAL primary key,
      `category` VARCHAR(100),
      name varchar(100),
      describtion text,
      photo_id BIGINT unsigned NOT null,
      price DECIMAL(10,2),
      address VARCHAR(500),
      phone_id BIGINT,
      
      FOREIGN KEY (user_id) REFERENCES users(id),
      FOREIGN KEY (photo_id) REFERENCES photos(id),
      FOREIGN KEY (phone_id) REFERENCES users(phone),
      FOREIGN KEY (`category`) REFERENCES merchandise_categories(category_name)
);
