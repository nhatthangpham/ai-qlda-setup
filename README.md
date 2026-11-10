# Bộ cài AI cho máy quản lý dự án (QLDA)

Cài một máy Windows thành máy AI giống máy 1 của anh Lucas, dùng cho **quản lý dự án xây dựng**:
Claude Desktop + Claude Code, Gemini (qua Antigravity), Javis OS, và các kết nối Google Drive / Gmail / Lịch / Sheets / Docs, Miro, GitHub (Claude Desktop qua Connectors, Javis qua cổng **Composio**).

Repo này chỉ chứa **cách cài**. Không chứa token, mật khẩu, tài liệu công ty hay dữ liệu dự án.

## 1. Bạn cần chuẩn bị trước (chủ máy)
| # | Việc | Ghi chú |
|---|---|---|
| 1 | Máy Windows 10/11, có quyền Administrator, còn ≥ 20 GB trống, mạng ổn định | |
| 2 | **AnyDesk đã cài hẳn** (không phải bản chạy thử) và gửi **ID AnyDesk** cho người hỗ trợ | Bản chạy thử không hiện được cửa sổ hỏi quyền Admin |
| 3 | Tài khoản **Claude** gói trả phí (Pro / Max) | Claude Code và Javis cần gói trả phí |
| 4 | Tài khoản **Google** (Gmail) dùng cho công việc | Drive, Gmail, Lịch, Gemini |
| 5 | Tài khoản **GitHub** | Để lấy repo này và lưu trữ sau này |
| 6 | Tài khoản **Miro** (nếu dùng bảng Miro) | |
| 6b | Tài khoản **Composio** (composio.dev, gói miễn phí đủ dùng lúc đầu; đăng ký bằng Google được) | Cổng để Javis nối Drive, Gmail, Lịch, Sheets, Docs, Miro, GitHub |
| 7 | Biết mật khẩu các tài khoản trên. **Tự gõ** khi được hỏi, không gửi qua chat cho ai | |

## 2. Trình tự cài (người hỗ trợ vào qua AnyDesk)
| # | Việc | Ai làm | Thời gian |
|---|---|---|---|
| 1 | AnyDesk vào máy; chủ máy bấm **Accept** | Chủ máy | 1' |
| 2 | Tải repo: mở github.com/<chủ-repo>/ai-qlda-setup > **Code > Download ZIP**, giải nén vào `C:\Users\<user>\ai-qlda-setup` (repo Private thì đăng nhập GitHub đã được mời) | Người hỗ trợ | 3' |
| 3 | PowerShell **Run as administrator** → `powershell -ExecutionPolicy Bypass -File "C:\Users\<user>\ai-qlda-setup\tools\install_base.ps1"` | Người hỗ trợ; chủ máy tự gõ mật khẩu AnyDesk nếu muốn cho hỗ trợ không cần Accept | 10–20' |
| 4 | PowerShell **thường** (không Admin) → `powershell -ExecutionPolicy Bypass -File "C:\Users\<user>\ai-qlda-setup\tools\install_ai.ps1"` | Người hỗ trợ | 10' |
| 5 | Đăng nhập + kết nối theo [KET-NOI.md](KET-NOI.md) | Chủ máy gõ mật khẩu; người hỗ trợ chỉ chỗ bấm | 20–30' |
| 6 | Kiểm tra: chạy lại 2 script với `-Check`, tất cả OK; thử các câu hỏi mẫu ở cuối KET-NOI.md | Người hỗ trợ | 5' |

Tổng khoảng **1–1,5 giờ**. Bước nào lỗi xem mục 4.

**Cách nhanh hơn từ bước 4:** cài xong Claude Desktop thì mở Claude (tab Code), chọn thư mục `ai-qlda-setup`, nói *"Cài máy theo README.md và CLAUDE.md"*. Claude tự chạy, chỉ dừng ở các bước cần chủ máy đăng nhập.

## 3. Javis = công ty, Claude / Gemini = bộ não
Claude và Gemini chỉ là **não**. **Javis** giữ cả "công ty": nhân viên (agent), quy trình (workflow), bộ nhớ (memory), việc định kỳ, kết nối (Composio). Đổi não thì nhân viên, quy trình, bộ nhớ vẫn giữ nguyên.

`install_ai.ps1` cài sẵn đội QLDA từ thư mục `javis-brain\` vào Javis (file nào đã có thì không ghi đè):

| Nhân viên (agent) | Não | Việc |
|---|---|---|
| 1_QLDA Điều phối | Claude | Nhận việc, chia cho đúng người, gom kết quả |
| 2_QLDA Tiến độ | Claude | Việc trễ, đến hạn, rủi ro tiến độ |
| 3_QLDA Báo cáo | Claude | Báo cáo tuần / tháng |
| 4_QLDA Hồ sơ & Thư từ | Claude | Hợp đồng, biên bản, Gmail, soạn nháp thư |
| 5_QLDA Thư ký họp | Claude | Biên bản họp, việc + người + hạn, nhắc lịch |
| 6_QLDA Chi phí & Khối lượng | Claude | Dự toán, BOQ, thanh toán, vượt chi |
| 7_QLDA Kiểm tra | **Gemini** | Soát số, ngày, nguồn trước khi giao chủ máy |

| Quy trình (workflow) | Các bước |
|---|---|
| QLDA - Báo cáo tuần | Tiến độ → Chi phí → Báo cáo → Kiểm tra |
| QLDA - Biên bản họp | Thư ký họp → Kiểm tra |
| QLDA - Tóm tắt thư trong ngày | Hồ sơ (đọc Gmail) → Điều phối (5 việc gấp) |

Bộ nhớ: `memory\facts\ho-so-chu-may.md`, gồm xưng hô, công ty, danh sách dự án, thư mục Drive. **Điền ngay khi cài**, vì nhân viên nào cũng đọc file này.
Các quy trình để `off`. Chạy thử, thấy đúng mới bật `active` và đặt lịch (vd báo cáo tuần sáng thứ 6, tóm tắt thư 7h sáng).

## 4. Sau khi cài
- Mở **Javis OS** trên Desktop → trang **Models** chọn **Claude Code** làm model chính; thêm **Google Antigravity CLI** làm model phụ (Gemini). Nếu tên model `gemini-3.8-flash-high` của nhân viên Kiểm tra không có trong danh sách, chọn model Gemini khác cho nhân viên đó.
- Thư mục làm việc gợi ý: `C:\Users\<user>\QLDA\` (mỗi dự án một thư mục con). Không để trong Desktop / Documents nếu các thư mục đó đồng bộ OneDrive.
- Gợi ý việc QLDA cho AI: xem [CLAUDE.md](CLAUDE.md) mục "Việc AI làm được".

## 5. Tham khảo thêm (của cộng đồng, chưa cài; đọc kỹ trước khi dùng)
| Tên | Là gì | Dùng khi |
|---|---|---|
| [construction-agent-skills](https://github.com/constructelligence-lab/construction-agent-skills) | 28 skill cho ngành xây dựng (dự toán, tiến độ, công trường, an toàn, thương mại), dạng SKILL.md, CC BY 4.0 | Lấy skill phù hợp chép vào `skills\` của Javis |
| [lean-planning-mcp](https://github.com/jeffmodeler/project-mcp) | MCP đọc tiến độ MS Project / Primavera P6 / Synchro, thêm Last Planner | Dự án có file .mpp / .xer |
| [procore-mcp](https://github.com/LiamDGray/procore-mcp) | MCP cho Procore (RFI, submittal, ngân sách) | Chỉ khi công ty dùng Procore |
| [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills) (mục project-management) | Skill quản lý dự án chung (nghiêng phần mềm) | Lấy ý tưởng |
| Plugin **Small Business** (Anthropic, trong Claude Desktop) | Skill soát hợp đồng, báo cáo, theo dõi hóa đơn | Bổ sung cho Claude Desktop |

## 6. Lỗi thường gặp
| Hiện tượng | Nguyên nhân | Cách xử lý |
|---|---|---|
| AnyDesk màn hình đen khi bấm "Run as administrator" | AnyDesk là bản chạy thử | Cài hẳn AnyDesk (nút "Install AnyDesk on this device"), kết nối lại |
| `winget not found` | Windows thiếu App Installer | Cài "App Installer" từ Microsoft Store |
| Javis báo "Refusing to execute batch script claude.CMD" | Claude Code cài bằng npm | `npm uninstall -g @anthropic-ai/claude-code`, chạy lại `install_ai.ps1`, khởi động lại Javis |
| Gõ `agy` / `claude` báo "not recognized" | Cửa sổ PowerShell mở từ trước khi cài | Mở PowerShell mới |
| Javis không mở | Server chưa chạy | Bấm đúp **Javis OS** trên Desktop, đợi 30 giây; kiểm tra http://127.0.0.1:7777/health |
| Máy ngủ, AnyDesk mất kết nối | Cài đặt nguồn | `install_base.ps1` đã tắt ngủ khi cắm điện; laptop phải cắm sạc |

## 7. Không làm
- Không chạy `setup.bat` của Javis (nó cài thêm phần mềm ngoài và bật tự khởi động).
- Không dán token / mật khẩu vào chat với AI hoặc vào file trong repo.
- Không đưa tài liệu dự án lên repo này.
