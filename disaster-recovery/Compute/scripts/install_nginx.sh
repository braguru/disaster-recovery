#!/bin/bash

sudo apt-get update

sudo apt-get install -y nginx

sudo nginx -v

cat <<EOT > /etc/nginx/sites-available/default
    server {
        listen 80;
        server_name chrisncs.guruworld.click;

        location / {
            proxy_pass http://127.0.0.1:3123;  # Change if running another backend
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }
    }
EOT

sudo systemctl restart nginx

sudo systemctl enable nginx
