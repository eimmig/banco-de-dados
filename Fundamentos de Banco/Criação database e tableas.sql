-- Criação database "Uberistas
CREATE DATABASE Uberistas;
USE Uberistas --adicionei o comando de use pois caso ja tenha mais de uma database

-- Tabela Funcionario
CREATE TABLE Funcionarios (
    cpf VARCHAR(11) PRIMARY KEY,
    primeiroNome VARCHAR(60) NOT NULL,
    nomeDoMeio VARCHAR(60) NOT NULL,
    sobrenome VARCHAR(60) NOT NULL,
    dataNascimento DATE NOT NULL,
    genero CHAR(1) NOT NULL
);

-- Tabela Departamento
CREATE TABLE Departamentos (
    codigo BIGINT PRIMARY KEY IDENTITY,
    nome VARCHAR(255) NOT NULL,
    numeroFuncionarios INT NOT NULL,
    cpfGerente varchar(11) NOT NULL,
    FOREIGN KEY (cpfGerente) REFERENCES Funcionarios(cpf)
);

-- Tabela Motorista
CREATE TABLE Motoristas (
    cnh VARCHAR(20) PRIMARY KEY,
    cpf VARCHAR(11) NOT NULL,
    salario MONEY NOT NULL,
    cpfSupervisor VARCHAR(11) NOT NULL,
    departamento BIGINT NOT NULL,
    FOREIGN KEY (cpf) REFERENCES Funcionarios(cpf),
    FOREIGN KEY (cpfSupervisor) REFERENCES Funcionarios(cpf),
    FOREIGN KEY (departamento) REFERENCES Departamentos(codigo)
);

-- Tabela Marca
CREATE TABLE Marcas (
    codigo BIGINT PRIMARY KEY IDENTITY,
    nome VARCHAR(255) NOT NULL
);

-- Tabela Modelo
CREATE TABLE Modelos (
    codigo BIGINT PRIMARY KEY IDENTITY,
    nome VARCHAR(255) NOT NULL,
    marca BIGINT NOT NULL,
    FOREIGN KEY (marca) REFERENCES Marcas(codigo)
);

-- Tabela Veiculo
CREATE TABLE Veiculos (
    chassi VARCHAR(20) PRIMARY KEY,
    placa VARCHAR(10),
    renavam VARCHAR(20),
    anoModelo INT,
    anoFabricacao INT,
    modelo BIGINT,
    kilometragem float,
    FOREIGN KEY (modelo) REFERENCES Modelos(codigo)
);
