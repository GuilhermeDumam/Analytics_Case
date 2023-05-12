# Analytics_Case
Teste para vaga de Engenheiro de Analytics na BRAVIUM

As etapas para construção do case foram:

Criei um arquivo `.html`, um `dockerfile` e um `docker-compose` contendo a conexão com o meu banco PostgreSQL; a conexão foi conectada pelo `Dbeaver`.

Dentro do `DBeaver`, manipulei meu banco, criando a tabela `Netflix` que recebe o `.csv` do desafio.

Crio também outras duas tabelas, uma tabela contendo os valores do elenco e direção dos filmes/séries, e uma tabela intermediária
com os Ids (chaves) das duas tabelas.

Precisei criar essas tabelas adicionais, pois para classificar os gêneros do elenco, precisava separar da tabela `netflix` onde os nomes do elenco estavam aglomerados em apenas uma coluna, seria difícil da API conseguir classificar os gêneros pelos nomes todos juntos.

Vou criando os scripts para resolução das perguntas do desafio e ao mesmo tempo colocando eles para rodarem no meu arquivo `main.py`.
Onde utilizo das bibliotecas `sqlalchemy + psycopg2` para fazer a conexão com o banco.

No arquivo `main.py`eu consigo manipular meu banco para conseguir conectar a `API` de classificação de gênero, e faço o looping para rodar em todos os dados inseridos nas tabelas.


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

