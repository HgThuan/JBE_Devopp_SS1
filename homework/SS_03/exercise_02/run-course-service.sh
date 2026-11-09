#!/bin/bash
# Kịch bản khởi chạy Docker container cho rikkei-course-service
# Cấu hình:
# - Image: nginxdemos/hello
# - Detached mode: -d
# - Tên container: rikkei-course-service
# - Port mapping: 8081 (host) -> 80 (container)

echo ">>> Bắt đầu khởi chạy container rikkei-course-service..."

docker run -d \
  --name rikkei-course-service \
  -p 8081:80 \
  nginxdemos/hello

echo ">>> Khởi chạy thành công! Kiểm tra trạng thái container:"
docker ps --filter "name=rikkei-course-service"

echo ">>> Kiểm tra phản hồi HTTP từ cổng 8081:"
curl -I http://localhost:8081
