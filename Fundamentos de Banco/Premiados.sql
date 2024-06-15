-- Drop das tabelas e database na ordem
DROP TABLE IF EXISTS SalasFilmes;
DROP TABLE IF EXISTS FilmesPremios;
DROP TABLE IF EXISTS SalasCinemas;
DROP TABLE IF EXISTS Cinemas;
DROP TABLE IF EXISTS Filmes;
DROP TABLE IF EXISTS Diretores;
DROP TABLE IF EXISTS Cidades;
DROP TABLE IF EXISTS Paises;
-- Venho pra master pra depois dropar a database
USE master;
GO
DROP DATABASE IF EXISTS Premiados;
GO

-- Criação database
CREATE DATABASE Premiados;
GO
-- Seleciona a database
USE Premiados;
GO
-- Drop das tabelas na ordem
DROP TABLE IF EXISTS SalasFilmes;
DROP TABLE IF EXISTS FilmesPremios;
DROP TABLE IF EXISTS SalasCinemas;
DROP TABLE IF EXISTS Cinemas;
DROP TABLE IF EXISTS Filmes;
DROP TABLE IF EXISTS Diretores;
DROP TABLE IF EXISTS Cidades;
DROP TABLE IF EXISTS Paises;

-- Criação da tabela Paises
CREATE TABLE Paises (
    id BIGINT IDENTITY PRIMARY KEY,
    nome_pais VARCHAR(100) UNIQUE NOT NULL
);

-- Criação da tabela Cidades
CREATE TABLE Cidades (
    id BIGINT IDENTITY PRIMARY KEY,
    nome_cidade VARCHAR(100) NOT NULL,
    uf CHAR(2) NOT NULL,
    pais BIGINT,
    FOREIGN KEY (pais) REFERENCES Paises(id)
);

-- Criação da tabela Cinemas
CREATE TABLE Cinemas (
    id BIGINT IDENTITY PRIMARY KEY,
    nome_cinema VARCHAR(100) NOT NULL,
    numero_de_salas INT CHECK (numero_de_salas > 0),
    rua VARCHAR(255) NOT NULL,
    numero INT NOT NULL,
    cep VARCHAR(8) NOT NULL,
    cidade BIGINT,
    telefone CHAR(10),
    FOREIGN KEY (cidade) REFERENCES Cidades(id)
);

-- Criação da tabela SalasCinemas
CREATE TABLE SalasCinemas (
    cinema BIGINT,
    numero_sala BIGINT,
    descricao_sala VARCHAR, --deixei sem tamanho pois posso por algo maior
    capacidade INT CHECK (capacidade > 0),
    CONSTRAINT PK_SalasCinemas PRIMARY KEY  (cinema, numero_sala),
    FOREIGN KEY (cinema) REFERENCES Cinemas(id)
);

-- Criação da tabela Diretores
CREATE TABLE Diretores (
    id BIGINT IDENTITY PRIMARY KEY,
    nome_diretor VARCHAR(100) UNIQUE NOT NULL,
    pais BIGINT,
    FOREIGN KEY (pais) REFERENCES Paises(id)
);

-- Criação da tabela Filmes
CREATE TABLE Filmes (
    id BIGINT IDENTITY PRIMARY KEY,
    nome_filme VARCHAR(255) NOT NULL,
    ano_lancamento INT,
    categoria_filme VARCHAR(100),
    diretor BIGINT,
    pais BIGINT,
    FOREIGN KEY (diretor) REFERENCES Diretores(id),
    FOREIGN KEY (pais) REFERENCES Paises(id)
);

-- Criação da tabela FilmesPremios
CREATE TABLE FilmesPremios (
    filme BIGINT,
    nome_premio VARCHAR(100),
    ano_premiacao INT,
    CONSTRAINT PK_FilmesPremios PRIMARY KEY (filme, nome_premio, ano_premiacao),
    FOREIGN KEY (filme) REFERENCES Filmes(id)
);

-- Criação da tabela SalasFilmes
CREATE TABLE SalasFilmes (
    cinema BIGINT,
    numero_sala BIGINT,
    filme BIGINT,
    data DATE,
    horario TIME,
    valor_ingresso MONEY CHECK (valor_ingresso > 0),
    CONSTRAINT PK_SalasFilmes PRIMARY KEY (cinema, numero_sala, filme, data, horario),
    FOREIGN KEY (cinema, numero_sala) REFERENCES SalasCinemas(cinema, numero_sala),
    FOREIGN KEY (filme) REFERENCES Filmes(id)
);
GO
