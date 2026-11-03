# Báo cáo thực hành: Phân quyền thư mục dịch vụ QuickBite (Least Privilege)

## 1. Các lệnh thực thi trên hệ điều hành Linux (VPS)

```bash
# 1. Tạo thư mục làm việc cho user-service (bao gồm các thư mục cha nếu chưa có)
sudo mkdir -p /opt/quickbite/user-service

# 2. Thay đổi quyền sở hữu cho user quickbite và group quickbite đệ quy (-R)
sudo chown -R quickbite:quickbite /opt/quickbite

# 3. Phân quyền truy cập 750 cho thư mục /opt/quickbite
sudo chmod 750 /opt/quickbite

# (Tùy chọn) Phân quyền đệ quy cho cả thư mục con bên trong
sudo chmod -R 750 /opt/quickbite
```

---

## 2. Kiểm tra kết quả phân quyền

Chạy lệnh kiểm tra thuộc tính thư mục `/opt`:

```bash
ls -la /opt
```

### Kết quả mong đợi:
```text
drwxr-x--- 3 quickbite quickbite 4096 Nov  3 23:50 quickbite
```

---

## 3. Giải thích chi tiết ý nghĩa mã phân quyền `750` (`drwxr-x---`)

Mã phân quyền `750` trong hệ thống Linux biểu diễn bằng hệ bát phân (Octal), tương ứng với 3 nhóm đối tượng: **Owner (Chủ sở hữu)** - **Group (Nhóm)** - **Others (Những người dùng khác)**.

| Đối tượng | Giá trị số | Ký hiệu | Ý nghĩa chi tiết |
| :--- | :---: | :---: | :--- |
| **User (Owner)** | **7** | `rwx` | `4 (Read) + 2 (Write) + 1 (Execute)`: User `quickbite` có toàn quyền đọc mã nguồn, ghi/sửa đổi file, và thực thi/truy cập vào thư mục. |
| **Group** | **5** | `r-x` | `4 (Read) + 0 + 1 (Execute)`: Các thành viên thuộc nhóm `quickbite` có quyền xem nội dung và truy cập thư mục, nhưng **không có quyền** ghi hoặc sửa đổi file. |
| **Others** | **0** | `---` | `0 + 0 + 0`: Bất kỳ tài khoản nào khác trên hệ thống **hoàn toàn không có quyền** đọc, ghi hay truy cập vào thư mục này. |

### Ứng dụng nguyên tắc Least Privilege (Đặc quyền tối thiểu):
- **Ngăn chặn rò rỉ dữ liệu nhạy cảm:** File cấu hình Spring Boot (như `application.yml` chứa DB credentials, JWT Secret Key...) được bảo vệ tuyệt đối, người dùng khác hoặc các tiến trình lạ không thể đọc trộm.
- **Cách ly môi trường:** Chỉ duy nhất process chạy dưới danh nghĩa user `quickbite` mới có quyền vận hành file JAR và ghi log, giúp hạn chế tối đa phạm vi ảnh hưởng nếu một dịch vụ khác trên server bị tấn công.
