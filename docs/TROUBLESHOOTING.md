# Troubleshooting — EpicBook on AWS

**Based on DMI Week 6, Assignment 2 (pages 11–33).**

| Symptom | Cause / recorded fix |
| --- | --- |
| SSH could not reach EC2 | Initially used a private subnet; deployed in public subnet, verified IGW route, public IP, and key permissions. |
| DNS / package failures | Checked NACL ephemeral traffic, route tables, public IP, and resolver settings. |
| `403 Forbidden` in Nginx | App had no static `public/index.html`; reverse-proxied requests to Node.js on port 8080. |
| Empty SQL initialization | Inspected SQL scripts; imported `author_seed.sql` followed by `books_seed.sql`. |
| Node worked on localhost but not externally | Verified HTTP inbound security-group rules and Nginx listening/proxy settings. |
| API test returned wrong response | Used the mounted route `/api/cart` and verified locally before testing from public IP. |

Quick diagnostic commands:

```bash
sudo nginx -t
sudo systemctl reload nginx
sudo ss -tulpn
curl http://127.0.0.1:8080/api/cart
curl http://localhost/api/cart
```

**Security:** Do not publish the app's live DB configuration, MySQL password, or EC2 private key. The original lab report includes historical IP/endpoint details; they are not promised to remain active.
