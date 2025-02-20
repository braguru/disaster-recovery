#!/bin/bash

sudo apt-get update

sudo apt-get install -y nginx

systemctl start nginx

systemctl enable nginx

sudo nginx -v