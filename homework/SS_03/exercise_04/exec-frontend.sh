#!/bin/bash
# Kịch bản khởi chạy container rikkei-frontend-qa và kiểm tra biến môi trường
# Yêu cầu:
# - Image: nginx
# - Tên container: rikkei-frontend-qa
# - Biến môi trường: API_ENDPOINT=https://qa-api.rikkei.edu.vn
# - Lệnh truy cập shell kiểm tra: docker exec -it rikkei-frontend-qa bash

echo ">>> 1. Khởi chạy container rikkei-frontend-qa với biến môi trường..."
docker run -d \
  --name rikkei-frontend-qa \
  -e API_ENDPOINT=https://qa-api.rikkei.edu.vn \
  nginx

echo ">>> 2. Kiểm tra container trong danh sách docker ps:"
docker ps --filter "name=rikkei-frontend-qa"

echo ">>> 3. Đăng nhập vào shell container và in biến môi trường API_ENDPOINT:"
docker exec rikkei-frontend-qa bash -c 'echo "API_ENDPOINT: $API_ENDPOINT"'
