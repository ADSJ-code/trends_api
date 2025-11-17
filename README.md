# Trends API (Portfolio Project)

![Ruby](https://img.shields.io/badge/Ruby-3.3.3-CC342D.svg?style=for-the-badge&logo=ruby)
![Rails](https://img.shields.io/badge/Rails-8.0.2-D30001.svg?style=for-the-badge&logo=rubyonrails)
![MongoDB](https://img.shields.io/badge/MongoDB-4.7.1-47A248.svg?style=for-the-badge&logo=mongodb)
![Docker](https://img.shields.io/badge/Docker-20.10.21-2496ED.svg?style=for-the-badge&logo=docker)

## Summary

This project is a RESTful API designed to extract and serve product trend data from the Google Shopping API. The application consumes the SerpApi API, persists the data in a NoSQL database (MongoDB), and exposes it via a versioned JSON endpoint.

## Tech Stack

* **Backend:** Ruby 3.3.3, Ruby on Rails 8.0.2 (API-only)
* **Database:** MongoDB
* **External Data Source:** [SerpApi Google Shopping API](https://serpapi.com/)
* **Containerization:** Docker & Docker Compose

---

## 🏁 How to Run (5-Minute Setup)

This project is fully containerized. You only need **Git** and **Docker Compose** installed to run it.

### 1. Configuration

1.  Clone the repository:
    ```bash
    git clone https://github.com/ADSJ-code/trends_api.git
    ```

2.  Enter the project directory:
    ```bash
    cd trends_api
    ```

3.  Create your environment file:
    ```bash
    cp .env.example .env
    ```

4.  Edit the `.env` file and add your `SERPAPI_API_KEY`.

### 2. Run the Application

Execute the single command below. This will build the images and start the services (API + DB).

```bash
docker-compose up -d --build
```

Wait ~1 minute for the build and for the services to boot.

### 3. Import Data (Required)

The API is running, but the database is empty. Run the following command to populate the MongoDB database with data from SerpApi.

```bash
docker-compose exec app rake importer:shopping
```

You should see an output: "🤖 Starting product import robot..."

### 4. Test the API

Now that the data is imported, test the main endpoint using curl:

```bash
curl -X GET http://localhost:3000/api/v1/trends/recent
```

Expected Output: You should see a JSON response with the imported shopping trends data.

```json
    [
      {
        "_id": {
          "$oid": "..."
        },
        "product_id": "product_XYZ",
        "title": "Example Product Title",
        "price": "R$199,99",
        "link": "[https://example.com/product/123](https://example.com/product/123)",
        "source": "Google Shopping",
        "created_at": "2025-11-17T15:00:00Z",
        "updated_at": "2025-11-17T15:00:00Z"
      }
    ]