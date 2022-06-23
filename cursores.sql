1) Criar uma tabela aluno com os campos codigo, nome, nota1, nota2, qtdefaltas e qtdeaulas inserir 
5 registros na tabela e mostrar com uso de cursor todos os nomes dos alunos, e se a nota1 mais 
nota2 divido por dois é maior ou igual a 6 mostrar aprovado, se menor de quatro reprovado, senão 
recuperação. Também verificar se o aluno não está reprovado por falta com a seguinte regra a 
quantidade de falta for maior que 20% da quantidade de aulas o aluno está reprovado por falta. 
CREATE TABLE ALUNO 
( COD INT PRIMARY KEY, 
NOME VARCHAR(30), 
NOTA1 NUMERIC(3,1), 
NOTA2 NUMERIC(3,1), 
QTDEFALTA INT, 
QTDEAULA INT 
) 
INSERT INTO ALUNO VALUES(1, 'ANA PAULA', 8, 7,1,100) 
INSERT INTO ALUNO VALUES(2, 'MARIA', 6, 4,5,100) 
INSERT INTO ALUNO VALUES(3, 'MARIO', 6, 8,2,100) 
INSERT INTO ALUNO VALUES(4, 'SALETE', 3, 7,10,100) 
INSERT INTO ALUNO VALUES(5, 'ANTONIO', 3, 3,30,100)

---------DECLARAR CURSOR (campos) ----------
declare aluno_cursor cursor for
select cod, nome, nota1, nota2, qtdefalta, qtdeaula from aluno

---------ABERTURA DO CURSOR-----------------
open aluo_cursor

---------DECLARAR VARIÁVEIS AUXILIARES-------
declare @cod int
declare @nome varchar(30)
declare @nota1 numeric(3,1)
declare @nota2 numeric(3,1)
declare @qtdefalta int
declare @qtdeaula int
declare @resu varchar(20)
fetch next from aluno_cursor into @cod, @nome, @nota1, @nota2, @qtdefalta, @qtdeaula

--------LAÇO DE REPETIÇÃO-----------------
while @@fetch_status = 0
begin
if ((@nota1+nota2)/2) >= 6
begin
set @resu = 'APROVADO'
end
else if ((@nota1+nota2)/2) < 4
begin
set @resu = 'REPROVADO'
end
else
begin
set @resu = 'RECUPERAÇÃO'
end
print 'ALUNO =' + @nome
print 'MEDIA =' + cast ((@nota1+@nota2)/2) as varchar --cast converte nota para string
print 'RESULTADO =' + @resu
if @qtdefalta > ((@qtdeaula * 20)/100)
print 'REPROVADO POR FALTA'
print '----------------------------------'
fetch next from aluno_cursor into @cod, @nome, @nota1, @nota2, @qtdefalta, @qtdeaula
end

------------FECHA O CURSOR----------------
close aluno_cursor


-----------------------------------------------------------------------------------------------
2) Criar uma tabela produto com os campos codigo, nome, UF, cidade, valor, percentual ICMS e 
percentual de IPI, inserir 5 registros na tabela e mostrar com uso de cursor todos os produtos da 
UF SP, PR, SC o nome o valor e os percentuais de ICMS e IPI, bem como os respectivos valores 
(valor multiplicado pelo percentual de ICMS e IPI). No final apresentar o valor total dos produtos e 
os valores totais de ICMS e IPI. 
CREATE TABLE PRODUTO 
( CODIGO INT NOT NULL PRIMARY KEY, 
NOME VARCHAR(50), 
UF VARCHAR(2), 
CIDADE VARCHAR(30), 
VALOR NUMERIC(12,2), 
ICMS NUMERIC(5,2), 
IPI NUMERIC(5,2) 
) 
INSERT INTO PRODUTO VALUES(10,'MOUSE', 'PR','CURITIBA',125,5,10) 
INSERT INTO PRODUTO VALUES(20,'CPU', 'PR','CURITIBA',1215,15,8) 
INSERT INTO PRODUTO VALUES(30,'TECLADO', 'BA','CENTRO',135,7,17) 
INSERT INTO PRODUTO VALUES(40,'MONITOR', 'SP','ITU',515,18,10) 
INSERT INTO PRODUTO VALUES(50,'IMPRESSORA', 'SC','CENTRO',825,7,12) 

----------------------DECLARAR O CURSOR--------------------------
declare produto_cursor cursor for
select codigo, nome, uf, cidade, valor, icms, ipi from produto
where uf in ('SP', 'PR', 'SC')

----------------------ABERTURA DO CURSOR-------------------------
open produto_cursor
declare @codigo int
declare @nome varchar(50)
declare @uf varchar(2)
declare @cidade varchar(30)
declare @valor numeric(12,2)
declare @icms numeric(5,2)
declare @ipi numeric(5,2)
declare @total numeric(12,2)
declare @vtotal numeric(12,2)
declare @vtotipi numeric(12,2)
declare @vtoticm numeric(12,2)
set @vtotal = 0
set @vtoticm = 0
set @vtotipi = 0
-----------------------------------------------------------------------------------------------

3) Criar uma tabela Tbaluno com os campos codigo, nome, sexo, UF, cidade, nota1, nota2, curso, 
mensalidade inserir 5 registros na tabela e mostrar com uso de cursor quantos alunos são de cada 
curso e quantos são mulheres e homens, bem como o valor total das mensalidades dos alunos por 
curso. Para os alunos que tem média acima 8 conceder um desconto de 10% na mensalidade. 
CREATE TABLE TBALUNO 
( CODIGO INT NOT NULL PRIMARY KEY, 
NOME VARCHAR(40), 
SEXO VARCHAR(1), 
UF VARCHAR(2), 
CIDADE VARCHAR(30), 
NOTA1 NUMERIC(5,2), 
NOTA2 NUMERIC(5,2), 
CURSO VARCHAR(3), 
MENSALIDADE NUMERIC(12,2) 
) 
INSERT INTO ALUNO VALUES (11,'PAULO','M','PR','CURITIBA',8,6,'ADS',485) 
INSERT INTO ALUNO VALUES (12,'MARIA','F','MG','CENTRO',8,9,'ADM',685) 
INSERT INTO ALUNO VALUES (13,'ANTONIO','M','SP','OSASCO',6,3,'ADS',485) 
INSERT INTO ALUNO VALUES (14,'SALETE','F','PR','CURITIBA',5,7,'ENG',995) 
INSERT INTO ALUNO VALUES (15,'JULIANO','M','SC','ITAJAI',4,6,'ADM',685) 
----------------------------------------------------------------------------------------------

4) A partir das tabelas departamento e funcionário faça o relacionamento e desenvolva usando 
cursor em programa em PL/SQL que mostre o nome do funcionário, departamento, salário total, 
valor de FGTS e Valor do INSS, no final apresentar o total geral do salário, do FGTS e INSS, apenas 
dos departamentos 3 e 2, cuja a quantidade de horas seja maior que 200 e menor que 360 e o mês 
referente a data seja 2 e 4 apenas. 
CREATE TABLE DEPARTAMENTO 
( 
DEPTO_COD INT PRIMARY KEY IDENTITY(1,1), 
DEPTO_NOME VARCHAR(40), 
DEPTO_QTDE_HORAS INT 
) 
CREATE TABLE FUNCIONARIO 
( 
FUNC_MAT INT PRIMARY KEY IDENTITY(10,10), 
FUNC_NOME VARCHAR(40), 
FUNC_DEPTO INT FOREIGN KEY REFERENCES DEPARTAMENTO(DEPTO_COD), 
FUNC_SALARIO_HORA NUMERIC(12,2), 
FUNC_DATA DATE, 
FUNC_FGTS INT, 
FUNC_INSS INT 
) 
INSERT INTO DEPARTAMENTO VALUES ('COMPRAS',200) 
INSERT INTO DEPARTAMENTO VALUES ('RH',220) 
INSERT INTO DEPARTAMENTO VALUES ('TI',240) 
INSERT INTO FUNCIONARIO VALUES ('PEDRO',3,10.5,'01-04-2020',5,17) 
INSERT INTO FUNCIONARIO VALUES ('JOAO',2,12.3,'15-03-2020',8,8) 
INSERT INTO FUNCIONARIO VALUES ('MANUEL',2,16.8,'22-02-2020',7,15) 
INSERT INTO FUNCIONARIO VALUES ('PATRICIA',1,20.7,'27-03-2020',4,7) 
INSERT INTO FUNCIONARIO VALUES ('SALETE',3,18.8,'12-04-2020',10,12)