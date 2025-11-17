# Trends API (Portfolio Project)

![Ruby](https://img.shields.io/badge/Ruby-3.3.3-CC342D.svg?style=for-the-badge&logo=ruby)
![Rails](https://img.shields.io/badge/Rails-8.0.2-D30001.svg?style=for-the-badge&logo=rubyonrails)
![MongoDB](https://img.shields.io/badge/MongoDB-4.7.1-47A248.svg?style=for-the-badge&logo=mongodb)
![Docker](https://img.shields.io/badge/Docker-20.10.21-2496ED.svg?style=for-the-badge&logo=docker)

## Summary

This project is a RESTful API designed to extract and serve product trend data from the Google Shopping API. The application uses a decoupled import script (Rake task) to consume the SerpApi API, persists the data in a NoSQL database (MongoDB), and exposes it via a versioned JSON endpoint.

This project's goal is to demonstrate backend proficiency, external API integration, and data persistence using a modern, containerized stack.

---

## Tech Stack

* **Backend:** Ruby 3.3.3, Ruby on Rails 8.0.2 (API-only)
* **Database:** MongoDB
* **ODM (Object-Document Mapper):** Mongoid
* **External Data Source:** [SerpApi Google Shopping API](https://serpapi.com/)
* **Containerization:** Docker & Docker Compose

---

## 🏁 How to Run (5-Minute Setup)

This project is fully containerized. You only need **Git** and **Docker Compose** installed to run it.

### 1. Configuration

1.  Clone the repository:
    ```bash
    git clone [https://github.com/ADSJ-code/trends_api.git](https://github.com/ADSJ-code/trends_api.git)
    ```

2.  Enter the project directory:
    ```bash
    cd trends_api
    ```

3.  Create your environment file from the example:
    ```bash
    cp .env.example .env
    ```

4.  Edit the `.env` file and add your personal SerpApi API Key:
    ```bash
    nano .env
    ```
    (Paste `SERPAPI_API_KEY="YOUR_API_KEY_HERE"` and save the file)

### 2. Run the Application

Execute the single command below. This will build the images, start the services in detached mode (`-d`), and automatically run the database import task.

```bash
docker-compose up -d --build
```

Wait ~30 seconds for the docker-entrypoint.sh script to finish importing the data into the MongoDB container.

### 3. Test the API

```bash
curl -X GET http://localhost:3000/api/v1/trends/recent
```

Expected Output: You should see a JSON response with the imported shopping trends data.

[
  {
    "_id": {
      "$oid": "..."
    },
    "product_id": "...",
    "title": "Example Product Title",
    "price": "R$XX,XX",
    "link": "https://...",
    "source": "...",
    "created_at": "...",
    "updated_at": "..."
  }
]