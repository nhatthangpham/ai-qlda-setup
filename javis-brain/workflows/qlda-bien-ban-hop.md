---
type: workflow
name: QLDA - Biên bản họp
slug: qlda-bien-ban-hop
status: 'off'
group: QLDA
description: Từ ghi chú họp ra biên bản và bảng việc cần làm (người phụ trách, hạn), soát lỗi.
steps:
  - agent: qlda-thu-ky-hop
    task: "Viết biên bản họp và bảng việc cần làm từ ghi chú sau. Chưa tạo lịch, chỉ liệt kê đề xuất nhắc hạn:\n{{input}}"
    verify_agent: qlda-kiem-tra
    max_retries: 1
updated: '2026-11-10'
---
Chạy: dán ghi chú họp (hoặc link file trên Drive) làm đầu vào. Tạo lịch nhắc hạn: sau khi xem biên bản, nói với qlda-thu-ky-hop "đưa các hạn lên lịch của anh".
