# README

## SQL Task

Дана таблица users вида - id, group_id

```sql
CREATE TABLE users(id bigserial, group_id bigint);
INSERT INTO users(group_id) VALUES (1), (1), (1), (2), (1), (3); 
```

В этой таблице, упорядоченой по ID необходимо: 

1.    Выделить непрерывные группы по group_id с учетом указанного порядка записей (их 4) 

```sql
SELECT group_id, COUNT(id) AS group_total
FROM users
GROUP BY group_id ORDER BY group_id ASC;

group_id | group_total
----------+-------------
       1 |           4
       2 |           1
       3 |           1
(3 rows)
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
