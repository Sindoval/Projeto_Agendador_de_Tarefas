CREATE DATABASE db_usuario;
CREATE DATABASE db_comunicacao;

\c db_usuario;

INSERT INTO usuario (nome, email, senha)
VALUES ('Admin', 'admin@admin.com', '123456')
ON CONFLICT (email) DO NOTHING;