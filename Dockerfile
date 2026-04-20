# ---------- Stage 1: Build ----------
FROM node:18 AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .



# ---------- Stage 2 ----------
FROM node:18-slim

WORKDIR /app

RUN apt-get update && apt-get install -y netcat-openbsd

COPY --from=builder /app /app

RUN npm install --omit=dev

EXPOSE 8080

CMD ["sh", "-c", "until nc -z db 3306; do echo waiting for db; sleep 2; done; node server.js"]
