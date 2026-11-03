#!/bin/bash
# ==============================================================================
# Script Name : initial-script.sh
# Description : Tự động hóa cài đặt môi trường ban đầu và tạo system user QuickBite
# ==============================================================================

# Thoát script ngay lập tức nếu có lệnh nào bị lỗi
set -e

# Đặt biến môi trường tránh các popup tương tác khi chạy apt trên Ubuntu
export DEBIAN_FRONTEND=noninteractive

echo "=========================================================="
echo " [1/4] Cập nhật danh sách gói và nâng cấp hệ thống..."
echo "=========================================================="
apt-get update && apt-get upgrade -y

echo "=========================================================="
echo " [2/4] Cài đặt openjdk-17-jdk, git, curl..."
echo "=========================================================="
apt-get install -y openjdk-17-jdk git curl

echo "=========================================================="
echo " [3/4] Kiểm tra và tạo group 'quickbite'..."
echo "=========================================================="
if getent group quickbite > /dev/null 2>&1; then
    echo ">> Group 'quickbite' đã tồn tại."
else
    groupadd quickbite
    echo ">> Đã tạo thành công group 'quickbite'."
fi

echo "=========================================================="
echo " [4/4] Kiểm tra và tạo system user 'quickbite'..."
echo "=========================================================="
if id -u quickbite > /dev/null 2>&1; then
    echo ">> User 'quickbite' đã tồn tại."
else
    # -r: Tạo system user (không tạo thư mục home)
    # -g: Gán vào primary group quickbite
    # -s /bin/false: Khóa quyền đăng nhập trực tiếp bằng shell
    useradd -r -g quickbite -s /bin/false quickbite
    echo ">> Đã tạo thành công system user 'quickbite' với shell /bin/false."
fi

echo "=========================================================="
echo " HOÀN TẤT THIẾT LẬP MÔI TRƯỜNG!"
echo "=========================================================="
