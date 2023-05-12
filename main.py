#importando bibliotecas e módulos
from sqlalchemy import create_engine, text
import psycopg2
import pandas as pd
from datetime import datetime
import requests

#configurando o acesso ao banco
user = 'root'
password = 'root'
host = 'localhost'
port = '5432'
db = 'netflix_db'

#montando a engine que vai se conectar ao banco.
connection_string = f'postgresql+psycopg2://{user}:{password}@{host}:{port}/{db}'
engine = create_engine(connection_string)
conn = engine.connect()

#listando os valores faltantes
missing_values = conn.execute("SELECT * FROM netflix WHERE show_id IS NULL OR type IS NULL OR title IS NULL OR director IS NULL OR 'cast' IS NULL OR country IS NULL OR date_added IS NULL OR release_year IS NULL OR rating IS NULL OR duration IS NULL OR listed_in IS NULL OR description IS NULL;")

#aqui é contabilizado o total de linhas de cada coluna, se for nulo ou tiver valor inválido (erro) decrescerá no valor total de linhas.
invalid_data = conn.execute("SELECT COUNT(*) AS total_rows, COUNT(NULLIF(TRIM(show_id), '')) AS valid_show_id, COUNT(NULLIF(TRIM(type), '')) AS valid_type, COUNT(NULLIF(TRIM(title), '')) AS valid_title, COUNT(NULLIF(TRIM(director), '')) AS valid_director, COUNT(NULLIF(TRIM('cast'), '')) AS valid_cast, COUNT(NULLIF(TRIM(country), '')) AS valid_country, COUNT(NULLIF(TRIM(to_char(date_added, 'YYYY-MM-DD'))::text, '')) AS valid_date_added, COUNT(NULLIF(TRIM(to_char(release_year, 'YYYY'))::text, '')) AS valid_release_year, COUNT(NULLIF(TRIM(rating), '')) AS valid_rating, COUNT(NULLIF(TRIM(duration), '')) AS valid_duration, COUNT(NULLIF(TRIM(listed_in), '')) AS valid_listed_in, COUNT(NULLIF(TRIM(description), '')) AS valid_description FROM netflix;")

#Maior filme com diferença de data até entrar na netflix
diff_time = conn.execute("select title,(date_part('year', date_added) - release_year) AS interval_years FROM netflix ORDER BY interval_years DESC LIMIT 1;")

#mês com mais lançamentos
most_added_month = conn.execute("SELECT mode() WITHIN GROUP (ORDER BY EXTRACT(MONTH FROM date_added)) AS most_added_month FROM netflix WHERE type = 'TV Show'");


#Ano que teve maior aumento percentual para programas de TV
percentage_year = conn.execute("WITH tv_shows AS (SELECT date_part('year', date_added) AS year, COUNT(*) AS total FROM netflix WHERE type = 'TV Show' GROUP BY date_part('year', date_added)), tv_shows_percentage AS (SELECT t1.year, t1.total, t1.total / LAG(t1.total, 1) OVER(ORDER BY t1.year) AS percentage_increase FROM tv_shows t1) SELECT year FROM tv_shows_percentage WHERE percentage_increase = (SELECT MAX(percentage_increase) FROM tv_shows_percentage)");


#EXTRAIR A API PARA CLASSIFICAR OS GENÊROS DOS ATORES/ATRIZES.
#PRIMEIRA ETAPA É CRIAR TABELAS SEPARADAS COM OS VALORES DE ATORES/ATRIZES E DIRETORES (POIS O MESMO PODE TAMBÉM SER ATOR).
sql_text = text("SELECT * FROM netflix")
result_set = conn.execute(sql_text)

for r in result_set.all():
    directors = r[3].split(",")  
    cast = r[4].split(",")
    for j in directors:
        j = j.strip()
        if j != "":
        # text1 = (f"INSERT INTO person  (name,role) VALUES ({j}, director)")
            result = conn.execute(f"INSERT INTO person  (name,role) VALUES ('{j}', 'director')")
            print(result)
            text1 = ("INSERT INTO netflix_person  (id_netflix,id_person) VALUES ('{r[0]}', {result[id]})")
            conn.execute(text1)
    for k in cast:
        k = k.strip()
        if k != "":
            result1 = conn.execute(f"INSERT INTO person  (name,role) VALUES ('{k}', 'artist')")
            text2 = ("INSERT INTO netflix_person  (id_netflix,id_person) VALUES ('{r.show_id}', {result1[id]})")
            conn.execute(text2)
        
gender_text = text("SELECT * FROM person")
gender_classification = conn.execute(gender_text)
for r in gender_classification:
     url = 'https://innovaapi.aminer.cn/tools/v1/predict/gender?name=r.name'
     response = requests.get(url)
     data = response.json()
     conn.execute("UPDATE person (role) VALUES ({data.x}) where id = {r.id}")
