--CREATE TABLE NETFLIX
create table public."netflix"(
show_id VARCHAR(500) PRIMARY KEY,
"type" VARCHAR(500) NULL,
title TEXT NULL,
director VARCHAR(500) NULL,
"cast" TEXT NULL,
country VARCHAR(500) NULL,
"date_added" date NULL,
release_year INT4 NULL,
rating VARCHAR(500) NULL,
duration VARCHAR(500) NULL,
listed_in VARCHAR(500) NULL,
description TEXT NULL
);

--drop table "netflix";

--CREATE TABLE PERSON
CREATE TYPE job AS ENUM ('director', 'artist');
create type gender as enum ('male', 'female','unknow');

create table public."person"(
id SERIAL PRIMARY KEY,
"name" VARCHAR(100) NOT null UNIQUE,
"role" job,
"gender" gender
);

--drop table "person";

--CREATE RELATION TABLE

create table public."netflix_person"(
id_netflix VARCHAR(500),
id_person INT4,
FOREIGN KEY (id_Netflix) REFERENCES "netflix" ("show_id"),
FOREIGN KEY (id_Person) REFERENCES "person" ("id")
);

--drop table "netflix_person";

-- TESTE
INSERT INTO "person"  ("name","role")
VALUES ('Jorge Michel Grauxx', 'director');

--TESTE INTEGRAÇÃO KEYS
insert into "netflix_person" ("id_netflix", "id_person")
values ('s2', 1);
--TESTE
select * from "person" 
left join "petflix_person" on "netflix_person".id_person = "person".id
left join "netflix" ON "netflix".show_id = "netflix_person".id_netflix
where name like 'Jorge Michel Grau'
;

--valores faltantes
SELECT *
FROM netflix
WHERE show_id IS NULL
	OR "type" IS NULL
	OR title IS NULL
	OR director IS NULL
	OR "cast" IS NULL
	OR country IS NULL
	OR date_added IS NULL
	OR release_year IS NULL
	OR rating IS NULL
	OR duration IS NULL
	OR listed_in IS NULL
	OR description IS null
;

--total de valores válidos (sem erros e/ou faltantes em cada coluna)
SELECT
COUNT(*) AS total_rows,
COUNT(NULLIF(TRIM(show_id), '')) AS valid_show_id,
COUNT(NULLIF(TRIM("type"), '')) AS valid_type,
COUNT(NULLIF(TRIM(title), '')) AS valid_title,
COUNT(NULLIF(TRIM(director), '')) AS valid_director,
COUNT(NULLIF(TRIM("cast"), '')) AS valid_cast,
COUNT(NULLIF(TRIM(country), '')) AS valid_country,
COUNT(NULLIF(TRIM(to_char(date_added, 'YYYY-MM-DD'))::text, '')) AS valid_date_added,
COUNT(NULLIF(TRIM(to_char(release_year, 'YYYY'))::text, '')) AS valid_release_year,
COUNT(NULLIF(TRIM(rating), '')) AS valid_rating,
COUNT(NULLIF(TRIM(duration), '')) AS valid_duration,
COUNT(NULLIF(TRIM(listed_in), '')) AS valid_listed_in,
COUNT(NULLIF(TRIM(description), '')) AS valid_description
FROM netflix
;

--listar o nome que mais se repete
SELECT name, COUNT(*) AS count
FROM (
  SELECT regexp_split_to_table("cast", ', ') AS name
  FROM netflix
) AS t
WHERE name <> ''
GROUP BY name
ORDER BY count DESC
LIMIT 1
;

--Qual filme teve o maior intervalo de tempo desde o lançamento até aparecer na Netflix?
select title,(date_part('year', date_added) - release_year) AS interval_years
FROM 
  netflix
ORDER BY 
  interval_years DESC
LIMIT 1
;

--Qual ano teve o maior aumento ano sobre ano (em termos percentuais) para programas de TV?
WITH tv_shows AS (
  SELECT
    date_part('year', date_added) AS year,
    COUNT(*) AS total
  FROM
    netflix
  WHERE
    type = 'TV Show'
  GROUP BY
    date_part('year', date_added)
), 
tv_shows_percentage AS (
  SELECT
    t1.year,
    t1.total,
    t1.total / LAG(t1.total, 1) OVER(ORDER BY t1.year) AS percentage_increase
  FROM
    tv_shows t1
)
SELECT
  year
FROM
  tv_shows_percentage
WHERE
  percentage_increase = (SELECT MAX(percentage_increase) FROM tv_shows_percentage)
;

SELECT EXTRACT(MONTH FROM date_added) AS month, COUNT(*) AS num_of_additions
FROM netflix
GROUP BY month
ORDER BY num_of_additions DESC
LIMIT 1
;

--Mês com mais lançamentos. 
SELECT mode() WITHIN GROUP (ORDER BY EXTRACT(MONTH FROM date_added)) AS most_added_month
FROM netflix
WHERE type = 'TV Show';


--LIMPAR TABELA
delete from "person";

DELETE FROM netflix
WHERE show_id > (
  SELECT show_id
  FROM netflix
  ORDER BY show_id
  LIMIT 1 OFFSET 4
);


