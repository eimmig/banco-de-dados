-- a) Criação da tabela Premios
CREATE TABLE Premios (
    id BIGINT IDENTITY PRIMARY KEY,
    nome_premio VARCHAR(100) UNIQUE NOT NULL
);

-- c) Remoção da chave primária da tabela FilmesPremios
ALTER TABLE FilmesPremios
DROP CONSTRAINT IF EXISTS PK_FilmesPremios;

-- b) Remoção da coluna nome_premio da tabela FilmesPremios
ALTER TABLE FilmesPremios
DROP COLUMN IF EXISTS nome_premio;

-- d) Inclusão do atributo id_premio na tabela FilmesPremios
ALTER TABLE FilmesPremios
ADD id_premio BIGINT NOT NULL,
CONSTRAINT FK_id_Premio_Premio FOREIGN KEY (id_premio) REFERENCES Premios(id);

-- e) Inclusão da chave primária PRIMARY KEY (filme, id_premio) na tabela FilmesPremios
ALTER TABLE FilmesPremios
ADD CONSTRAINT PK_FilmesPremios PRIMARY KEY (filme, id_premio);


-- f) Criação da tabela Categorias
CREATE TABLE Categorias (
    id BIGINT IDENTITY PRIMARY KEY,
    nome_categoria VARCHAR(100) UNIQUE NOT NULL
);


-- g) Remoção do atributo categoria_filme da tabela Filmes
ALTER TABLE Filmes
DROP COLUMN IF EXISTS categoria_filme;


-- h) Inclusão do atributo categoria na tabela Filmes, fazendo referência à tabela Categorias
ALTER TABLE Filmes
ADD categoria BIGINT,
CONSTRAINT FK_Categorias FOREIGN KEY (categoria) REFERENCES Categorias(id);


-- i) Inclusão da restrição na tabela Cidades, para que a UF possa ter as siglas dos estados brasileiros + o símbolo 'IG'
ALTER TABLE Cidades
ADD CONSTRAINT CK_UF_Brasil
CHECK (uf IN ('AC', 'AL', 'AM', 'AP', 'BA', 'CE', 'DF', 'ES', 'MA', 'MG', 'MS', 'MT', 'PA', 'PB', 'PE', 'PI', 'PR', 'RJ', 'RN', 'RO', 'RR', 'RS', 'SC', 'SE', 'SP', 'TO', 'IG'));


-- j) Criação da tabela Atores
CREATE TABLE Atores (
    id BIGINT IDENTITY PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    pais BIGINT,
    ano_nascimento INT,
    FOREIGN KEY (pais) REFERENCES Paises(id)
);


-- k) Criação da tabela FilmesAtores
CREATE TABLE FilmesAtores (
    filme BIGINT,
    ator BIGINT,
    PRIMARY KEY (filme, ator),
    FOREIGN KEY (filme) REFERENCES Filmes(id),
    FOREIGN KEY (ator) REFERENCES Atores(id)
);
GO

