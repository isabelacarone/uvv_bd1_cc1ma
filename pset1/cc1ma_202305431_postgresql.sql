
-- Apagar banco de dados e usuário, caso já existam ambos. -- 
DROP DATABASE IF EXISTS uvv;
DROP USER IF EXISTS isabela;

-- Criação do usuário e em seguida a senha. -- 

CREATE USER 
isabela WITH
        CREATEDB 
        CREATEROLE 
        ENCRYPTED PASSWORD 
              '48541802';

-- Criação do banco de dados "uvv" com suas devidas especificações. -- 

CREATE DATABASE 
uvv WITH 
    OWNER = isabela 
    TEMPLATE = template0 
    ENCODING = "UTF8"
    LC_COLLATE = 'pt_BR.UTF-8' 
    LC_CTYPE = 'pt_BR.UTF-8'
    ALLOW_CONNECTIONS = true;

-- Entrar no Banco de dados uvv já com o usuário "isabela" logado. -- 

 \c  "dbname=uvv user=isabela password=48541802"

-- Criação do schema "lojas" e autorizando o usuário "isabela" para o manipular. -- 

CREATE SCHEMA lojas AUTHORIZATION isabela;

-- Alterando para o usuário "isabela". -- 
ALTER USER isabela WITH LOGIN;

-- Para usar o schema como padrão do usuário "isabela". -- 
SET SEARCH_PATH TO lojas, 
"$user", public;

-- Criação da tabela produtos e primary key -- 

CREATE TABLE lojas.produtos (
                produto_id                 NUMERIC(38)       NOT NULL,
                nome                       VARCHAR(255)      NOT NULL,
                preco_unitario             NUMERIC(10,2),
                detalhes                   BYTEA,
                iamgem                     BYTEA,
                imagem_mime_type           VARCHAR(512),
                imagem_arquivo             VARCHAR(512),
                imagem_charset             VARCHAR(512),
                imagem_ultima_atualizacao  DATE,

                CONSTRAINT pk_produtos PRIMARY KEY (produto_id)
                          );

-- Comentário da tabela produtos -- 

COMMENT ON TABLE lojas.produtos IS 'Tabela referente aos produtos.';

-- Comentário das colunas da tabela produtos -- 

COMMENT ON COLUMN lojas.produtos.produto_id IS 'Primary Key da tabela. Contém ID dos produto.';
COMMENT ON COLUMN lojas.produtos.nome IS 'Nome do produto.';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'Preço da cada produto, separado.';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'Detalhe do produto.';
COMMENT ON COLUMN lojas.produtos.iamgem IS 'Imagem do produto.';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'Idenficador padrão usado para ler o tipo de arquivo.';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'Arquivo com a imagem.';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'Codificação dos caracteres do arquivo.';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Data ( MM - DD - YYYY).';


-- Criação da tabela clientes e primary key  --

CREATE TABLE lojas.clientes (
                cliente_id               NUMERIC(38)          NOT NULL,
                email                    VARCHAR(255)         NOT NULL,
                nome                     VARCHAR(255)         NOT NULL,
                telefone1                VARCHAR(20),
                telefone2                VARCHAR(20),
                telefone3                VARCHAR(20),

                CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
                           );

-- Comentário da tabela clientes --

COMMENT ON TABLE lojas.clientes IS 'Tabela referente aos clientes';

-- Comentário das colunas da tabela clientes --

COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Primary Key da tabela. Contém ID dos clientes.';
COMMENT ON COLUMN lojas.clientes.email IS 'Email registrado do cliente.';
COMMENT ON COLUMN lojas.clientes.nome IS 'Nome do cliente, igual ao RG.';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'Telefone registrado do cliente.';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'Telefone registrado do cliente.';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'Telefone registrado do cliente.';


-- Criação da tabela lojas e primary  --

CREATE TABLE lojas.lojas (
                loja_id                   NUMERIC(38)        NOT NULL,
                nome                      VARCHAR(255)       NOT NULL,
                endereco_web              VARCHAR(100),
                endereco_fisico           VARCHAR(512),
                latitude                  NUMERIC,
                longitude                 NUMERIC,
                logo                      BYTEA,
                logo_mime_type            VARCHAR(512),
                logo_arquivo              VARCHAR(512),
                logo_charset              VARCHAR(512),
                logo_ultima_atualizacao   DATE,

                CONSTRAINT pk_lojas PRIMARY KEY (loja_id)
                        );

-- Comentário da tabela lojas -- 

COMMENT ON TABLE lojas.lojas IS 'Tabela referente as lojas.';

-- Comentário das colunas da tabela lojas -- 

COMMENT ON COLUMN lojas.lojas.loja_id IS 'Primary Key da tabela. Contém ID das lojas.';
COMMENT ON COLUMN lojas.lojas.nome IS 'Nome da loja.';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'Nome do site da loja.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'Endereço da loja. Rua, CEP, Bairro, Estado';
COMMENT ON COLUMN lojas.lojas.latitude IS 'Latitude da localização da loja.';
COMMENT ON COLUMN lojas.lojas.longitude IS 'Longitude da localização da loja.';
COMMENT ON COLUMN lojas.lojas.logo IS 'Logo da loja.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'Idenficador padrão usado para ler o tipo de arquivo.';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'Arquivo com a imagem.';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'Codificação dos caracteres do arquivo.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Data ( MM - DD - YYYY).';


-- Criação da tabela estoques e primary key --

CREATE TABLE lojas.estoques (
                estoque_id              NUMERIC(38)     NOT NULL,
                quantidade              NUMERIC(38)     NOT NULL,
                loja_id                 NUMERIC(38)     NOT NULL,
                produtos_id             NUMERIC(38)     NOT NULL,
                produto_id              NUMERIC(38)     NOT NULL,

                CONSTRAINT pk_estoques  PRIMARY KEY (estoque_id)
                             );
-- Comentário da tabela estoques -- 

COMMENT ON TABLE lojas.estoques IS 'Tabela referente aos estoques.';

-- Comentários da colunas da tabela estoques -- 

COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Primary Key da tabela. Contém ID do estoque.';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Quantidade de produtos no estoque.';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'Foreign Key da tabela. Faz conexão com outra tabela.';
COMMENT ON COLUMN lojas.estoques.produtos_id IS 'Foreign Key da tabela. Faz conexão com outra tabela.';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Primary Key da tabela. Contém ID dos produto.';


-- Criação da tabela envios e primary key -- 

CREATE TABLE lojas.envios (
                envio_id             NUMERIC(38)             NOT NULL,
                loja_id              NUMERIC(38)             NOT NULL,
                cliente_id           NUMERIC(38)             NOT NULL,
                endereco_entrega     VARCHAR(512)            NOT NULL,
                status VARCHAR(15)   NOT NULL,

                CONSTRAINT pk_envios PRIMARY KEY (envio_id)
                          );

-- Comentário da tabela envios --

COMMENT ON TABLE lojas.envios IS 'Tabela referente aos envios.';

--Comentários das colunas da tabela envios --

COMMENT ON COLUMN lojas.envios.envio_id IS 'Primary Key da tabela. Contém ID dos envios';
COMMENT ON COLUMN lojas.envios.loja_id IS 'Foreign Key da tabela. Faz conexão com outra tabela';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'Foreign Key da tabela. Faz conexão com outra tabela.';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Endereço dos lugares de envio dos pedidos.';
COMMENT ON COLUMN lojas.envios.status IS 'Status rerente aos envios.';

-- Criação da tabela pedidos e primary key  --

CREATE TABLE lojas.pedidos (
                pedidos_id     NUMERIC(38)           NOT NULL,
                data_hora      TIMESTAMP             NOT NULL,
                cliente_id     NUMERIC(38)           NOT NULL,
                status         VARCHAR(15)           NOT NULL,
                loja_id        NUMERIC(38)           NOT NULL,

                CONSTRAINT pk_pedidos PRIMARY KEY (pedidos_id)
                          );

-- Criação do comentário da tabela pedidos --
 
COMMENT ON TABLE lojas.pedidos IS 'Tabela referente aos pedidos.';

-- Comentário das colunas da tabela envios --

COMMENT ON COLUMN lojas.pedidos.pedidos_id IS 'Primary Key da tabela. Contém ID dos pedidos.';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Data ( MM - DD - YYYY) e hora dos pedidos.';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Foreign Key da tabela. Faz conexão com outra tabela.';
COMMENT ON COLUMN lojas.pedidos.status IS 'Status de processo dos pedidos.';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'Foreign Key da tabela. Faz conexão com outra tabela.';


-- Criação da tabela pedidos_itens e primary key -- 

CREATE TABLE lojas.pedidos_itens (
                pedidos_id            NUMERIC(38)                 NOT NULL,
                produto_id            NUMERIC(38)                 NOT NULL,
                pedido_id             NUMERIC(38)                 NOT NULL,
                numero_da_linha       NUMERIC(38)                 NOT NULL,
                preco_unitario        NUMERIC(10,2)               NOT NULL,
                quantidade            NUMERIC(38)                 NOT NULL,
                envio_id              NUMERIC(38),

                CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedidos_id, produto_id)
                                );

-- Criação do comentário da tabela pedidos_itens --

COMMENT ON TABLE lojas.pedidos_itens IS 'Tabela referente aos itens pedidos.';

-- Comentários das colunas da tabela pedidos_itens --

COMMENT ON COLUMN lojas.pedidos_itens.pedidos_id IS 'Primary Key da tabela. Contém ID dos pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'Primary foreign key da tabela. Faz conexão com outra tabela.';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'Primary foreign key da tabela. Faz conexão com outra tabela.';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Edição do pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'Valor de cada item, separado.';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'Quantidade de cada item.';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'Foreign Key da tabela. Faz conexão com outra tabela.';


-- Todas as foreigns keys --
 
ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT pedidos_lojas_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedidos_id)
REFERENCES lojas.pedidos (pedidos_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE; 

-- Restrição ao preco_unitario. --
 
ALTER TABLE lojas.produtos
ADD CONSTRAINT cc_produtos_preco_unitario

CHECK(preco_unitario >= 0);



ALTER TABLE lojas.pedidos_itens

ADD CONSTRAINT cc_pedidos_itens_preco_unitario

CHECK(preco_unitario >= 0);


-- Restrição a quantidade de itens. --

ALTER TABLE lojas.pedidos_itens

ADD CONSTRAINT cc_pedidos_itens_quantidade

CHECK(quantidade >= 0);



ALTER TABLE lojas.estoques

ADD CONSTRAINT cc_estoque_quantidade

CHECK(quantidade >= 0);
        

-- Restrição ao status_envios; colocando os processos possíveis). -- 

ALTER TABLE lojas.pedidos

ADD CONSTRAINT cc_pedidos_status
    
CHECK (lojas.pedidos.status IN('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO','ENVIADO'));


-- Restrição ao status_pedidos; colocando os processos possíveis). -- 

ALTER TABLE lojas.envios
         
ADD CONSTRAINT cc_envios_status 
    
CHECK (lojas.envios.status IN ('CRIADO','ENVIADO', 'TRANSITO', 'ENTREGUE'));


-- Restrição ao endereco_web e endereco_fisico da tabela lojas, de modo que fique pelo menos um dos itens com informação,não podendo deixar o espaço de endereço nulo. -- 

ALTER TABLE lojas.lojas 
ADD CONSTRAINT cc_enderco 
CHECK (lojas.lojas.endereco_web IS NOT NULL OR lojas.lojas.endereco_fisico IS NOT NULL);


