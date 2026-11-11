# Cài nhanh Javis cho đồng nghiệp (máy dùng AI của anh Lucas)

Người dùng chỉ trò chuyện trên **Javis**. Não AI (Claude, Antigravity) đăng nhập bằng tài khoản của anh Lucas. Cài **trợ lý Admin** (1 nhân viên: email, văn bản, lịch, bảng tính, biểu mẫu, dịch Anh–Việt), không cài đội QLDA.
Tổng thời gian: khoảng 30–40 phút. Anh Lucas ngồi máy (hoặc AnyDesk) để bấm Yes và tự gõ mật khẩu.

**Đồng nghiệp hiện tại:** admin văn phòng TG ở **Perth (WA)**. Giờ Perth = UTC+8, **sớm hơn Việt Nam 1 tiếng**, không đổi giờ mùa hè. Hẹn giờ cài theo giờ Perth. Làm qua AnyDesk thì cô ấy cài AnyDesk trước (anydesk.com → Download → Install), gửi ID cho anh.

## Bước 0. GitHub của cô ấy (làm trước, 5')
1. Cô ấy tạo tài khoản ở **github.com** → Sign up (dùng email công việc), gửi anh **tên tài khoản** (không gửi mật khẩu).
2. Anh mời: repo `ai-qlda-setup` → **Settings → Collaborators → Add people** → gõ tên tài khoản của cô ấy.
3. Cô ấy mở thư mời trong email → **Accept invitation**.

Lưu ý: repo cá nhân thì người được mời có quyền ghi (sửa được repo). Muốn chỉ cho đọc thì phải chuyển repo vào một Organization.

## Bước 1. Claude Desktop (anh Lucas làm, 5')
1. Cài Claude Desktop: tải ở **claude.ai/download**, mở file, cài.
2. Mở Claude, đăng nhập tài khoản của anh Lucas.
3. Tạo thư mục trống `C:\Users\<user>\setup`. Trong Claude chọn tab **Code** → chọn thư mục đó.
4. Dán đúng câu này vào Claude:

> Cài Javis cho máy này theo repo https://github.com/nhatthangpham/ai-qlda-setup, file CAI-JAVIS.md, phần "Việc của Claude". Cài trợ lý Admin (-Team admin), không cài đội QLDA.

Từ đây Claude tự làm. Claude dừng lại khi cần: bấm **Yes** ở hộp hỏi quyền Admin, **cô ấy** đăng nhập GitHub của cô ấy, anh Lucas đăng nhập Claude Code và Antigravity.

## Bước 2. Nối Javis với não AI (script tự mở, anh Lucas bấm đăng nhập)
Một lệnh lo cả hai não: `install_ai.ps1 -SignIn -Team admin`. Script tự mở cửa sổ đăng nhập cho não nào chưa đăng nhập, **đợi** (tối đa 10 phút mỗi não) rồi báo OK.

| Não | Script làm | Anh Lucas làm |
|---|---|---|
| Claude (não chính) | Mở cửa sổ `claude auth login` → trình duyệt mở trang Claude | Đăng nhập tài khoản Claude → bấm **Authorize** |
| Antigravity (Gemini) | Mở cửa sổ `agy.exe` (phóng to) → trình duyệt mở trang Google | Chọn tài khoản Google → **Allow**. **Đừng đóng cửa sổ agy** trước khi trình duyệt báo xong (đóng là hủy đăng nhập). Không thấy trình duyệt: Ctrl + bấm link `https://accounts.google.com/...` trong cửa sổ agy |

Javis tự nhận cả hai não khi đã đăng nhập. Phần còn làm tay (cần đăng nhập Javis): Javis → **Models**: Claude Code là **model chính** (MAIN), bật thẻ **Google Antigravity CLI** (đèn xanh).

`install_ai.ps1 -Check` báo đúng trạng thái đăng nhập: dòng `Sign in Claude Code` / `Sign in Antigravity` = **OK** là xong, **TODO** là chưa.

## Bước 3. Giao máy cho đồng nghiệp (5')
1. Mở **Javis OS** (biểu tượng trên Desktop), tạo tài khoản admin của Javis cho đồng nghiệp: **đồng nghiệp tự đặt mật khẩu**.
2. Javis → **Cài đặt**: múi giờ **Australia/Perth**, tiền tệ **AUD**, ngôn ngữ giao diện / trả lời theo ý cô ấy (English hoặc Tiếng Việt).
3. Javis → **Memory** → mở `facts/ho-so-nguoi-dung.md`, điền cùng cô ấy: tên, ngôn ngữ, email đang dùng (Gmail hay Outlook), thư mục chung, việc hay làm.
4. Hướng dẫn: chọn nhân viên **Office Admin Assistant**, gõ như nhắn tin. Ví dụ: "Draft a reply to this email", "Make a checklist for a new starter", "Tóm tắt file này", "Dịch đoạn này sang tiếng Anh".
5. (Tùy chọn, làm sau) Nối email / lịch / Drive của cô ấy qua **Composio** như `KET-NOI.md` mục 3a: cô ấy tự đăng nhập tài khoản của mình.
3. GitHub là của cô ấy nên cứ để đăng nhập (sau này cập nhật repo không cần anh). **Cuối cùng anh Lucas đăng xuất Claude Desktop** (Settings → Log out) để cô ấy không thấy lịch sử chat / kết nối của anh. Cô ấy chỉ dùng Javis (Javis chạy bằng Claude Code + Antigravity đã đăng nhập ở Bước 2).

---

## Việc của Claude (khi được nhờ "Cài Javis cho máy này theo CAI-JAVIS.md")
1. Kiểm `git`: chưa có thì `winget install --id Git.Git -e --accept-source-agreements --accept-package-agreements` (máy hỏi quyền thì nhờ anh Lucas bấm Yes), rồi mở lại PATH (mỗi lệnh PowerShell mới của Claude cũng phải nạp lại: `$env:Path = [Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [Environment]::GetEnvironmentVariable('Path','User')`).
2. Clone repo vào `C:\Users\<user>\ai-qlda-setup` (repo Private: Git mở trình duyệt, **người dùng máy tự đăng nhập GitHub của mình** (đã được mời ở Bước 0); Claude không hỏi, không nhận mật khẩu / mã). Lỗi "Repository not found": người dùng chưa Accept thư mời.
3. Phần mềm nền (cần Admin): chạy
   `Start-Process powershell -Verb RunAs -ArgumentList '-NoExit','-ExecutionPolicy','Bypass','-File','<repo>\tools\install_base.ps1','-NoOptional'`
   Nhờ anh Lucas bấm **Yes**. Script hỏi mật khẩu AnyDesk: anh Lucas tự quyết (gõ hoặc bỏ qua). Xong thì Claude chạy `install_base.ps1 -Check`.
4. Javis + não AI (PowerShell thường): `powershell -ExecutionPolicy Bypass -File <repo>\tools\install_ai.ps1 -Team admin`. Chạy lâu (pip vài phút): chạy nền rồi đợi. Báo "open Javis once" thì nhờ anh Lucas mở Javis OS một lần rồi chạy lại.
5. Đăng nhập não AI: chạy nền `powershell -ExecutionPolicy Bypass -File <repo>\tools\install_ai.ps1 -SignIn -Team admin`, báo anh Lucas làm phần trình duyệt theo bảng Bước 2 (nhắc: **không đóng cửa sổ agy**). Script tự đợi và báo OK. Rồi mở Javis (`http://127.0.0.1:7777`) và nhờ anh Lucas kiểm trang **Models**.
6. Chạy lại `install_ai.ps1 -Check -Team admin`; báo bảng kết quả.
7. Không đăng xuất GitHub (tài khoản của người dùng máy).

**Không làm:** không chạy `setup.bat` của Javis; không đọc / in `~\.javis\config.json` hay file đăng nhập; không hỏi, nhận, gõ mật khẩu / token; không cài đội QLDA (dùng `-Team admin`).
