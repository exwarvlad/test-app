# README

## Rails task

1. Создать пост. Принимает заголовок и содержание поста (не могут быть пустыми), а также логин и айпи автора. Если автора с таким логином еще нет, необходимо его создать. Возвращает либо атрибуты поста со статусом 200, либо ошибки валидации со статусом 422.

```bash
curl -H "Content-Type: application/json" -X POST -d  '{"post": {"title": "Post about nature", "description": "Nature is the capital of Great Britain", "ip_address": "128.127.22.44",    "user_login":"eugene.zhdanov"}}'     http://localhost:3000/posts
```

2. Поставить оценку посту. Принимает айди поста и значение, возвращает новый средний рейтинг поста. Важно: экшен должен
корректно отрабатывать при любом количестве конкурентных запросов на оценку одного и того же поста.

```bash
curl -H "Content-Type: application/json" -X POST -d  '{"rate": {"value": 5}  }' http://localhost:3000/posts/145000/rates
```

3. Получить топ N постов по среднему рейтингу. Просто массив объектов с заголовками и содержанием.
```bash
curl -H "Content-Type: application/json" -X GET -d  '{"page": "1", "per_page": "50" }' http://localhost:3000/posts/
```

## SQL Task

Дана таблица users вида - id, group_id

```sql
CREATE TABLE users(id bigserial, group_id bigint);
INSERT INTO users(group_id) VALUES (1), (1), (1), (2), (1), (3); 

id  | group_id
----+----------
  1 |        1
  2 |        1
  3 |        1
  4 |        2
  5 |        1
  6 |        3
```

В этой таблице, упорядоченой по ID необходимо: 

1.    Выделить непрерывные группы по group_id с учетом указанного порядка записей (их 4) 

```sql
SELECT group_id FROM (
   SELECT
     CASE
       WHEN group_id = LAG(group_id) OVER (ORDER BY id)
         THEN NULL
         ELSE group_id
       END
       AS group_id FROM users
   ) AS result
 WHERE result IS NOT NULL;

 group_id
----------
        1
        2
        1
        3
(4 rows)
```

2.    Подсчитать количество записей в каждой группе 
```sql
SELECT group_id, COUNT(group_id) AS group_total
FROM users
GROUP BY group_id;

group_id | group_total
---------+-------------
       1 |           4
       3 |           1
       2 |           1
(3 rows)
```

3.   Вычислить минимальный ID записи в группе

```sql
SELECT group_id, MIN(id) AS min_id
FROM users
GROUP BY group_id;

group_id | min_id
---------+--------
       1 |      1
       3 |      6
       2 |      4
(3 rows)
```
