# Đăng nhập và kết nối

Nguyên tắc: **chủ máy tự gõ mật khẩu / bấm đồng ý**. Người hỗ trợ và AI chỉ chỉ chỗ bấm.

Cách gọn nhất: **kết nối mọi thứ một lần trong Claude Desktop**. Javis (khi chạy model Claude Code) tự thấy các kết nối này, không phải làm lại.

## 1. Claude Desktop
1. Mở **Claude** → đăng nhập tài khoản Claude (gói trả phí).
2. **Settings → Connectors** (Cài đặt → Trình kết nối), bấm **Connect** từng cái, đăng nhập và bấm Cho phép:

| Kết nối | Dùng cho QLDA | Tài khoản |
|---|---|---|
| Google Drive | Đọc hồ sơ, bản vẽ PDF, biên bản, báo cáo trên Drive | Google công việc |
| Gmail | Tìm thư, tóm tắt, soạn nháp (AI không tự gửi) | Google công việc |
| Google Calendar | Lịch họp, lịch nghiệm thu, nhắc hạn | Google công việc |
| Miro | Đọc / vẽ sơ đồ tiến độ, sơ đồ tổ chức, brainstorm trên bảng Miro | Miro |
| GitHub | Lưu tài liệu / mẫu biểu của mình, đồng bộ giữa các máy | GitHub |

3. Mở tab **Code** một lần cho Claude Code đăng nhập cùng tài khoản.

## 2. Gemini
| Cách | Làm gì |
|---|---|
| Gemini trong Javis (Antigravity CLI) | Mở PowerShell mới, chạy `& "$env:LOCALAPPDATA\agy\bin\agy.exe"`, đăng nhập tài khoản Google trong cửa sổ hiện ra. Rồi Javis → **Models** → bật **Google Antigravity CLI** |
| Gemini trên web | Chrome → gemini.google.com → đăng nhập → menu ⋮ → **Cast, save and share → Install page as app** để có biểu tượng trên Desktop |

## 3. Javis OS
1. Bấm đúp **Javis OS** trên Desktop. Lần đầu: tạo tài khoản quản trị Javis (mật khẩu do chủ máy đặt).
2. **Models**: chọn **Claude Code** làm model chính → bấm Kết nối (dùng tài khoản Claude đã đăng nhập ở bước 1).
3. **Kết nối**: kéo xuống khối **◆ Kết nối sẵn của Claude Code** → phải thấy Google Drive, Gmail, Calendar, Miro, GitHub đã nối ở bước 1.
4. (Tùy chọn) Muốn Javis tự đọc / ghi Google Sheets, Docs khi chạy Gemini hoặc chạy ngầm: thẻ **Google → Google Workspace**, làm theo hướng dẫn trong cửa sổ (tạo OAuth client trên Google Cloud ~10 phút). Để mức **Ghi nháp**.
5. (Tùy chọn) Nhắn việc cho Javis qua Zalo / Telegram: trang **Kết nối** → Zalo Bot / Telegram, làm theo hướng dẫn trong cửa sổ.

## 4. Google Drive for desktop
Mở **Google Drive** (khay hệ thống) → đăng nhập tài khoản Google công việc. Drive hiện thành một ổ đĩa (thường là G:).

## 5. Kiểm tra cuối (hỏi thử trong Claude Desktop hoặc Javis)
| Hỏi | Phải ra |
|---|---|
| "Liệt kê 5 file mới nhất trong Google Drive của tôi" | Danh sách file thật |
| "Tuần này tôi có lịch gì?" | Lịch thật |
| "Tìm thư có chữ 'nghiệm thu' tuần trước" | Thư thật |
| "Liệt kê các bảng Miro của tôi" | Tên bảng Miro |
| "Tôi có những repo GitHub nào?" | Tên repo |
