--Criar o banco e as tabelas do modelo lógico para armazenar as entidades do modelo lógico a seguir: (30)
DROP TABLE IF EXISTS MesesPlantio;
GO;

DROP TABLE IF EXISTS MesesColheita;
GO;

DROP TABLE IF EXISTS Plantios;
GO;

DROP TABLE IF EXISTS Talhoes;
GO;

DROP TABLE IF EXISTS Propriedades;
GO;

DROP TABLE IF EXISTS  Especies;
GO;
USE master;
GO;
DROP DATABASE IF EXISTS  Culturas;
GO;

CREATE DATABASE Culturas;
GO;
Use Culturas;
GO;

CREATE TABLE Especies (
    IdEspecie INT PRIMARY KEY IDENTITY,
    NomeComum VARCHAR(50) NOT NULL,
    NomeCientifico VARCHAR(50),
    Producao DECIMAL(12, 4),
    CHECK(IdEspecie <= 9999)
);

CREATE TABLE MesesPlantio (
    Mes INT PRIMARY KEY,
    IdEspecie INT NOT NULL,
    FOREIGN KEY (IdEspecie) REFERENCES Especies(IdEspecie),
    CHECK (IdEspecie <= 9999),
    CHECK (Mes <= 12)
);


CREATE TABLE MesesColheita (
    Mes INT PRIMARY KEY,
    IdEspecie INT NOT NULL,
    FOREIGN KEY (IdEspecie) REFERENCES Especies(IdEspecie),
    CHECK (IdEspecie <= 9999),
    CHECK (Mes <= 12)
);

CREATE TABLE Propriedades (
    IdPropriedade INT PRIMARY KEY IDENTITY,
    Localizacao VARCHAR (50),
    Nome VARCHAR (50),
    AreaTotal DECIMAL(12,4),
    AreaIntegracao DECIMAL(12,4),
    NumTalhoes INT,
    CHECK(IdPropriedade <= 9999),
    CHECK(NumTalhoes <= 9999),
    CHECK(AreaIntegracao <= AreaTotal)
);


CREATE TABLE Talhoes (
    IdTalhao INT PRIMARY KEY IDENTITY,
    IdPropriedade INT NOT NULL,
    Area DECIMAL (12,4),
    AreaCultivada DECIMAL (12,4) NOT NULL,
    FOREIGN KEY (IdPropriedade) REFERENCES Propriedades(IdPropriedade),
    CHECK (IdTalhao <= 9999),
    CHECK (IdPropriedade <= 9999)
);

CREATE TABLE Plantios (
    DataPlantio DATE NOT NULL,
    UltimaColheita DATE,
    IdEspecie INT NOT NULL,
    IdTalhao INT NOT NULL,
    PRIMARY KEY (DataPlantio, IdEspecie, IdTalhao),
    FOREIGN KEY (IdEspecie) REFERENCES Especies(IdEspecie),
    FOREIGN KEY (IdTalhao) REFERENCES Talhoes(IdTalhao),
    CHECK (IdEspecie <= 9999),
    CHECK (IdTalhao <= 9999)
);

--b)Altere a tabela Espécies e inclua os campos “precopormuda” e “precoporkg” como “money” . (5)
ALTER TABLE ESPECIES ADD PrecoPorMuda money;
ALTER TABLE ESPECIES ADD PrecoPorKg money;

--c)Inserir 7 linhas em cada tabela com dados fictícios. (5)
INSERT INTO Especies (NomeComum, NomeCientifico, Producao, PrecoPorMuda, PrecoPorKg) VALUES ('Teste 1', 'Teste 1', 15.0000, 10.0000, 20.0000);
INSERT INTO Especies (NomeComum, NomeCientifico, Producao, PrecoPorMuda, PrecoPorKg) VALUES ('Teste 2', 'Teste 2', 25.0000, 20.0000, 30.0000);
INSERT INTO Especies (NomeComum, NomeCientifico, Producao, PrecoPorMuda, PrecoPorKg) VALUES ('Teste 3', 'Teste 3', 35.0000, 30.0000, 40.0000);
INSERT INTO Especies (NomeComum, NomeCientifico, Producao, PrecoPorMuda, PrecoPorKg) VALUES ('Teste 4', 'Teste 4', 45.0000, 40.0000, 50.0000);
INSERT INTO Especies (NomeComum, NomeCientifico, Producao, PrecoPorMuda, PrecoPorKg) VALUES ('Teste 5', 'Teste 5', 55.0000, 50.0000, 60.0000);
INSERT INTO Especies (NomeComum, NomeCientifico, Producao, PrecoPorMuda, PrecoPorKg) VALUES ('Teste 6', 'Teste 6', 65.0000, 60.0000, 70.0000);
INSERT INTO Especies (NomeComum, NomeCientifico, Producao, PrecoPorMuda, PrecoPorKg) VALUES ('Teste 7', 'Teste 7', 75.0000, 70.0000, 80.0000);

INSERT INTO Propriedades (Localizacao, Nome, AreaTotal, AreaIntegracao, NumTalhoes) VALUES ('Localizacao 1', 'Nome 1', 1.0000, 1.0000, 1);
INSERT INTO Propriedades (Localizacao, Nome, AreaTotal, AreaIntegracao, NumTalhoes) VALUES ('Localizacao 2', 'Nome 2', 2.0000, 2.0000, 2);
INSERT INTO Propriedades (Localizacao, Nome, AreaTotal, AreaIntegracao, NumTalhoes) VALUES ('Localizacao 3', 'Nome 3', 3.0000, 3.0000, 3);
INSERT INTO Propriedades (Localizacao, Nome, AreaTotal, AreaIntegracao, NumTalhoes) VALUES ('Localizacao 4', 'Nome 4', 4.0000, 4.0000, 4);
INSERT INTO Propriedades (Localizacao, Nome, AreaTotal, AreaIntegracao, NumTalhoes) VALUES ('Localizacao 5', 'Nome 5', 5.0000, 5.0000, 5);
INSERT INTO Propriedades (Localizacao, Nome, AreaTotal, AreaIntegracao, NumTalhoes) VALUES ('Localizacao 6', 'Nome 6', 6.0000, 6.0000, 6);
INSERT INTO Propriedades (Localizacao, Nome, AreaTotal, AreaIntegracao, NumTalhoes) VALUES ('Localizacao 7', 'Nome 7', 7.0000, 7.0000, 7);

INSERT INTO MesesColheita (Mes, IdEspecie) VALUES (1, 1);
INSERT INTO MesesColheita (Mes, IdEspecie) VALUES (2, 2);
INSERT INTO MesesColheita (Mes, IdEspecie) VALUES (3, 3);
INSERT INTO MesesColheita (Mes, IdEspecie) VALUES (4, 4);
INSERT INTO MesesColheita (Mes, IdEspecie) VALUES (5, 5);
INSERT INTO MesesColheita (Mes, IdEspecie) VALUES (6, 6);
INSERT INTO MesesColheita (Mes, IdEspecie) VALUES (7, 7);

INSERT INTO MesesPlantio (Mes, IdEspecie) VALUES (1, 1);
INSERT INTO MesesPlantio (Mes, IdEspecie) VALUES (2, 2);
INSERT INTO MesesPlantio (Mes, IdEspecie) VALUES (3, 3);
INSERT INTO MesesPlantio (Mes, IdEspecie) VALUES (4, 4);
INSERT INTO MesesPlantio (Mes, IdEspecie) VALUES (5, 5);
INSERT INTO MesesPlantio (Mes, IdEspecie) VALUES (6, 6);
INSERT INTO MesesPlantio (Mes, IdEspecie) VALUES (7, 7);

INSERT INTO Talhoes (IdPropriedade, Area, AreaCultivada) VALUES (1, 1.0000, 1.0000);
INSERT INTO Talhoes (IdPropriedade, Area, AreaCultivada) VALUES (2, 2.0000, 2.0000);
INSERT INTO Talhoes (IdPropriedade, Area, AreaCultivada) VALUES (3, 3.0000, 3.0000);
INSERT INTO Talhoes (IdPropriedade, Area, AreaCultivada) VALUES (4, 4.0000, 4.0000);
INSERT INTO Talhoes (IdPropriedade, Area, AreaCultivada) VALUES (5, 5.0000, 5.0000);
INSERT INTO Talhoes (IdPropriedade, Area, AreaCultivada) VALUES (6, 6.0000, 6.0000);
INSERT INTO Talhoes (IdPropriedade, Area, AreaCultivada) VALUES (7, 7.0000, 7.0000);

INSERT INTO Plantios (DataPlantio, UltimaColheita, IdEspecie, IdTalhao) VALUES (GETDATE(), GETDATE() + 1, 1, 1);
INSERT INTO Plantios (DataPlantio, UltimaColheita, IdEspecie, IdTalhao) VALUES (GETDATE() + 1, GETDATE() + 2, 2, 2);
INSERT INTO Plantios (DataPlantio, UltimaColheita, IdEspecie, IdTalhao) VALUES (GETDATE() + 2, GETDATE() + 3, 3, 3);
INSERT INTO Plantios (DataPlantio, UltimaColheita, IdEspecie, IdTalhao) VALUES (GETDATE() + 3, GETDATE() + 4, 4, 4);
INSERT INTO Plantios (DataPlantio, UltimaColheita, IdEspecie, IdTalhao) VALUES (GETDATE() + 4, GETDATE() + 5, 5, 5);
INSERT INTO Plantios (DataPlantio, UltimaColheita, IdEspecie, IdTalhao) VALUES (GETDATE() + 5, GETDATE() + 6, 6, 6);
INSERT INTO Plantios (DataPlantio, UltimaColheita, IdEspecie, IdTalhao) VALUES (GETDATE() + 6, GETDATE() + 7, 7, 7);

--d)Listar as propriedades com área de integração maiores que 5 hectares, em ordem decrescente de integração. (10
SELECT
    *
FROM Propriedades p
WHERE p.AreaIntegracao > 5
ORDER BY p.AreaIntegracao DESC;

--e) Listar o id , nome e localização das propriedades que tem “Uva Malbec” no plantio em ordem de nome. (10)

SELECT
    p.IdPropriedade,
    p.Nome,
    p.Localizacao
FROM Propriedades p
INNER JOIN Talhoes t ON t.IdPropriedade = p.IdPropriedade
INNER JOIN Plantios pl on t.IdTalhao = pl.IdTalhao
INNER JOIN Especies e on pl.IdEspecie = e.IdEspecie
WHERE e.NomeComum LIKE 'Uva Malbec'
ORDER BY p.nome;

--f)Calcular a soma de área cultivada de todas as propriedades por espécie plantadas no ano de 2022. (10)
SELECT
    pl.IdEspecie,
    SUM(t.AreaCultivada) as areaCultivada
FROM Propriedades p
INNER JOIN Talhoes t on p.IdPropriedade = t.IdPropriedade
INNER JOIN Plantios pl on t.IdTalhao = pl.IdTalhao
WHERE YEAR(pl.DataPlantio) = 2022
GROUP BY pl.IdEspecie;

--g)Listar o nome comum e científico das espécies com produção acima de 500kgs/hectare (considere que a produção é em kgs/ha*) (10)

SELECT
    e.NomeComum,
    e.NomeCientifico
FROM Especies e
INNER JOIN Plantios p on e.IdEspecie = p.IdEspecie
INNER JOIN Talhoes t on p.IdTalhao = t.IdTalhao
WHERE e.Producao > 500;

--h)Sabendo que a produção estimada é medida em kgs/ha, mostre o total de área cultivada por espécie, bem como o valor total
--estimado a ser faturado por espécie. Dica: usar group by, lembrando que é possível utilizar expressões aritméticas como
--parâmetro de funções agregadas. (10)

SELECT
    e.IdEspecie,
    SUM(t.AreaCultivada) as areaCultivada,
    SUM(e.PrecoPorKg * e.Producao) as faturamentoEstimado
FROM Especies e
INNER JOIN Plantios p on e.IdEspecie = p.IdEspecie
INNER JOIN Talhoes t on p.IdTalhao = t.IdTalhao
GROUP BY e.IdEspecie;

--i)Sabendo que a produção estimada é medida em kgs/ha, mostre o total de área cultivada por propriedade, bem como o valor
--total estimado a ser faturado por propriedade. Dica: usar group by, lembrando que é possível utilizar expressões aritméticas
--como parâmetro de funções agregadas. (10)

SELECT
    t.IdPropriedade,
    SUM(t.AreaCultivada) as areaCultivada,
    SUM(e.PrecoPorKg * e.Producao) as faturamentoEstimado
FROM Especies e
INNER JOIN Plantios p on e.IdEspecie = p.IdEspecie
INNER JOIN Talhoes t on p.IdTalhao = t.IdTalhao
GROUP BY t.IdPropriedade;