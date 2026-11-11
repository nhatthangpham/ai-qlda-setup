---
type: user
provenance: user
origin: setup-kit
created: 2026-11-11
updated: 2026-11-11
---
# Yêu cầu: platform quản lý thiết bị, CCDC và bàn giao công trình

Đây là yêu cầu gốc chủ máy gửi trước khi cài (10/11/2026). Nhân viên `qlda-thiet-bi` đọc file này trước khi làm.

## 1. Tính năng tự động
- Tự cấp mã thiết bị và mã CCDC.
- Tự tính tổng nguyên giá và giá trị còn lại.
- Theo dõi trạng thái: đang sử dụng, dự phòng, hỏng, chờ sửa chữa.
- Cảnh báo thiết bị đến hạn bảo trì.
- Theo dõi lịch sử điều chuyển giữa các phòng ban.
- Báo cáo kiểm kê và thống kê theo bộ phận.
- Dashboard biểu đồ trực quan.

## 2. Trường thông tin
**Danh mục thiết bị, CCDC:** mã tài sản / CCDC; tên thiết bị; nhóm thiết bị; hãng sản xuất, model, số serial; ngày mua, nhà cung cấp; nguyên giá, thời gian sử dụng; bộ phận quản lý; tình trạng thiết bị.

**Bàn giao công trình:** mã công trình; tên công trình; mã thiết bị; ngày xuất đi; người giao, người nhận; số lượng; tình trạng khi bàn giao; ngày dự kiến thu hồi.

## 3. Dashboard quản trị (tự tổng hợp)
1. Tổng số thiết bị và CCDC.
2. Tổng nguyên giá tài sản.
3. Số thiết bị đang sử dụng.
4. Số thiết bị tại kho.
5. Số thiết bị tại từng công trình.
6. Số thiết bị hư hỏng, chờ sửa chữa.
7. Thiết bị đến hạn bảo trì.
8. Thiết bị chưa thu hồi.

## 4. Mô hình quản lý (chủ máy xác nhận; dòng nào còn "giả định" thì hỏi lại trước khi thiết kế)
| Câu hỏi | Lựa chọn | Trả lời |
|---|---|---|
| Quy mô công ty | Nhỏ (<3 công trình) / Vừa (3–10) / Lớn (>10) | Giả định: Vừa |
| Phạm vi quản lý | Chỉ máy móc / Chỉ CCDC / Cả hai | Giả định: Cả hai |
| Theo dõi khấu hao, phân bổ CCDC | Có / Không (chỉ hiện vật, số lượng) | Giả định: Có (máy móc khấu hao đường thẳng, CCDC phân bổ theo tháng) |
| Mức tự động hóa | Cơ bản (nhập liệu, báo cáo) / Nâng cao (công thức, cảnh báo, dashboard) | Giả định: Nâng cao |

## 5. Dữ liệu thật
- Danh sách thiết bị hiện có: (chưa có; chủ máy đưa file Excel / ảnh vào Drive rồi ghi đường dẫn ở đây)
- Danh sách công trình: (chưa có)
- Danh sách phòng ban / bộ phận: (chưa có)
- Đơn vị tiền tệ: (xem `facts/ho-so-chu-may.md`)
