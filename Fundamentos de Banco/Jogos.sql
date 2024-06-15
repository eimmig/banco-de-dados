DROP TABLE IF EXISTS resultados;
DROP TABLE IF EXISTS jogadores_partidas;
DROP TABLE IF EXISTS partidas;
DROP TABLE IF EXISTS jogadores;
DROP TABLE IF EXISTS times;
DROP TABLE IF EXISTS posicoes;
DROP TABLE IF EXISTS cidades;
DROP TABLE IF EXISTS estados;

DROP TYPE IF EXISTS salario;
DROP TYPE IF EXISTS sigla;
go

--Exercicio 1
CREATE TYPE salario 
FROM decimal(10, 2) not null;

CREATE TYPE sigla
FROM char(2) not null;
go

--Exercicio 2
CREATE TABLE estados(
	id_estados int not null identity primary key,

	NomeEstado varchar(50) not null,
	SiglaEstado sigla CHECK(SiglaEstado IN ('AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG',
						    'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS',	'RO', 'RR', 'SC', 'SP', 'SE', 'TO')),
);

CREATE TABLE cidades(
	id_cidades int not null identity primary key,

	NomeCidade varchar(50) not null,

	id_estados int not null,
	CONSTRAINT fk_cidades_estados FOREIGN KEY(id_estados) REFERENCES estados(id_estados)
);

CREATE TABLE posicoes(
	id_posicoes int not null identity primary key,

	NomePosicao varchar(15) not null
);

CREATE TABLE jogadores(
	id_jogadores int not null identity primary key,

	NomeJogador varchar(50) not null,
	Salario salario CHECK(salario >= 6500.00),
	DataNascimento date not null,

	id_posicoes int not null,
	CONSTRAINT fk_jogadores_posicoes FOREIGN KEY(id_posicoes) REFERENCES posicoes(id_posicoes)
);

CREATE TABLE times(
	id_times int not null identity primary key,

	NomeTime varchar(50) not null,

	id_cidades int not null,
	CONSTRAINT fk_times_cidades FOREIGN KEY(id_cidades) REFERENCES cidades(id_cidades)
);

CREATE TABLE partidas(
	id_partidas int not null identity primary key,

	NomeJuiz varchar(50) not null,
	DataPartida date not null,

	id_cidades int not null,
	CONSTRAINT fk_partidas_cidades FOREIGN KEY(id_cidades) REFERENCES cidades(id_cidades)
);

CREATE TABLE jogadores_partidas(
	NumeroGolsJogador int not null DEFAULT 0,

	id_jogadores int not null,
	id_partidas int not null,
	id_posicao_partida_jogador int not null,

	CONSTRAINT pk_jog_part primary key (id_jogadores, id_partidas, id_posicao_partida_jogador),
	-- Essa Primary Key e diferente por algum motivo

	CONSTRAINT fk_jogadores_partidas_jogadores FOREIGN KEY(id_jogadores) REFERENCES jogadores(id_jogadores),
	CONSTRAINT fk_jogadores_partidas_partidas FOREIGN KEY(id_partidas) REFERENCES partidas(id_partidas) ON DELETE CASCADE,
	CONSTRAINT fk_jogadores_partidas_posicoes FOREIGN KEY(id_posicao_partida_jogador) REFERENCES posicoes(id_posicoes),
	-- As duas priemiras Foreign Keys sao normais, so a ultima que e estranha
);

CREATE TABLE resultados(
	NumeroGolsPartida int not null DEFAULT 0,

	id_times int not null,
	id_partidas int not null,

	CONSTRAINT pk_resultados primary key (id_times, id_partidas),
	-- Essa tambem

	CONSTRAINT fk_resultados_times FOREIGN KEY(id_times) REFERENCES times(id_times),
	CONSTRAINT fk_resultados_partidas FOREIGN KEY(id_partidas) REFERENCES partidas(id_partidas) ON DELETE CASCADE
);

--Exercicio 4
EXEC sp_RENAME 'resultados.id_times', 'id_time1', 'COLUMN';

ALTER TABLE resultados
	ADD id_time2 int not null,
	GolsTime1 int not null DEFAULT 0,
	GolsTime2 int not null DEFAULT 0
	
	CONSTRAINT fk_resultados_time2 FOREIGN KEY(id_time2) REFERENCES times(id_times);

ALTER TABLE partidas
	ADD Bandeirinha1 varchar(50) not null,
	Bandeirinha2 varchar(50) not null,
	JuizReserva varchar(50) not null,
	JuizVAR varchar(50) not null;

ALTER TABLE jogadores
	ADD id_times int not null,

	CONSTRAINT fk_jogadores_times FOREIGN KEY(id_times) REFERENCES times(id_times);

--Exercicio 4
--Tem que criar uma tabela para os juízes e alterar as tabelas colocando os códigos no lugar dos nomes.
--A chave primária na tabela "pk_jog_part" pode existir sem o atributo "id_posicao_partida_jogador".

--Exercicio 5
--Estados
INSERT INTO estados(NomeEstado, SiglaEstado)
values ('Parana', 'PR'),
('Rio de Janeiro', 'RJ'),
('Sao Paulo', 'SP'),
('Bahia', 'BA'),
('Rio Grande do Sul', 'RS');

--Cidades
INSERT INTO cidades(NomeCidade, id_estados)
values ('Pato Branco', 1),
('Rio de Janeiro', 2),
('Sao Paulo', 3),
('Salvador', 4),
('Porto Alegre', 5);

--Times
INSERT INTO times(NomeTime, id_cidades)
values ('Gremio', 5),
('Flamengo', 2),
('Pato Branco FC', 1),
('Corinthians', 3),
('Esporte Clube Bahia', 4);

--Posicoes
INSERT INTO posicoes(NomePosicao)
values ('Ataque'),
('Meio-campo'),
('Goleiro'),
('Zagueiro'),
('Lateral');

--Jogadores
INSERT INTO jogadores(NomeJogador, Salario, DataNascimento, id_posicoes, id_times)
values ('Pedro', 19000, '1985-9-21', 4, 1),
('Cassio', 15000, '1995-10-10', 3, 4),
('Richarlison', 900000, '1997-5-10', 1, 3),
('Gilberto', 18000, '1993-3-7', 5, 5),
('David', 10000, '1987-4-22', 2, 2);

--Partidas
INSERT INTO partidas(NomeJuiz, DataPartida, id_cidades, Bandeirinha1, Bandeirinha2, JuizReserva, JuizVAR)
values ('Anderson', '2023-04-29', 1, 'Roberto', 'Joao', 'Gustavo', 'Carlos'),
('Anderson', '2023-04-30', 2, 'Joao', 'Roberto', 'Jonas', 'Carlos'),
('Kleber', '2023-05-01', 3, 'Roberto', 'Joao', 'Jonas', 'Cleyton'),
('Ricardo', '2023-11-11', 4, 'Joao', 'Paulo', 'Gustavo', 'Carlos'),
('Anderson', '2023-12-5', 5, 'Roberto', 'Joao', 'Gustavo', 'Carlos');

--Jogadores_Partidas
INSERT INTO jogadores_partidas(NumeroGolsJogador, id_jogadores, id_partidas, id_posicao_partida_jogador)
values (3, 1, 1, 4),
(0, 2, 2, 3),
(4, 3, 3, 1),
(0, 4, 4, 5),
(1, 5, 5, 2);

--Resultados
INSERT INTO resultados(NumeroGolsPartida, id_time1, id_partidas, id_time2, GolsTime1, GolsTime2)
values (4, 1, 1, 2, 3, 1),
(3, 3, 2, 4, 2, 1),
(1, 5, 3, 1, 0, 1),
(2, 1, 4, 3, 1, 1),
(3, 3, 5, 5, 3, 0);

UPDATE jogadores
SET salario = salario * 1.5
WHERE id_times = 2;

UPDATE times SET NomeTime = 'Azuris' WHERE id_times = 3;

DELETE FROM partidas WHERE DataPartida BETWEEN '2023-04-29' AND '2023-05-01';