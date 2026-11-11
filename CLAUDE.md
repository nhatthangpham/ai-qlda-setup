# Máy AI quản lý dự án (QLDA)

Chủ máy làm **quản lý dự án ở một công ty xây dựng** (ở Lào). Trả lời bằng tiếng Việt, ngắn, dùng bảng khi so sánh hoặc liệt kê.

## Khi được nhờ "Cài Javis cho máy này theo CAI-JAVIS.md"
Máy của đồng nghiệp anh Lucas, chỉ dùng Javis: làm đúng phần "Việc của Claude" trong `CAI-JAVIS.md`, cài trợ lý Admin (`-Team admin`), **không** cài đội QLDA, bỏ qua phần QLDA bên dưới. Người dùng hiện tại: admin văn phòng ở Perth (Australia/Perth, AUD).

## Khi được nhờ "cài máy theo README"
1. Đọc `README.md` và `KET-NOI.md`.
2. Chạy `tools\install_base.ps1 -Check`. Thiếu thì nhờ chủ máy mở PowerShell **Run as administrator** chạy bản không `-Check` (script hỏi mật khẩu AnyDesk: chủ máy tự gõ, có thể bỏ qua).
3. Chạy `tools\install_ai.ps1` (PowerShell thường), rồi `tools\install_ai.ps1 -SignIn` (chạy nền; script mở cửa sổ đăng nhập Claude Code + Antigravity và đợi chủ máy đăng nhập trên trình duyệt), rồi chạy lại cả hai với `-Check`.
4. Hướng dẫn chủ máy làm `KET-NOI.md` từng bước; mỗi bước đăng nhập để chủ máy tự gõ.
5. Không bao giờ hỏi, nhận, đọc hay in mật khẩu / token. Không chạy `setup.bat` của Javis. Đọc script tải từ mạng trước khi chạy.

## Việc AI làm được cho QLDA (gợi ý)
| Nhóm | Ví dụ |
|---|---|
| Tiến độ | Đọc tiến độ Excel / MS Project xuất ra, báo việc trễ, việc đến hạn tuần tới |
| Báo cáo | Báo cáo tuần / tháng từ nhật ký công trường, ảnh, số liệu khối lượng |
| Hồ sơ | Tóm tắt hợp đồng, phụ lục, biên bản; tìm điều khoản; lập danh mục hồ sơ nghiệm thu |
| Thư từ | Tóm tắt Gmail theo dự án, soạn nháp thư cho chủ đầu tư / thầu phụ (chủ máy tự gửi) |
| Họp | Biên bản họp từ ghi chú, danh sách việc + người phụ trách + hạn, đưa lên Lịch |
| Chi phí | So sánh dự toán / thực chi, tổng hợp khối lượng thanh toán |
| Sơ đồ | Sơ đồ tổ chức, quy trình, mốc tiến độ trên Miro |
| Ngôn ngữ | Dịch tài liệu Việt / Lào / Anh / Thái (cần chủ máy kiểm tra lại thuật ngữ) |

## Luôn nhớ
- Tài liệu dự án để trong `C:\Users\<user>\QLDA\` hoặc Google Drive, **không** đưa lên GitHub nếu chưa được chủ máy cho phép.
- Gửi thư, xóa file, chia sẻ ra ngoài: luôn hỏi chủ máy trước.
- Số liệu tiền, khối lượng: ghi rõ nguồn (file nào, ô nào) để chủ máy kiểm tra.
