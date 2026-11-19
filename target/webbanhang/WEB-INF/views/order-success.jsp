<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Xác Nhận Phiếu Xuất Chành Xe <c:out value="${order.orderCode}"/> - Thoại Hằng Heavy Parts</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

    <jsp:include page="/WEB-INF/views/header.jsp"/>

    <main class="container">
        <c:choose>
            <c:when test="${not empty order}">
                <div class="order-success-card">
                    <div class="order-success-banner">
                        <div>
                            <div style="font-size: 13px; color: var(--color-gold-accent); font-weight: 600;">
                                LỆNH XUẤT KHO GỬI CHÀNH XE 24/7 ĐÃ ĐƯỢC GHI NHẬN
                            </div>
                            <h1 style="font-size: 24px; font-weight: 600; margin-top: 6px;">
                                Đặt Hàng Thành Công - Đang Chuyển Thủ Kho Đóng Thùng
                            </h1>
                        </div>
                        <div class="order-code-box">
                            <c:out value="${order.orderCode}"/>
                        </div>
                    </div>

                    <div class="panel-card-body">
                        <div class="success-alert-box">
                            Lệnh xuất kho mã <strong><c:out value="${order.orderCode}"/></strong> đã được chuyển trực tiếp tới hệ thống điều vận <strong><c:out value="${order.dispatchWarehouse}"/></strong>. Kỹ sư trực kho sẽ liên hệ số <strong><c:out value="${order.phone}"/></strong> trong vòng 10 phút để đọc số bill gửi xe.
                        </div>

                        <div class="form-row-2" style="margin-bottom: 24px;">
                            <div style="background-color: var(--color-bg-subtle); padding: 18px; border-radius: var(--radius-sm); border: 1px solid var(--color-border-hairline);">
                                <h2 style="font-size: 16px; color: var(--color-navy-deep); margin-bottom: 12px;">
                                    1. Thông tin Thuyền trưởng / Chủ phương tiện
                                </h2>
                                <div style="font-size: 14px; display: flex; flex-direction: column; gap: 8px;">
                                    <div><strong>Người nhận:</strong> <c:out value="${order.customerName}"/></div>
                                    <div><strong>Điện thoại nhận bill:</strong> <span class="mono-code"><c:out value="${order.phone}"/></span></div>
                                    <div><strong>Số hiệu Tàu / Biển số xe:</strong> <strong style="color: var(--color-navy-primary);"><c:out value="${order.vesselOrPlateNumber}"/></strong></div>
                                    <div><strong>Thời gian lập lệnh:</strong> <span class="tabular-nums"><c:out value="${order.createdAt}"/></span></div>
                                    <div><strong>Trạng thái kho:</strong> <span class="status-badge status-pending"><c:out value="${order.status}"/></span></div>
                                </div>
                            </div>

                            <div style="background-color: var(--color-bg-subtle); padding: 18px; border-radius: var(--radius-sm); border: 1px solid var(--color-border-hairline);">
                                <h2 style="font-size: 16px; color: var(--color-navy-deep); margin-bottom: 12px;">
                                    2. Tuyến vận chuyển Chành xe &amp; Kiểm định
                                </h2>
                                <div style="font-size: 14px; display: flex; flex-direction: column; gap: 8px;">
                                    <div><strong>Kho xuất hàng:</strong> <c:out value="${order.dispatchWarehouse}"/></div>
                                    <div><strong>Nhà xe nhận hàng:</strong> <strong style="color: var(--color-orange-burnt);"><c:out value="${order.shippingCarrier}"/></strong></div>
                                    <div><strong>Điểm trả hàng:</strong> <c:out value="${order.deliveryAddress}"/></div>
                                    <div><strong>Yêu cầu kỹ thuật:</strong> <c:out value="${order.technicalNotes}"/></div>
                                </div>
                            </div>
                        </div>

                        <!-- BẢNG KÊ CÁC MÃ OEM TRONG PHIẾU XUẤT -->
                        <h2 style="font-size: 17px; color: var(--color-navy-deep); margin-bottom: 12px;">
                            3. Danh mục phụ tùng cơ khí trong kiện hàng (<c:out value="${order.totalItemsCount}"/> bộ)
                        </h2>

                        <div style="overflow-x: auto; border: 1px solid var(--color-border-hairline); border-radius: var(--radius-sm); margin-bottom: 24px;">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>Mã OEM</th>
                                        <th>Tên phụ tùng cơ khí</th>
                                        <th>Tiêu chuẩn dung sai</th>
                                        <th>Số lượng</th>
                                        <th>Thành tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${order.items}">
                                        <tr>
                                            <td><span class="oem-pill"><c:out value="${item.product.oemCode}"/></span></td>
                                            <td style="font-weight: 600;"><c:out value="${item.product.name}"/></td>
                                            <td class="mono-code" style="font-size: 13px;"><c:out value="${item.product.toleranceSpec}"/></td>
                                            <td class="tabular-nums"><strong>x<c:out value="${item.quantity}"/></strong></td>
                                            <td class="tabular-nums" style="font-weight: 600; color: var(--color-orange-burnt);">
                                                <c:out value="${item.formattedSubTotal}"/>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div style="display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 16px; padding: 18px 20px; background-color: var(--color-bg-subtle); border-left: 4px solid var(--color-navy-primary); border-radius: var(--radius-sm); margin-bottom: 24px;">
                            <div>
                                <div style="font-weight: 600; color: var(--color-navy-deep);">Hướng dẫn nhận hàng tại trạm Chành xe:</div>
                                <p style="font-size: 14px; color: var(--color-text-secondary); margin-top: 4px;">
                                    Khi nhận kiện hàng tại nhà xe <strong><c:out value="${order.shippingCarrier}"/></strong>, Quý khách vui lòng đọc mã đơn <strong><c:out value="${order.orderCode}"/></strong> và kiểm tra tem niêm phong KCS Panme H7 cùng phong bì Hóa đơn VAT + CO/CQ dán bên trong nắp thùng gỗ.
                                </p>
                            </div>
                            <div style="text-align: right;">
                                <div style="font-size: 13px; color: var(--color-text-muted);">Tổng thanh toán đơn hàng:</div>
                                <div style="font-size: 26px; font-weight: 600; color: var(--color-orange-burnt);" class="tabular-nums">
                                    <c:out value="${order.formattedTotalAmount}"/>
                                </div>
                            </div>
                        </div>

                        <div style="display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 12px;">
                            <a href="${pageContext.request.contextPath}/home" class="btn-outline-navy">
                                <span>Về Trang chủ Thoại Hằng</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/san-pham" class="btn-primary-orange">
                                <span>Tiếp tục tra cứu Mã OEM khác</span>
                            </a>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="panel-card" style="padding: 40px; text-align: center; margin: 32px 0;">
                    <h2>Chưa có thông tin đơn đặt hàng</h2>
                    <p style="margin: 12px 0 20px 0; color: var(--color-text-muted);">Vui lòng chọn phụ tùng vào giỏ hàng trước khi lập phiếu xuất chành xe.</p>
                    <a href="${pageContext.request.contextPath}/san-pham" class="btn-primary-orange">Vào Siêu thị Phụ tùng</a>
                </div>
            </c:otherwise>
        </c:choose>
    </main>

    <jsp:include page="/WEB-INF/views/footer.jsp"/>

</body>
</html>
