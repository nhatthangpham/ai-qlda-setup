# Đăng nhập và kết nối

Nguyên tắc: **chủ máy tự gõ mật khẩu / bấm đồng ý**. Người hỗ trợ và AI chỉ chỉ chỗ bấm.

Hai cổng, nối cả hai:
| Cổng | Cho ai dùng |
|---|---|
| **Claude Desktop → Connectors** (mục 1) | Claude Desktop, Claude Code |
| **Composio** (mục 3a) | **Javis**: mọi model kể cả Gemini, việc chạy ngầm, việc theo lịch, Zalo bot |

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
2. **Models**: chọn **Claude Code** làm model chính → bấm Kết nối (dùng tài khoản Claude đã đăng nhập ở bước 1). Thêm **Google Antigravity CLI** (Gemini).
3. Nối Javis vào các app qua **Composio** (mục 3a). Đây là cổng chính của Javis: mọi model (Claude, Gemini...) và mọi việc chạy ngầm / theo lịch đều dùng được.
4. (Tùy chọn) Nhắn việc cho Javis qua Zalo / Telegram: trang **Kết nối** → Zalo Bot / Telegram, làm theo hướng dẫn trong cửa sổ.

### 3a. Cổng Composio (một kết nối mở ra nhiều app)
**Trên composio.dev** (chủ máy đăng nhập bằng tài khoản Google công việc):
1. Vào **composio.dev** → đăng ký / đăng nhập.
2. **For You → Connect Apps**: bấm nối từng app, đăng nhập và bấm Cho phép:

| App trong Composio | Dùng cho QLDA |
|---|---|
| Google Drive | Hồ sơ, bản vẽ PDF, biên bản |
| Gmail | Tìm thư, tóm tắt, soạn nháp |
| Google Calendar | Lịch họp, nghiệm thu, nhắc hạn |
| Google Sheets | Bảng tiến độ, khối lượng, chi phí |
| Google Docs | Báo cáo, biên bản |
| Miro | Bảng sơ đồ tiến độ, tổ chức |
| GitHub | Lưu mẫu biểu, đồng bộ |

3. **For You → Connect my agent** → copy **consumer key** (bắt đầu bằng `ck_`).
   Lưu ý: KHÔNG dùng *Project API key* (`ak_...`) hay MCP server tạo trong mục Platform; đó là luồng khác, Javis không nhận.

**Trong Javis:**
4. Trang **Kết nối** → **Kho kết nối** → nhóm **Kho ứng dụng** → thẻ **Composio** → **Kết nối**.
5. Chủ máy **tự dán** key `ck_...` vào ô, bấm Lưu → **Kiểm tra** phải xanh. (Không dán key vào chat, không lưu vào file.)
6. Quyền: mặc định **Chỉ đọc** (Javis đọc được dữ liệu mọi app đã nối, lệnh nào không chắc là đọc thì bị chặn). Muốn Javis tạo lịch, soạn nháp thư, ghi Sheets, vẽ Miro thì nâng **Toàn quyền**, nhưng khi đó Javis làm được MỌI hành động trên các app đã nối, kể cả gửi thư, xóa file. Khuyên: để **Chỉ đọc** tuần đầu, quen rồi mới nâng.
7. Nối thêm app sau này: chỉ cần làm bước 2 trên composio.dev, Javis tự thấy, không phải dán lại key. Đổi key thì bấm **Kết nối lại** trên thẻ Composio rồi **Kiểm tra**.

### 3b. Kiểm tra Composio trong Javis
Chat trong Javis: *"Qua Composio, liệt kê các tài khoản / app đã nối"* → phải ra Drive, Gmail, Calendar, Sheets, Docs, Miro, GitHub.

## 4. Google Drive for desktop
Mở **Google Drive** (khay hệ thống) → đăng nhập tài khoản Google công việc. Drive hiện thành một ổ đĩa (thường là G:).

## 5. Kiểm tra cuối (hỏi thử cả trong Claude Desktop lẫn Javis)
| Hỏi | Phải ra |
|---|---|
| "Liệt kê 5 file mới nhất trong Google Drive của tôi" | Danh sách file thật |
| "Tuần này tôi có lịch gì?" | Lịch thật |
| "Tìm thư có chữ 'nghiệm thu' tuần trước" | Thư thật |
| "Liệt kê các bảng Miro của tôi" | Tên bảng Miro |
| "Tôi có những repo GitHub nào?" | Tên repo |
