#!/bin/bash
# Kịch bản trích xuất log của container rikkei-course-service
# Yêu cầu:
# - Lấy chính xác 15 dòng cuối cùng: --tail 15
# - Bắt buộc gắn kèm mốc thời gian: -t (--timestamps)

docker logs --tail 15 -t rikkei-course-service
