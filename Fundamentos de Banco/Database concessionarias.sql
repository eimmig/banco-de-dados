--Inicio declaracao database
CREATE DATABASE Concessionarias;
USE Concessionarias;

--Inicio criacao das tables
CREATE TABLE Paises(
	Cod_Pais BIGINT PRIMARY KEY IDENTITY,
	Nome_Pais VARCHAR(255) NOT NULL
);

CREATE TABLE Cidades(
	Cod_Cidade BIGINT PRIMARY KEY IDENTITY,
	Nome_Cidade VARCHAR(255) NOT NULL,
	UF VARCHAR(2) NOT NULL,
	Cod_Pais BIGINT NOT NULL,
	FOREIGN KEY (Cod_Pais) REFERENCES Paises(Cod_Pais)
);

CREATE TABLE Marcas(
	Cod_Marca BIGINT PRIMARY KEY IDENTITY,
	Nome_Marca VARCHAR(255) NOT NULL,
	Pais_Origem BIGINT NOT NULL,
	FOREIGN KEY (Pais_Origem) REFERENCES Paises(Cod_Pais)
);

CREATE TABLE Modelos (
	Cod_Modelo BIGINT PRIMARY KEY IDENTITY,
	Nome_Modelo VARCHAR(255) NOT NULL,
	Tipo_Modelo VARCHAR(10) NOT NULL,
	Cor_Modelo VARCHAR(60) NOT NULL,
	Cod_Marca BIGINT NOT NULL,
	FOREIGN KEY (Cod_Marca) REFERENCES Marcas(Cod_Marca)
);

CREATE TABLE Filiais (
	Cod_Filial BIGINT PRIMARY KEY IDENTITY,
	Nome_Filial VARCHAR(255) NOT NULL,
	Cidade_Filial BIGINT NOT NULL,
	FOREIGN KEY (Cidade_Filial) REFERENCES Cidades(Cod_Cidade)
);

CREATE TABLE Disponiveis (
	Cod_Disponiveis BIGINT PRIMARY KEY IDENTITY,
	Cod_Modelo BIGINT NOT NULL,
	Cod_Filial BIGINT NOT NULL,
	Data TIMESTAMP NOT NULL,
	Quantidade INT NOT NULL,
	Valor_Venda MONEY NOT NULL,
	FOREIGN KEY (Cod_Modelo) REFERENCES Modelos(Cod_Modelo),
	FOREIGN KEY (Cod_Filial) REFERENCES Filiais(Cod_Filial)
);

CREATE TABLE Veiculos (
	Cod_Veiculo BIGINT PRIMARY KEY IDENTITY,
	Cod_Modelo BIGINT NOT NULL,
	Ano_Fab INT NOT NULL,
	Ano_Modelo INT NOT NULL,
	FOREIGN KEY (Cod_Modelo) REFERENCES Modelos(Cod_Modelo)
);

ALTER TABLE Modelos ADD Chassi VARCHAR(20) NOT NULL;
ALTER TABLE Filiais ADD Email VARCHAR(100) NOT NULL, Telefone VARCHAR(20) NOT NULL;
ALTER TABLE Filiais ADD CONSTRAINT UK_CidadeFilial UNIQUE (Cidade_filial);