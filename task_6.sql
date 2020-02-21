


/*Пусть задан некоторый пользователь.
 Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.*/


select * from friend_requests where (initiator_user_id = 1 
 or target_user_id = 1) and status = 'approved';



select count(*), from_user_id, to_user_id
from messages where (from_user_id = 1 and to_user_id in (3,10,4)) or (to_user_id = 1 and from_user_id in (3,10,4))
order by count(*) desc limit 1;

-- Тут я честно не понимаю, как вытащить id друга, чтобы получить его имя из users через вложенный запрос.

create view best_friend as select count(*), from_user_id, to_user_id
from messages where (from_user_id = 1 and to_user_id in (3,10,4)) or (to_user_id = 1 and from_user_id in (3,10,4))
order by count(*) desc limit 1;

select concat(firstname, ' ', lastname) from users where users.id = (select to_user_id from best_friend);



/*Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.*/
select sum(likes.minor_likes) as total_minor_likes from 
(select count(*) as minor_likes from likes 
where user_id in (select user_id from profiles where (TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10))) as likes;

/*Определить кто больше поставил лайков (всего) - мужчины или женщины?*/

select 
(select SUM(male.total)
from (select
(select count(id) from likes where likes.user_id = profiles.user_id) as total from profiles
where gender = 'm') as male) as men,	
(select SUM(female.total)
from    
(select
(select count(id) from likes 
where likes.user_id = profiles.user_id) as total
from profiles 
where gender = 'f') as female) as women;
