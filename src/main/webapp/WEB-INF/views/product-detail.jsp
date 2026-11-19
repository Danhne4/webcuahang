<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title><c:out value="${product.name}"/> (OEM: <c:out value="${product.oemCode}"/>) - Thoại Hằng Heavy Parts</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

    <jsp:include page="/WEB-INF/views/header.jsp"/>

    <div class="breadcrumb-bar">
        <div class="container">
            <ul class="breadcrumb-list">
                <li><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                <li>/</li>
                <li><a href="${pageContext.request.contextPath}/san-pham">Siêu thị phụ tùng</a></li>
                <li>/</li>
                <li><a href="${pageContext.request.contextPath}/san-pham?category=${product.category}"><c:out value="${product.categoryLabel}"/></a></li>
                <li>/</li>
                <li>Mã OEM: <strong class="mono-code"><c:out value="${product.oemCode}"/></strong></li>
            </ul>
        </div>
    </div>

    <main class="container" style="padding-bottom: 48px;">
        <div class="detail-layout">
            <!-- CỘT TRÁI: BẢN VẼ KỸ THUẬT CAD BLUEPRINT TRÊN CANVAS HTML5 -->
            <section class="cad-blueprint-panel" aria-label="Bản vẽ kỹ thuật CAD Blueprint">
                <div class="cad-panel-header">
                    <div class="cad-title-badge">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <polygon points="12 2 2 7 12 12 22 7 12 2"></polygon>
                            <polyline points="2 17 12 22 22 17"></polyline>
                            <polyline points="2 12 12 17 22 12"></polyline>
                        </svg>
                        <span>BẢN VẼ KỸ THUẬT CAD BLUEPRINT - OEM: <c:out value="${product.oemCode}"/></span>
                    </div>

                    <div style="display: flex; gap: 8px;">
                        <button type="button"
                                data-cad-view="SECTION_AA"
                                class="tab-btn active"
                                style="background-color: var(--color-navy-primary); color: var(--color-text-inverse); padding: 6px 12px; min-height: 36px; font-size: 13px;">
                            Mặt cắt dọc A-A
                        </button>
                        <button type="button"
                                data-cad-view="FLANGE_BB"
                                class="tab-btn"
                                style="background-color: rgba(255,255,255,0.1); color: var(--color-text-inverse); padding: 6px 12px; min-height: 36px; font-size: 13px;">
                            Mặt bích định tâm B-B
                        </button>
                    </div>
                </div>

                <c:if test="${product.hasImage}">
                    <div class="detail-photo-stage">
                        <img src="${product.imageUrl}" alt="${product.name}" class="detail-photo-img"/>
                    </div>
                </c:if>

                <div class="cad-canvas-wrapper">
                    <canvas id="cadBlueprintCanvas"
                            width="680"
                            height="430"
                            data-oem="${product.oemCode}"
                            data-name="${product.name}"
                            data-profile="${product.cadProfileType}"
                            data-brand="${product.brand}">
                        Trình duyệt của bạn không hỗ trợ HTML5 Canvas để hiển thị bản vẽ kỹ thuật CAD Blueprint.
                    </canvas>
                </div>

                <div class="cad-panel-footer">
                    <div class="cad-stat-item">
                        <div class="cad-stat-label">KÍCH THƯỚC CHUẨN ĐO PANME</div>
                        <div class="cad-stat-value">L = 180mm ±0.02</div>
                    </div>
                    <div class="cad-stat-item">
                        <div class="cad-stat-label">CẤP DUNG SAI LẮP GHÉP</div>
                        <div class="cad-stat-value">Cấp H7 / g6 (ISO 286-2)</div>
                    </div>
                    <div class="cad-stat-item">
                        <div class="cad-stat-label">ĐƯỜNG TÂM TRỤC NÉT ĐỨT</div>
                        <div class="cad-stat-value">Độ đảo ≤ 0.015mm</div>
                    </div>
                </div>

                <div style="margin-top: 16px; padding: 14px; background-color: rgba(248, 198, 0, 0.12); border: 1px solid var(--color-border-gold); border-radius: var(--radius-sm); font-size: 13px; color: var(--color-text-inverse-muted);">
                    <strong style="color: var(--color-gold-accent);">Ghi chú kỹ thuật xưởng đại tu:</strong>
                    <c:out value="${product.description}"/>
                </div>
            </section>

            <!-- CỘT PHẢI: BẢNG THÔNG SỐ KỸ THUẬT & CHỌN SỐ LƯỢNG ĐẶT MUA -->
            <section class="detail-info-panel">
                <div class="detail-header-badges">
                    <span class="oem-pill" style="font-size: 14px; padding: 6px 12px;">
                        MÃ OEM: <c:out value="${product.oemCode}"/>
                    </span>
                    <span class="stock-pill" style="font-size: 13px; padding: 6px 12px;">
                        Sẵn kho: <c:out value="${product.stock}"/> bộ (Giao ngay 24/7)
                    </span>
                    <span class="oem-pill" style="font-size: 13px;">
                        Hãng: <c:out value="${product.brand}"/>
                    </span>
                </div>

                <h1 class="detail-product-name"><c:out value="${product.name}"/></h1>

                <div class="detail-price-box">
                    <div>
                        <div style="font-size: 13px; color: var(--color-text-muted);">Đơn giá xuất kho chính hãng (Đã bao gồm VAT 10%):</div>
                        <div class="detail-price-number"><c:out value="${product.formattedPrice}"/></div>
                    </div>
                    <div style="text-align: right;">
                        <span class="stock-pill" style="display: inline-block;">Kèm CO/CQ &amp; Biên bản Panme H7</span>
                    </div>
                </div>

                <!-- BẢNG THÔNG SỐ KỸ THUẬT CHI TIẾT -->
                <table class="specs-table" aria-label="Bảng thông số kỹ thuật cơ khí">
                    <tbody>
                        <tr>
                            <th>Mã phụ tùng chuẩn OEM</th>
                            <td class="mono-code"><c:out value="${product.oemCode}"/></td>
                        </tr>
                        <tr>
                            <th>Phân hệ &amp; Cụm chi tiết</th>
                            <td><c:out value="${product.categoryLabel}"/> - <c:out value="${product.subSystem}"/></td>
                        </tr>
                        <tr>
                            <th>Động cơ / Hộp số tương thích</th>
                            <td><c:out value="${product.engineModel}"/></td>
                        </tr>
                        <tr>
                            <th>Xuất xứ / Nhà sản xuất</th>
                            <td><c:out value="${product.origin}"/></td>
                        </tr>
                        <tr>
                            <th>Vật liệu &amp; Nhiệt luyện</th>
                            <td><c:out value="${product.materialSpec}"/></td>
                        </tr>
                        <tr>
                            <th>Dung sai lắp ghép CAD</th>
                            <td class="mono-code" style="color: var(--color-navy-primary); font-weight: 600;">
                                <c:out value="${product.toleranceSpec}"/>
                            </td>
                        </tr>
                        <tr>
                            <th>Kích thước hình học</th>
                            <td class="mono-code"><c:out value="${product.dimensions}"/></td>
                        </tr>
                        <tr>
                            <th>Khối lượng đóng kiện</th>
                            <td class="tabular-nums"><c:out value="${product.weightKg}"/> kg</td>
                        </tr>
                        <tr>
                            <th>Kho trực gửi chành xe</th>
                            <td><c:out value="${product.warehouseLocation}"/></td>
                        </tr>
                    </tbody>
                </table>

                <!-- FORM CHỌN SỐ LƯỢNG & THÊM VÀO GIỎ HÀNG -->
                <form action="${pageContext.request.contextPath}/gio-hang" method="post" class="purchase-form">
                    <input type="hidden" name="action" value="add"/>
                    <input type="hidden" name="productId" value="${product.id}"/>

                    <div>
                        <label for="detailQtyInput" style="display: block; font-size: 13px; color: var(--color-text-muted); margin-bottom: 6px;">
                            Số lượng đặt mua (Bộ / Chiếc):
                        </label>
                        <div class="qty-control">
                            <button type="button" class="qty-btn" data-qty-minus aria-label="Giảm số lượng">-</button>
                            <input type="number"
                                   id="detailQtyInput"
                                   name="quantity"
                                   value="1"
                                   min="1"
                                   max="${product.stock}"
                                   class="qty-input"
                                   aria-label="Số lượng"/>
                            <button type="button" class="qty-btn" data-qty-plus aria-label="Tăng số lượng">+</button>
                        </div>
                    </div>

                    <div style="flex: 1; display: flex; flex-wrap: wrap; gap: 12px; padding-top: 20px;">
                        <button type="submit" class="btn-primary-orange" style="flex: 1; min-width: 220px;">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <circle cx="9" cy="21" r="1"></circle>
                                <circle cx="20" cy="21" r="1"></circle>
                                <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                            </svg>
                            <span>Thêm vào giỏ &amp; Gửi Chành Xe</span>
                        </button>

                        <a href="tel:0912345678" class="btn-outline-navy">
                            <span>Tư vấn lắp ghép: 0912.345.678</span>
                        </a>
                    </div>
                </form>
            </section>
        </div>

        <!-- PHỤ TÙNG CÙNG PHÂN HỆ ĐẠI TU -->
        <c:if test="${not empty relatedProducts}">
            <section style="margin-top: 32px;">
                <div class="section-toolbar">
                    <div>
                        <h2 class="section-heading">PHỤ TÙNG ĐỒNG BỘ CÙNG PHÂN HỆ</h2>
                        <p class="section-subheading">Các chi tiết cơ khí thường được đặt kèm khi đại tu <c:out value="${product.categoryLabel}"/></p>
                    </div>
                    <a href="${pageContext.request.contextPath}/san-pham?category=${product.category}" class="btn-outline-navy">
                        <span>Xem toàn bộ phân hệ</span>
                    </a>
                </div>

                <div class="products-grid">
                    <c:forEach var="rp" items="${relatedProducts}">
                        <article class="product-card">
                            <div>
                                <div class="product-schematic-preview">
                                    <div class="schematic-top-row">
                                        <span class="category-badge ${rp.category == 'MAY-THUY' ? 'marine' : 'truck'}">
                                            <c:out value="${rp.categoryLabel}"/>
                                        </span>
                                        <span class="brand-tag"><c:out value="${rp.brand}"/></span>
                                    </div>
                                    <div class="schematic-bottom-row">
                                        <span>OEM: <c:out value="${rp.oemCode}"/></span>
                                        <span>H7 (±0.02mm)</span>
                                    </div>
                                </div>
                                <div class="product-body">
                                    <h3 class="product-title">
                                        <a href="${pageContext.request.contextPath}/san-pham/chi-tiet?id=${rp.id}">
                                            <c:out value="${rp.name}"/>
                                        </a>
                                    </h3>
                                    <div class="product-meta-list">
                                        <div class="product-meta-item"><strong>Dòng máy:</strong> <c:out value="${rp.engineModel}"/></div>
                                    </div>
                                </div>
                            </div>
                            <div class="product-footer">
                                <div class="price-block">
                                    <span class="price-label">Giá xuất kho:</span>
                                    <span class="price-value"><c:out value="${rp.formattedPrice}"/></span>
                                </div>
                                <div class="card-actions">
                                    <a href="${pageContext.request.contextPath}/san-pham/chi-tiet?id=${rp.id}" class="btn-card-detail">Bản vẽ CAD</a>
                                    <form action="${pageContext.request.contextPath}/gio-hang" method="post">
                                        <input type="hidden" name="action" value="add"/>
                                        <input type="hidden" name="productId" value="${rp.id}"/>
                                        <input type="hidden" name="quantity" value="1"/>
                                        <button type="submit" class="btn-card-add">Chọn mua</button>
                                    </form>
                                </div>
                            </div>
                        </article>
                    </c:forEach>
                </div>
            </section>
        </c:if>
    </main>

    <jsp:include page="/WEB-INF/views/footer.jsp"/>

</body>
</html>
