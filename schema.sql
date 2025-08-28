-- Habilita a criação de UUIDs caso queira usar futuramente
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Tabela para armazenar informações dos usuários da plataforma
CREATE TABLE usuarios (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(), -- Chave primária única para cada usuário
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL, -- A senha nunca é salva em texto puro
    data_criacao TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Tabela principal para guardar os dados da nota fiscal eletrônica
CREATE TABLE nota_fiscal (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    usuario_id UUID REFERENCES usuarios(id), -- Chave estrangeira para saber qual usuário fez o upload
    chave_acesso VARCHAR(44) NOT NULL UNIQUE, -- Chave de 44 dígitos da NFe
    dados_xml TEXT NOT NULL, -- Conteúdo completo do XML da nota
    nome_arquivo VARCHAR(255),
    data_upload TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Tabela para armazenar o resultado da análise feita pelo serviço de IA
CREATE TABLE analise_fiscal (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    nota_fiscal_id UUID NOT NULL REFERENCES nota_fiscal(id), -- Conecta a análise à sua respectiva nota fiscal
    status VARCHAR(50) NOT NULL, -- Ex: 'CONCLUIDA_COM_ERROS', 'SEM_INCONSISTENCIAS'
    inconsistencias JSONB, -- Campo flexível (JSON) para guardar os erros encontrados. Ex: [{"erro": "aliquota_invalida", "detalhe": "Alíquota de CBS para o produto X deveria ser 9.25%"}]
    data_analise TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);