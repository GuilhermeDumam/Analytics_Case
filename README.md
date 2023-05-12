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
