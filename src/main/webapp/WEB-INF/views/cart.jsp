<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Giỏ Phụ Tùng &amp; Đặt Gửi Chành Xe 24/7 - Thoại Hằng Heavy Parts</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

    <jsp:include page="/WEB-INF/views/header.jsp"/>

    <div class="breadcrumb-bar">
        <div class="container">
            <ul class="breadcrumb-list">
                <li><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                <li>/</li>
                <li>Giỏ hàng &amp; Phiếu xuất kho gửi Chành xe 24/7</li>
            </ul>
        </div>
    </div>

    <main class="container">
        <c:if test="${not empty sessionScope.cartFlashMessage}">
            <div class="success-alert-box">
                <c:out value="${sessionScope.cartFlashMessage}"/>
            </div>
            <c:remove var="cartFlashMessage" scope="session"/>
        </c:if>

        <c:choose>
            <c:when test="${not empty sessionScope.cart}">
                <div class="cart-page-grid">
                    <!-- CỘT TRÁI: BẢNG KÊ CHI TIẾT PHỤ TÙNG TRONG GIỎ -->
                    <section class="panel-card">
                        <div class="panel-card-header">
                            <div class="panel-card-title">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <circle cx="9" cy="21" r="1"></circle>
                                    <circle cx="20" cy="21" r="1"></circle>
                                    <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                                </svg>
                                <span>DANH MỤC PHỤ TÙNG CHỜ XUẤT KHO (<c:out value="${sessionScope.cartCount}"/> MÓN)</span>
                            </div>

                            <form action="${pageContext.request.contextPath}/gio-hang" method="post">
                                <input type="hidden" name="action" value="clear"/>
                                <button type="submit"
                                        style="background: transparent; border: 1px solid var(--color-border-gold); color: var(--color-gold-accent); padding: 6px 12px; border-radius: var(--radius-sm); font-size: 13px;">
                                    Làm trống giỏ
                                </button>
                            </form>
                        </div>

                        <div class="panel-card-body" style="padding: 0; overflow-x: auto;">
                            <table class="data-table" aria-label="Bảng kê phụ tùng trong giỏ hàng">
                                <thead>
                                    <tr>
                                        <th>Phụ tùng &amp; Mã OEM</th>
                                        <th>Đơn giá</th>
                                        <th>Số lượng</th>
                                        <th>Thành tiền</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${sessionScope.cart}">
                                        <tr>
                                            <td>
                                                <div style="font-weight: 600; color: var(--color-navy-deep);">
                                                    <a href="${pageContext.request.contextPath}/san-pham/chi-tiet?id=${item.product.id}">
                                                        <c:out value="${item.product.name}"/>
                                                    </a>
                                                </div>
                                                <div style="margin-top: 4px; display: flex; flex-wrap: wrap; gap: 8px; align-items: center;">
                                                    <span class="oem-pill">OEM: <c:out value="${item.product.oemCode}"/></span>
                                                    <span style="font-size: 12px; color: var(--color-text-muted);">
                                                        Hãng: <c:out value="${item.product.brand}"/> | Cấp H7
                                                    </span>
                                                </div>
                                            </td>
                                            <td class="tabular-nums" style="white-space: nowrap; font-weight: 500;">
                                                <c:out value="${item.product.formattedPrice}"/>
                                            </td>
                                            <td>
                                                <form action="${pageContext.request.contextPath}/gio-hang" method="post" style="display: flex; align-items: center; gap: 6px;">
                                                    <input type="hidden" name="action" value="update"/>
                                                    <input type="hidden" name="productId" value="${item.product.id}"/>
                                                    <input type="number"
                                                           name="quantity"
                                                           value="${item.quantity}"
                                                           min="1"
                                                           max="${item.product.stock}"
                                                           aria-label="Số lượng cho ${item.product.name}"
                                                           style="width: 64px; padding: 6px 8px; border: 1px solid var(--color-border-strong); border-radius: var(--radius-sm); text-align: center;"
                                                           class="tabular-nums"/>
                                                    <button type="submit"
                                                            style="padding: 6px 10px; border: 1px solid var(--color-navy-primary); background-color: var(--color-bg-subtle); color: var(--color-navy-primary); border-radius: var(--radius-sm); font-size: 13px; font-weight: 500;">
                                                        Cập nhật
                                                    </button>
                                                </form>
                                            </td>
                                            <td class="tabular-nums" style="white-space: nowrap; font-weight: 600; color: var(--color-orange-burnt);">
                                                <c:out value="${item.formattedSubTotal}"/>
                                            </td>
                                            <td>
                                                <form action="${pageContext.request.contextPath}/gio-hang" method="post">
                                                    <input type="hidden" name="action" value="remove"/>
                                                    <input type="hidden" name="productId" value="${item.product.id}"/>
                                                    <button type="submit"
                                                            style="padding: 6px 10px; border: 1px solid var(--color-danger-border); background-color: var(--color-danger-bg); color: var(--color-danger-text); border-radius: var(--radius-sm); font-size: 13px;">
                                                        Xóa
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div style="padding: 20px 24px; background-color: var(--color-bg-subtle); border-top: 2px solid var(--color-border-strong); display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 16px;">
                            <div>
                                <a href="${pageContext.request.contextPath}/san-pham" class="btn-outline-navy">
                                    <span>Chọn thêm mã phụ tùng khác</span>
                                </a>
                            </div>
                            <div style="text-align: right;">
                                <div style="font-size: 14px; color: var(--color-text-secondary);">Tổng giá trị phiếu xuất (Đã bao gồm VAT 10%):</div>
                                <div style="font-size: 26px; font-weight: 600; color: var(--color-orange-burnt);" class="tabular-nums">
                                    <c:out value="${sessionScope.cartTotalFormatted}"/>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- CỘT PHẢI: FORM ĐẶT HÀNG GỬI CHÀNH XE -->
                    <section id="form-chanh-xe" class="panel-card">
                        <div class="panel-card-header">
                            <div class="panel-card-title">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <rect x="1" y="3" width="15" height="13"></rect>
                                    <polygon points="16 8 20 8 23 11 23 16 16 16 16 8"></polygon>
                                    <circle cx="5.5" cy="18.5" r="2.5"></circle>
                                    <circle cx="18.5" cy="18.5" r="2.5"></circle>
                                </svg>
                                <span>THÔNG TIN GỬI CHÀNH XE &amp; CẢNG BIỂN</span>
                            </div>
                        </div>

                        <div class="panel-card-body">
                            <form action="${pageContext.request.contextPath}/dat-hang" method="post">
                                <div class="form-group">
                                    <label class="form-label" for="customerName">1. Họ tên Thuyền trưởng / Chủ xe / Kỹ sư máy (*)</label>
                                    <input type="text"
                                           id="customerName"
                                           name="customerName"
                                           required
                                           class="form-control"
                                           placeholder="VD: Thuyền trưởng Nguyễn Văn Hùng / Chủ xe Trần Quốc Bảo"/>
                                </div>

                                <div class="form-row-2">
                                    <div class="form-group">
                                        <label class="form-label" for="phone">2. Số điện thoại nhận bill xe (*)</label>
                                        <input type="tel"
                                               id="phone"
                                               name="phone"
                                               required
                                               class="form-control"
                                               placeholder="VD: 0918.452.310"/>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label" for="vesselOrPlateNumber">3. Tên tàu / Số hiệu xà lan / Biển số xe (*)</label>
                                        <input type="text"
                                               id="vesselOrPlateNumber"
                                               name="vesselOrPlateNumber"
                                               required
                                               class="form-control"
                                               placeholder="VD: Tàu QNg-98452-TS hoặc Xe 51D-684.29"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label" for="dispatchWarehouse">4. Chọn Tổng kho xuất hàng gần nhất (*)</label>
                                    <select id="dispatchWarehouse" name="dispatchWarehouse" class="form-control">
                                        <option value="Kho Hải Phòng (Cảng Chùa Vẽ - Quận Hải An)">Kho Hải Phòng (Cảng Chùa Vẽ - Gửi các tỉnh phía Bắc &amp; Cảng biển)</option>
                                        <option value="Kho TP.HCM (Bến xe Miền Đông mới / Cầu Đồng Nai)">Kho TP.HCM (Bến xe Miền Đông mới / Cầu Đồng Nai - Gửi Miền Tây, Miền Trung)</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label class="form-label" for="shippingCarrier">5. Nhà xe / Chành xe nhận hàng (*)</label>
                                    <select id="shippingCarrier" name="shippingCarrier" class="form-control">
                                        <option value="Chành xe Tô Châu (Tuyến Miền Tây - Cần Thơ - Cà Mau - Kiên Giang)">Chành xe Tô Châu (Tuyến Miền Tây - Cần Thơ - Cà Mau - Kiên Giang)</option>
                                        <option value="Nhà xe Phương Trang FUTA Express (Miền Trung - Cảng Sa Kỳ - Quy Nhơn)">Nhà xe Phương Trang FUTA Express (Miền Trung - Cảng Sa Kỳ - Quy Nhơn)</option>
                                        <option value="Viettel Post Hàng Nặng / Vận tải Trọng Tấn (Giao tận xưởng)">Viettel Post Hàng Nặng / Vận tải Trọng Tấn (Giao tận xưởng)</option>
                                        <option value="Trạm Chành xe Cảng Chùa Vẽ (Tuyến Hải Phòng - Quảng Ninh - Nam Định)">Trạm Chành xe Cảng Chùa Vẽ (Tuyến Hải Phòng - Quảng Ninh - Nam Định)</option>
                                        <option value="Chành xe Bến xe Miền Đông Mới (Tuyến Tây Nguyên - Đà Nẵng - Nghệ An)">Chành xe Bến xe Miền Đông Mới (Tuyến Tây Nguyên - Đà Nẵng - Nghệ An)</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label class="form-label" for="deliveryAddress">6. Trạm nhận hàng / Cảng cá / Địa chỉ xưởng đại tu (*)</label>
                                    <input type="text"
                                           id="deliveryAddress"
                                           name="deliveryAddress"
                                           required
                                           class="form-control"
                                           placeholder="VD: Trạm Tô Châu Cần Thơ / Cảng cá Sa Kỳ Quảng Ngãi / Cảng Chùa Vẽ"/>
                                </div>

                                <div class="form-group">
                                    <label class="form-label" for="technicalNotes">7. Ghi chú kỹ thuật (Đo Panme cấp H7, xuất VAT, đóng kiện gỗ)</label>
                                    <textarea id="technicalNotes"
                                              name="technicalNotes"
                                              rows="3"
                                              class="form-control"
                                              placeholder="VD: Nhờ kỹ sư kho kiểm tra Panme dung sai H7, đóng thùng gỗ chống va đập và gửi kèm hóa đơn VAT + CO/CQ theo thùng hàng."></textarea>
                                </div>

                                <div style="background-color: var(--color-bg-subtle); padding: 14px; border-radius: var(--radius-sm); border: 1px solid var(--color-border-hairline); font-size: 13px; color: var(--color-text-secondary); margin-bottom: 16px;">
                                    <strong>Cam kết xuất kho:</strong> Ngay sau khi bấm đặt hàng, hệ thống cấp mã đơn <strong>ORD-2026-XXXX</strong>. Thủ kho trực 24/7 sẽ gọi xác nhận mã OEM và đóng thùng gửi ra chành xe trong 60 phút.
                                </div>

                                <button type="submit" class="btn-primary-orange" style="width: 100%; font-size: 16px;">
                                    <span>Xác nhận Đặt hàng &amp; Xuất Kho Ra Chành Xe</span>
                                </button>
                            </form>
                        </div>
                    </section>
                </div>
            </c:when>

            <c:otherwise>
                <div class="panel-card" style="padding: 48px 24px; text-align: center; margin-bottom: 48px;">
                    <h1 style="font-size: 22px; color: var(--color-navy-deep);">Giỏ phụ tùng của Quý khách hiện đang trống</h1>
                    <p style="font-size: 15px; color: var(--color-text-muted); margin-top: 8px; margin-bottom: 24px;">
                        Quý khách vui lòng chọn mã OEM phụ tùng máy thủy hoặc xe tải nặng trong Siêu thị phụ tùng để lập phiếu gửi chành xe.
                    </p>
                    <a href="${pageContext.request.contextPath}/san-pham" class="btn-primary-orange">
                        <span>Vào Siêu thị Phụ tùng chọn mã OEM</span>
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </main>

    <jsp:include page="/WEB-INF/views/footer.jsp"/>

</body>
</html>
