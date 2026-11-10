---
type: workflow
name: QLDA - Báo cáo tuần
slug: qlda-bao-cao-tuan
status: 'off'
group: QLDA
description: Đọc tiến độ + chi phí của một dự án, viết báo cáo tuần, soát lỗi trước khi giao.
steps:
  - agent: qlda-tien-do
    task: "Dự án / yêu cầu: {{input}}. Lập bảng tiến độ tuần này (trễ, đến hạn 7 ngày, đã xong) kèm nguồn từng số."
  - agent: qlda-chi-phi
    task: "Dự án / yêu cầu: {{input}}. Tóm tắt chi phí và thanh toán đến hôm nay nếu có dữ liệu; không có thì ghi (chưa có số liệu). Giữ nguyên phần tiến độ dưới đây để bước sau dùng:\n{{prev}}"
  - agent: qlda-bao-cao
    task: "Viết báo cáo tuần theo khung của em từ dữ liệu sau. Chỉ dùng số có trong dữ liệu:\n{{prev}}"
    verify_agent: qlda-kiem-tra
    max_retries: 1
updated: '2026-11-10'
---
Chạy: Javis > Cộng sự > Quy trình > QLDA - Báo cáo tuần > Chạy, nhập tên dự án (vd "Dự án ABC, tuần 46").
Để 'off' tới khi chủ máy chạy thử thấy đúng; bật 'active' thì mới dùng được trong Kanban / việc định kỳ (vd sáng thứ 6 hàng tuần).
