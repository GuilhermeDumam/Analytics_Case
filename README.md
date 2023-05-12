# Analytics_Case
Teste para vaga de Engenheiro de Analytics na BRAVIUM

As etapas para construção do case foram iniciadas com a criação de uma imagem em `DOCKER`;
Criei um arquivo `.html` e um `dockerfile` contendo a imagem, criei o servidor/repositório, depois criei um `docker-compose` contendo o meu banco `PostegrSQL` 
e fiz a conexão com o banco pelo `Dbeaver`.

Dentro do `DBeaver`, manipulei meu banco, criando a tabela `Netflix` que recebe o `.csv` do desafio.
Crio as tabelas, o código se encontra no script `SQL` : `Script_Netflix.sql`.
Crio também outras duas tabelas, uma tabela contendo os valores do elenco e direção dos filmes/séries, e uma tabela intermediária
com os Ids das duas tabelas.
Precisei criar essas tabelas adicionais, pois para classificar os gêneros do elenco, precisava separar da tabela `netflix` onde os nomes estavam aglomerados.

Vou criando os scripts para resolução das perguntas do desafio e ao mesmo tempo colocando eles para rodarem no meu arquivo `main.py`.
Onde utilizo das bibliotecas `sqlalchemy + psycopg2` para fazer a conexão com o banco.

No arquivo `main.py`eu consigo manipular meu banco para conseguir conectar a `API` de classificação de gênero, e faço o looping para rodar em todos os dados inseridos nas tabelas.


##Passo 4##

--valores faltantes
`SELECT *
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
;`

--total de valores válidos (sem erros e/ou faltantes em cada coluna)
`SELECT
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
;`

##Passo 5##:

Qual é o nome mais comum entre atores e atrizes?
Anupam Kher

Qual filme teve o maior intervalo de tempo desde o lançamento até aparecer na Netflix?
A Young Doctor's Notebook and Other Stories

Qual mês do ano teve mais novos lançamentos historicamente?
12 (Dezembro)

Qual ano teve o maior aumento ano sobre ano (em termos percentuais) para programas de TV?
2016

Liste as atrizes que apareceram em um filme com Woody Harrelson mais de uma vez.
??????

Não consegui completar a lógica para rodar a API em todos os valores.

Passo 6: Combine todos os passos anteriores em um programa Python sólido que tenha teste unitário. Sinta-se à vontade para criar um arquivo principal que possa ser executado via linha de comando do Python.

Não consegui realizar a tempo `pytest` ou `unittest`. 

