# Deployment Record — EpicBook on AWS

**DMI Week 6, Assignment 2 (pages 11–33).** This is a concise record of the actual lab; credentials and full original server configuration are intentionally omitted.

### 1. Network and security

- Created VPC **`epicbook-vpc`** (`10.0.0.0/16`).
- Placed Ubuntu EC2 in public subnet **`10.0.1.0/24`**, with Internet Gateway routing and a public IPv4 address.
- Reserved private subnet **`10.0.2.0/24`** for the RDS database; **RDS public access disabled**.
- EC2 security group permitted HTTP 80, HTTPS 443 as configured, and SSH 22 restricted to the administrator's IP.
- RDS security group accepted MySQL 3306 only from the EC2 security group.

### 2. Install and run EpicBook

- Connected to the EC2 instance via SSH.
- Installed Node.js, npm, Nginx and MySQL client on Ubuntu.
- Cloned the supplied EpicBook app and ran `npm install`.
- Configured the application's database connection and ran its Node/Express server on **8080**.
- Set Nginx to proxy port **80** to **`http://127.0.0.1:8080`**; the application renders dynamic views and has no standalone `public/index.html`.

An **illustrative** reverse-proxy block, not an exact exported config:

```nginx
server {
    listen 80;
    server_name _;
    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

### 3. RDS MySQL

- Created a non-public Amazon RDS MySQL instance and connected it to the EpicBook app using the appropriate database settings.
- Initialized **`bookstore`** and imported SQL in dependency order: **`author_seed.sql`**, then **`books_seed.sql`**.
- Verified database tables and application connectivity using MySQL client and API requests.
- The report notes `BuyTheBook_Schema.sql` was empty; the seed files supplied the statements needed for this lab.

### 4. Validation

```bash
sudo nginx -t
sudo systemctl status nginx
ss -tulpn | grep 8080
curl http://127.0.0.1:8080/api/cart
curl http://localhost/api/cart
```

The report records a successfully loading EpicBook website and end-to-end `/api/cart` testing. These commands are reference checks, not proof of a currently running instance.

**Excluded from scope:** the PHP hit counter, WordPress, ALB, Auto Scaling and failover tests in Assignment 3 (pages 34–59).
