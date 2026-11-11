# Cài nhanh Javis cho đồng nghiệp (máy dùng AI của anh Lucas)

Người dùng chỉ trò chuyện trên **Javis**. Não AI (Claude, Antigravity) đăng nhập bằng tài khoản của anh Lucas. Không cài đội QLDA.
Tổng thời gian: khoảng 30–40 phút. Anh Lucas ngồi máy (hoặc AnyDesk) để bấm Yes và tự gõ mật khẩu.

## Bước 1. Claude Desktop (anh Lucas làm, 5')
1. Cài Claude Desktop: tải ở **claude.ai/download**, mở file, cài.
2. Mở Claude, đăng nhập tài khoản của anh Lucas.
3. Tạo thư mục trống `C:\Users\<user>\setup`. Trong Claude chọn tab **Code** → chọn thư mục đó.
4. Dán đúng câu này vào Claude:

> Cài Javis cho máy này theo repo https://github.com/nhatthangpham/ai-qlda-setup, file CAI-JAVIS.md, phần "Việc của Claude". Không cài đội QLDA.

Từ đây Claude tự làm. Claude dừng lại khi cần anh Lucas: bấm **Yes** ở hộp hỏi quyền Admin, đăng nhập GitHub, đăng nhập Claude Code, đăng nhập Antigravity.

## Bước 2. Nối Javis với não AI (Claude làm phần lớn, anh Lucas bấm đăng nhập)
| Não | Cách nối | Ai làm |
|---|---|---|
| Claude (não chính) | Javis tự dùng **Claude Code** khi Claude Code đã đăng nhập. Claude mở cửa sổ `claude` → gõ `/login` → trình duyệt mở → anh Lucas bấm **Authorize** | Claude mở, anh Lucas đăng nhập |
| Antigravity (Gemini) | Claude mở `agy.exe` → trình duyệt mở → anh Lucas chọn tài khoản Google. Rồi Javis → **Models** → bật thẻ **Google Antigravity CLI** | Claude mở, anh Lucas đăng nhập và bật thẻ |

Kiểm: Javis → **Models**: Claude Code là **model chính** (MAIN), Antigravity có đèn xanh. Không được thì anh Lucas làm tay trên trang Models.

## Bước 3. Giao máy cho đồng nghiệp (5')
1. Mở **Javis OS** (biểu tượng trên Desktop), tạo tài khoản admin của Javis cho đồng nghiệp: **đồng nghiệp tự đặt mật khẩu**.
2. Hướng dẫn: gõ câu hỏi vào ô chat của Javis như nhắn tin. Ví dụ: "Tóm tắt file này", "Viết email xin báo giá", "Dịch đoạn này sang tiếng Anh".
3. Đăng xuất GitHub trên máy này (Claude làm, xem dưới). Claude Desktop: tùy anh Lucas giữ hay đăng xuất (đồng nghiệp chỉ cần Javis).

---

## Việc của Claude (khi được nhờ "Cài Javis cho máy này theo CAI-JAVIS.md")
1. Kiểm `git`: chưa có thì `winget install --id Git.Git -e --accept-source-agreements --accept-package-agreements` (máy hỏi quyền thì nhờ anh Lucas bấm Yes), rồi mở lại PATH.
2. Clone repo vào `C:\Users\<user>\ai-qlda-setup` (repo Private: Git mở trình duyệt, **anh Lucas tự đăng nhập GitHub**; Claude không hỏi, không nhận mật khẩu / mã).
3. Phần mềm nền (cần Admin): chạy
   `Start-Process powershell -Verb RunAs -ArgumentList '-NoExit','-ExecutionPolicy','Bypass','-File','<repo>\tools\install_base.ps1','-NoOptional'`
   Nhờ anh Lucas bấm **Yes**. Script hỏi mật khẩu AnyDesk: anh Lucas tự quyết (gõ hoặc bỏ qua). Xong thì Claude chạy `install_base.ps1 -Check`.
4. Javis + não AI (PowerShell thường): `powershell -ExecutionPolicy Bypass -File <repo>\tools\install_ai.ps1 -NoTeam`. Chạy lâu (pip vài phút): chạy nền rồi đợi.
5. Đăng nhập não AI theo bảng Bước 2: mở cửa sổ terminal mới cho `claude` và `agy.exe`, báo anh Lucas làm phần trình duyệt. Rồi mở Javis (`http://127.0.0.1:7777`) và nhờ anh Lucas kiểm trang **Models**.
6. Chạy lại `install_ai.ps1 -Check -NoTeam`; báo bảng kết quả.
7. Đăng xuất GitHub khỏi máy: `cmdkey /list | findstr github`, xóa từng mục bằng `cmdkey /delete:<tên>` (hỏi anh Lucas trước khi xóa).

**Không làm:** không chạy `setup.bat` của Javis; không đọc / in `~\.javis\config.json` hay file đăng nhập; không hỏi, nhận, gõ mật khẩu / token; không cài đội QLDA (`-NoTeam`).
