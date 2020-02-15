-- ii. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке



use vk

select distinct firstname from users
order by firstname;


-- iii. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false). Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)
use vk

alter table profiles 
add is_active varchar(10) not null
default('true');

update profiles set is_active='false'
where birthday < '2002-01-01';

-- iv. Написать скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней)

delete from messages 
where created_at > CAST(CURRENT_TIMESTAMP AS DATE);
