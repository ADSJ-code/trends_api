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

## 🏁 How to Run (Docker)

This project is fully containerized. You only need Docker and Docker Compose installed to run it.

### 1. Configuration

1.  Clone the repository:
    ```bash
    git clone [https://github.com/ADSJ-code/trends_api.git](https://github.com/ADSJ-code/trends_api.git)
    cd trends_api
    ```

2.  Create your environment file:
    ```bash
    cp .env.example .env
    ```

3.  Edit the `.env` file and add your personal SerpApi API Key:
    ```bash
    nano .env
    ```
    ```
    SERPAPI_API_KEY="YOUR_API_KEY_HERE"
    ```

### 2. Run the Application

With Docker running, execute the following commands in your terminal:

```bash
# 1. Build the images (This may take a few minutes the first time)
docker-compose build

# 2. Start all services (API + DB)
docker-compose up