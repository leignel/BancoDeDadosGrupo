create database ofertas_express1;

--Grupo 2: Projeto final

--Alunos:
--Rian Fernandes
--Cristian Leignel
--Felipe Balbino Ribeiro
--Igor Araujo
--Eduardo Carneiro


--Inserção de dados:

--1) Endereço:
create table endereco(
	end_cd_id serial,
	end_tx_rua varchar(100) not null,
	end_int_num integer not null,
	end_tx_complemento varchar(20) not null,
	end_tx_bairro varchar(30) not null,
	end_tx_cidade varchar(30) not null,
	end_tx_estado varchar(30) not null,
	end_tx_cep varchar(9) not null,
	primary key(end_cd_id)
);

--2) Contato:
create table contato(
	contato_cd_id serial,
	cont_tx_telfix varchar(15) not null,
	end_tx_celular varchar(16) not null,
	end_tx_email varchar(100) not null,
	primary key (contato_cd_id)
);

--3) Categoria:
create table categoria(
	cate_cd_id serial,
	cate_tx_nome varchar(30) not null,
	cate_tx_descricao varchar(200) not null,
	primary key(cate_cd_id)
);

--4) Usuario:
create table usuario(
	usuario_cd_id serial,
	usuario_tx_nome varchar(50) not null,
	usuario_tx_login varchar(50) not null,
	usuario_tx_cpf varchar(14) not null,
	usuario_tx_nascimento date not null,
	fk_end_cd_id integer,
	fk_contato_cd_id integer,
	primary key (usuario_cd_id),
	foreign key(fk_end_cd_id) references endereco (end_cd_id),
	foreign key(fk_contato_cd_id) references contato (contato_cd_id)
);

--5) Produto:
create table produto(
	prod_cd_id serial,
	prod_tx_nome varchar(30) not null,
	prod_tx_descricao varchar(200) not null,
	prod_int_qntestoque integer not null,
	prod_dt_datafabri date not null,
	prod_nm_valoruni decimal not null,
	fk_usuario_id integer,
	fk_cate_id integer,
	primary key (prod_cd_id),
	foreign key (fk_usuario_id) references usuario(usuario_cd_id),
	foreign key (fk_cate_id) references categoria(cate_cd_id)
);

--6) pedidoProduto:
create table pedidoproduto(
	pedprod_cd_id serial,
	pedprod_dt_data date not null,
	pedprod_int_qnt integer not null,
	fk_prod_cd_id integer,
	primary key(pedprod_cd_id),
	foreign key(fk_prod_cd_id) references produto(prod_cd_id)
);

--7) Pedido
create table pedido (
	pedido_cd_id serial,
	pedido_dt_data date not null,
	fk_pedprod_cd_id integer,
	fk_usuario_cd_id integer,
	primary key(pedido_cd_id),
	foreign key(fk_pedprod_cd_id) references pedidoproduto(pedprod_cd_id),
	foreign key(fk_usuario_cd_id) references usuario(usuario_cd_id)
);

--Inserção de dados das tabelas

--1)Dados contato:
insert into contato(cont_tx_telfix, end_tx_celular, end_tx_email) values 
('(11)1234-5678','(11)98765-4321','rian@gmail.com'),
('(21)9876-5432','(21)97654-3210','cris@hotmail.com'),
('(31)5555-1234','(31)96543-2109','igor@yahoo.com'),
('(41)8888-4327','(41)95432-1096','edu@outlook.com'),
('(51)7777-8765','(51)94321-0984','felps@gmail.com');

--2)Endereço:
insert into endereco(end_tx_rua, end_int_num, end_tx_complemento, end_tx_bairro, end_tx_cidade, end_tx_estado, end_tx_cep) values
('Rua das Flores',260,'Casa florida','Jardim Primavera','São Paulo','São Paulo','54321-987'),
('Avenida Central',750,'Condominio','Centro','Rio de Janeiro','Niterói','98765-432'),
('Rua da Amizade',777,'Apartamento','Amizade','Minas Gerais','Uberlândia','22222-333'),
('Rua dos Sonhos',825,'Rua sem saida','Bairro dos Sonhos','Paraná','Curitiba','55555-444'),
('Avenida da Liberdade',333,'Do lado da prisão','Neylor','Rio Grande do Sul','Porto Alegre','78965-321');

--3)Categoria:
insert into categoria(cate_tx_nome,cate_tx_descricao) values 
('Eletrônicos','Os melhores aparelhos da atualizada'),
('Brinquedo','Variedades para todas as crianças'),
('Roupas','Aqui voce pode renovar seu guarda roupa e estar sempre na moda'),
('Livros','Livros de todos os gêneros e idades'),
('Cozinha','Os produtos para deixar sua cozinha pronta para aquele almoço de domingo');

--4)Usuário:
insert into usuario(usuario_tx_nome,usuario_tx_login,usuario_tx_cpf,usuario_tx_nascimento,fk_end_cd_id,fk_contato_cd_id) values
('Rian','rianzingamer08','123.456.789-01','1998-03-23',2,1),
('Cristian','leignelsonpedreiro','987.654.321-09','1995-09-23',1,2),
('Felipe','felipeDoTremBala','562.555.545-85','1995-09-23',4,3),
('Eduardo','eduardoEmonica','819.239.008-77','1990-11-20',5,4),
('Igor','igorbatima','777.777.777-77','2005-03-21',3,5);

--5)Produto:
insert into produto(prod_tx_nome, prod_tx_descricao,prod_int_qntestoque,prod_dt_datafabri, prod_nm_valoruni,fk_usuario_id,fk_cate_id)values
('Iphone 25','Preto 256 gb', 5,'2020-08-25',12000.00,5,1),
('Forno a jato','Possui 10 bocas e um componente de foguete', 10,'2021-02-17',20000.00,4,5),
('Nerf minigun','Azul com dois mil cartuchos', 30,'2022-12-25',150.00,3,2),
('Casaco da nike de tricô','Azul marinha', 100,'2023-08-21',750.00,2,3),
('Grimório perdido','Todas as magias, literalmente todas', 1,'1320-07-20',500000.00,1,4);

--6)Pedido-Produto:
insert into pedidoproduto(pedprod_dt_data, pedprod_int_qnt,fk_prod_cd_id) values
('2023-08-10',4,1),
('2023-08-12',2,3),
('2023-08-13',1,5),
('2023-08-14',8,2),
('2023-08-22',1,4);

--7)Pedido:
insert into pedido(pedido_dt_data,fk_pedprod_cd_id,fk_usuario_cd_id) values
('2023-08-09',1,5),
('2023-08-09',3,3),
('2023-08-09',5,1),
('2023-08-09',2,4),
('2023-08-09',4,2);

-- Crie uma view de nota fiscal
CREATE VIEW nota_fiscal AS
select
    ped.pedido_cd_id AS numero_nota,
    ped.pedido_dt_data AS data_emissao,
    u.usuario_tx_nome AS nome_cliente,
    u.usuario_tx_cpf AS cpf_cliente,
    e.end_tx_rua AS endereco_entrega,
    e.end_int_num AS numero_entrega,
    e.end_tx_complemento AS complemento_entrega,
    e.end_tx_bairro AS bairro_entrega,
    e.end_tx_cidade AS cidade_entrega,
    e.end_tx_estado AS estado_entrega,
    e.end_tx_cep AS cep_entrega,
    p.prod_tx_nome AS nome_produto,
    pp.pedprod_int_qnt AS quantidade,
    p.prod_nm_valoruni AS valor_unitario,
    (pp.pedprod_int_qnt * p.prod_nm_valoruni) AS valor_total
FROM pedido ped
INNER JOIN usuario u ON ped.fk_usuario_cd_id = u.usuario_cd_id
INNER JOIN pedidoproduto pp ON ped.pedido_cd_id = pp.fk_prod_cd_id
INNER JOIN produto p ON pp.fk_prod_cd_id = p.prod_cd_id
INNER JOIN endereco e ON u.fk_end_cd_id = e.end_cd_id;

select * from nota_fiscal;

-- Consulta view seleciona quantidade de itens por categoria
create view selecionaItensPorCategoria as
SELECT c.cate_tx_nome AS Categoria, COUNT(p.prod_cd_id) AS total_de_produtos_por_categoria
FROM categoria c
INNER JOIN produto p ON c.cate_cd_id = p.fk_cate_id
INNER JOIN pedidoproduto pp ON p.prod_cd_id = pp.fk_prod_cd_id
INNER JOIN pedido ped ON pp.fk_prod_cd_id = ped.fk_pedprod_cd_id
GROUP BY c.cate_tx_nome;

select * from selecionaItensPorCategoria;

-- Consulta os produtos e suas descrições
create view produtosDescricao as
select prod_tx_nome as produto, prod_tx_descricao as descrição from produto;

select * from produtosDescricao;

-- Consulta usuarios e seus telefones
create view usuariosTelefone as
select
	usuario_tx_nome as nome_usuario,
	cont_tx_telfix as telefone
from
	usuario
inner join contato on
	usuario.fk_contato_cd_id = contato.contato_cd_id;

select * from usuariosTelefone;

-- Consulta valor eletrônicos
create view consultaValorEletronico as
select
	p.prod_tx_nome as produto,
	p.prod_nm_valoruni as preco_unitario
from
	produto p
inner join categoria c on
	p.fk_cate_id = c.cate_cd_id
where
	c.cate_tx_nome = 'Eletrônicos';

select * from consultaValorEletronico;

-- Consulta pedidos por um usuario
create view pedidosUsuarios as
select
	u.usuario_tx_nome as nome_usuario,
	ped.pedido_cd_id as numero_pedido,
	pp.pedprod_dt_data as data_pedido,
	pr.prod_tx_nome as nome_produto,
	pp.pedprod_int_qnt as quantidade
from
	usuario u
inner join pedido ped on
	u.usuario_cd_id = ped.fk_usuario_cd_id
inner join pedidoproduto pp on
	ped.fk_pedprod_cd_id = pp.pedprod_cd_id
inner join produto pr on
	pp.fk_prod_cd_id = pr.prod_cd_id
where
	u.usuario_tx_nome = 'Rian';

select * from pedidosUsuarios;

--Criando os usuario:
create user vendedor2 password '123456';
create user comprador2 password '111111';

--Dando permissão para a role vendedor:
GRANT SELECT, INSERT, UPDATE, DELETE ON produto, categoria TO vendedor2;
select * from produto;
select * from usuario;

--Dando permissão para a role comprador:
GRANT select on produto, categoria, pedidoproduto to comprador2;
select * from categoria;
select * from usuario;

--Update para atualizar o brinquedo nerf para um boneco colecionavel.
update produto set prod_tx_nome = 'Boneco colecionavel do batman' where prod_cd_id = 3;

--Deletando pedido com base no ID
delete from pedido where pedido_cd_id = 1;

--Criando indices 
CREATE INDEX idx_pedido_data ON pedido (pedido_dt_data);
CREATE INDEX idx_pedidoproduto_produto ON pedidoproduto (fk_prod_cd_id);
CREATE INDEX idx_produto_datafabricacao ON produto (prod_dt_datafabri);
CREATE INDEX idx_pedidoproduto_data ON pedidoproduto (pedprod_dt_data);
CREATE INDEX idx_produto_categoria ON produto (fk_cate_id);