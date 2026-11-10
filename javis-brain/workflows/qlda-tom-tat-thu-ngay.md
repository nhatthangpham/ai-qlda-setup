---
type: workflow
name: QLDA - Tóm tắt thư trong ngày
slug: qlda-tom-tat-thu-ngay
status: 'off'
group: QLDA
description: Đọc Gmail 24 giờ qua, gom theo dự án, liệt kê việc phải làm và hạn.
steps:
  - agent: qlda-ho-so
    task: "Đọc thư Gmail trong 24 giờ qua (hoặc khoảng thời gian: {{input}}). Gom theo dự án, bảng: ngày, người gửi, nội dung chính, việc phải làm, hạn. Bỏ thư quảng cáo. Không trả lời, không gửi thư nào."
  - agent: qlda-dieu-phoi
    task: "Từ bảng thư dưới đây, chọn tối đa 5 việc gấp nhất cho anh hôm nay, mỗi việc 1 dòng, ghi giao cho trợ lý nào nếu cần:\n{{prev}}"
updated: '2026-11-10'
---
Hợp làm việc định kỳ 7h sáng mỗi ngày (Javis > Việc định kỳ) sau khi đã chạy thử và bật 'active'.
