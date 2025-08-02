# Trends API

![Ruby](https://img.shields.io/badge/Ruby-3.3.3-CC342D.svg?style=for-the-badge&logo=ruby)
![Rails](https://img.shields.io/badge/Rails-8.0.2-D30001.svg?style=for-the-badge&logo=rubyonrails)
![MongoDB](https://img.shields.io/badge/MongoDB-4.7.1-47A248.svg?style=for-the-badge&logo=mongodb)
![Docker](https://img.shields.io/badge/Docker-20.10.21-2496ED.svg?style=for-the-badge&logo=docker)

## Sumário

Este projeto consiste numa API RESTful desenvolvida para extrair e servir dados de tendências de produtos a partir do Google Shopping. A aplicação utiliza um script de importação para consumir a API da SerpApi, persistindo os dados em um banco de dados NoSQL (MongoDB), e os expõe através de um endpoint JSON versionado.

O objetivo principal deste projeto é demonstrar proficiência em desenvolvimento backend, integração com APIs externas e persistência de dados, utilizando uma stack tecnológica alinhada com as melhores práticas de mercado.

---

## Arquitetura do Sistema

O sistema opera através de uma Rake task desacoplada, responsável pela ingestão de dados. Esta tarefa conecta-se ao serviço da SerpApi, busca os resultados de produtos, e os persiste como documentos numa base de dados MongoDB. A aplicação Rails, por sua vez, expõe estes dados através de um endpoint JSON API versionado. Este design separa a coleta de dados da sua exposição, permitindo que cada processo seja escalado ou mantido de forma independente.

---

## Stack de Tecnologias

* **Backend:** Ruby 3.3.3, Ruby on Rails 8.0.2 (API-only)
* **Banco de Dados:** MongoDB
* **ODM (Object-Document Mapper):** Mongoid
* **Servidor Web:** Puma
* **Fonte de Dados Externos:** [SerpApi Google Shopping API](https://serpapi.com/)
* **Ambiente de Desenvolvimento:** Docker (para o serviço MongoDB)

---

## Pré-requisitos

Para executar este projeto localmente, certifique-se de que possui:
* Ruby (gerenciado via `rbenv` ou similar)
* Bundler
* Docker Desktop
* Uma chave de API da [SerpApi](https://serpapi.com/)

---

## Configuração e Instalação

Siga os passos abaixo para configurar o ambiente de desenvolvimento.

1.  **Clone o repositório:**
    ```bash
    git clone [https://github.com/ADSJ-code/trends_api.git](https://github.com/ADSJ-code/trends_api.git)
    ```

2.  **Navegue para o diretório do projeto:**
    ```bash
    cd trends_api
    ```

3.  **Instale as dependências do Ruby:**
    ```bash
    bundle install
    ```

4.  **Configure as credenciais:**
    Este projeto requer uma chave de API da SerpApi. Execute o comando abaixo para abrir o editor de credenciais do Rails:
    ```bash
    bin/rails credentials:edit
    ```
    Insira sua chave no seguinte formato e salve o arquivo:
    ```yaml
    serpapi:
      api_key: "SUA_CHAVE_DA_SERPAPI_AQUI"
    ```

5.  **Inicie o serviço do MongoDB via Docker:**
    ```bash
    docker run --name mongodb -d -p 27017:27017 mongo
    ```

---

## Utilização

### 1. Importação de Dados
Para popular o banco de dados com os produtos do Google Shopping, execute a Rake task de importação:
```bash
bin/rails importer:shopping
```

### 2. Iniciar o Servidor da API
Com os dados no banco, inicie o servidor Rails:
```bash
bin/rails server
```
A API estará disponível na porta `3000`, acessível em `http://localhost:3000`.

---

## Documentação da API

### Listar Produtos

Retorna uma lista de todos os produtos importados que estão na base de dados.

* **Endpoint:** `GET /api/v1/products`
* **Resposta de Sucesso (200 OK):**

    ```json
    [
      {
        "_id": {
          "$oid": "688e8ff96df9188ffb9cc59d"
        },
        "created_at": "2025-08-02T22:23:53.799Z",
        "updated_at": "2025-08-02T22:23:53.799Z",
        "title": "Meta Quest 3S All-in-One Headset",
        "link": null,
        "price": "$299.99",
        "rating": 4.5,
        "reviews": 6300,
        "thumbnail": "[https://serpapi.com/searches/688e8f4dcc56d3c8e2d0fded/images/](https://serpapi.com/searches/688e8f4dcc56d3c8e2d0fded/images/)...",
        "source": "Electronic Express"
      }
    ]