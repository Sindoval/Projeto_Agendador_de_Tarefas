# 🚀 Agendador de Tarefas Microservices

Este projeto é um ecossistema de microserviços desenvolvido em Java com Spring Boot, projetado para gerenciar, agendar e notificar usuários sobre tarefas pendentes. A arquitetura utiliza bancos de dados relacionais e não-relacionais, além de um BFF (Backend For Frontend) para orquestrar as comunicações.

## 🏗️ Arquitetura do Sistema

A aplicação é dividida nos seguintes módulos:

* **BFF Agendador:** Ponto central de entrada que orquestra as chamadas entre os serviços e executa tarefas agendadas (Cron).
* **Usuário Service:** Gerencia o cadastro e autenticação de usuários (PostgreSQL).
* **Agendador de Tarefas:** Responsável pelo CRUD de tarefas e persistência (MongoDB).
* **Comunicação:** Gerencia o histórico e lógica de envio de mensagens (PostgreSQL).
* **Notificação:** Serviço especializado no envio de e-mails via SMTP.



---

## 🛠️ Tecnologias Utilizadas

* **Java 17 / Spring Boot 3**
* **PostgreSQL 15** (Dados relacionais)
* **MongoDB** (Dados não-relacionais/Tarefas)
* **Feign Client** (Comunicação HTTP entre serviços)
* **Docker & Docker Compose** (Containerização)
* **Spring Security & BCrypt** (Segurança)

---

## 🚀 Como Iniciar

### 1. Pré-requisitos
* Docker e Docker Compose instalados.
* Uma conta Gmail com "Senha de App" gerada (para o serviço de notificação).

### 2. Configuração de Variáveis de Ambiente
Crie um arquivo chamado `.env` na raiz do projeto e preencha com base no exemplo abaixo:

```env
# Configurações de E-mail (SMTP Gmail)
EMAIL_USERNAME=seu-email@gmail.com
EMAIL_PASSWORD=sua-senha-de-app
EMAIL_REMETENTE=seu-email@gmail.com

# Configurações de Banco de Dados
DB_PASSWORD=sua_senha_segura

```
## 🔐 Configuração Obrigatória: Usuário Administrador

Esta aplicação utiliza um sistema de segurança baseado em **Spring Security** e **BCrypt**. Para que o ecossistema funcione corretamente, especialmente as rotinas automáticas, você deve criar um usuário inicial.

### Por que criar o usuário 'Admin'?
O serviço `bff-agendador` possui um processo agendado (**Cron**) que roda periodicamente para buscar tarefas e disparar notificações. Para realizar essa operação, o sistema tenta se autenticar automaticamente no serviço de usuários utilizando as seguintes credenciais:

* **E-mail:** `admin@admin.com`
* **Senha:** `123456`

**Atenção:** Se este usuário não for criado, o Cron apresentará erros de autenticação nos logs e as notificações por e-mail não serão enviadas.



### Como criar o usuário administrador
Como as senhas precisam ser criptografadas via aplicação para serem válidas, não recomendamos a inserção manual via SQL. Após subir os containers, execute o comando abaixo no seu terminal para registrar o administrador:

```bash
curl --location 'http://localhost:8081/usuario' \
--header 'Content-Type: application/json' \
--data-raw '{
    "nome": "Admin",
    "email": "admin@admin.com",
    "senha": "123"
}'
