<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Siêu Thị Phụ Tùng Cơ Khí - Cửa Hàng Thoại Hằng Heavy Parts</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

    <jsp:include page="/WEB-INF/views/header.jsp"/>

    <div class="breadcrumb-bar">
        <div class="container">
            <ul class="breadcrumb-list">
                <li><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                <li>/</li>
                <li>Siêu thị phụ tùng cơ khí</li>
                <c:if test="${selectedCategory == 'MAY-THUY'}">
                    <li>/</li>
                    <li>Phân hệ Máy Thủy &amp; Tàu Xà Lan</li>
                </c:if>
                <c:if test="${selectedCategory == 'XE-TAI-NANG'}">
                    <li>/</li>
                    <li>Phân hệ Xe Ô Tô Tải Nặng &amp; Đầu Kéo</li>
                </c:if>
            </ul>
        </div>
    </div>

    <main class="catalog-section">
        <div class="container">
            <!-- BỘ LỌC KHO HÀNG CHUYÊN SÂU -->
            <div class="panel-card" style="margin-bottom: 24px;">
                <div class="panel-card-header">
                    <div class="panel-card-title">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"></polygon>
                        </svg>
                        <span>BỘ LỌC KỸ THUẬT SIÊU THỊ PHỤ TÙNG THOẠI HẰNG</span>
                    </div>
                    <span class="dispatch-tag tabular-nums">Tổng tồn kho sẵn sàng: <c:out value="${totalInventoryUnits}"/> bộ chi tiết</span>
                </div>

                <div class="panel-card-body">
                    <form action="${pageContext.request.contextPath}/san-pham" method="get">
                        <div style="display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 16px; align-items: end;">
                            <div>
                                <label class="form-label" for="catSelect">Phân hệ cơ khí</label>
                                <select id="catSelect" name="category" class="form-control">
                                    <option value="ALL" ${selectedCategory == 'ALL' ? 'selected' : ''}>Tất cả phân hệ (Máy thủy &amp; Xe tải)</option>
                                    <option value="MAY-THUY" ${selectedCategory == 'MAY-THUY' ? 'selected' : ''}>Phụ tùng Đại tu Máy Thủy &amp; Sà Lan</option>
                                    <option value="XE-TAI-NANG" ${selectedCategory == 'XE-TAI-NANG' ? 'selected' : ''}>Phụ tùng Xe Ô Tô Tải Nặng &amp; Đầu Kéo</option>
                                </select>
                            </div>

                            <div>
                                <label class="form-label" for="brandSelect">Hãng sản xuất (OEM Brand)</label>
                                <select id="brandSelect" name="brand" class="form-control">
                                    <option value="ALL" ${selectedBrand == 'ALL' ? 'selected' : ''}>Tất cả thương hiệu đối tác</option>
                                    <option value="Yanmar" ${selectedBrand == 'Yanmar' ? 'selected' : ''}>Yanmar (Nhật Bản)</option>
                                    <option value="Cummins" ${selectedBrand == 'Cummins' ? 'selected' : ''}>Cummins (Mỹ)</option>
                                    <option value="Advance" ${selectedBrand == 'Advance' ? 'selected' : ''}>Advance (Hộp số thủy)</option>
                                    <option value="Hino" ${selectedBrand == 'Hino' ? 'selected' : ''}>Hino Motors (500 / 700)</option>
                                    <option value="Hyundai" ${selectedBrand == 'Hyundai' ? 'selected' : ''}>Hyundai (HD320 / Trago)</option>
                                    <option value="Howo" ${selectedBrand == 'Howo' ? 'selected' : ''}>Sinotruk Howo 371</option>
                                    <option value="Denso" ${selectedBrand == 'Denso' ? 'selected' : ''}>Denso (Kim phun Common Rail)</option>
                                    <option value="Mitsubishi" ${selectedBrand == 'Mitsubishi' ? 'selected' : ''}>Mitsubishi Marine (S6R2)</option>
                                    <option value="Holset" ${selectedBrand == 'Holset' ? 'selected' : ''}>Holset (Turbo tăng áp)</option>
                                </select>
                            </div>

                            <div>
                                <label class="form-label" for="sortSelect">Thứ tự sắp xếp</label>
                                <select id="sortSelect" name="sort" class="form-control">
                                    <option value="default" ${selectedSort == 'default' ? 'selected' : ''}>Mặc định theo danh mục chuẩn</option>
                                    <option value="price-asc" ${selectedSort == 'price-asc' ? 'selected' : ''}>Giá xuất kho: Thấp đến Cao</option>
                                    <option value="price-desc" ${selectedSort == 'price-desc' ? 'selected' : ''}>Giá xuất kho: Cao xuống Thấp</option>
                                    <option value="name-asc" ${selectedSort == 'name-asc' ? 'selected' : ''}>Tên phụ tùng: A - Z</option>
                                </select>
                            </div>

                            <div style="display: flex; gap: 8px;">
                                <input type="text"
                                       name="q"
                                       value="<c:out value='${searchKeyword}'/>"
                                       class="form-control"
                                       placeholder="Từ khóa / Mã OEM..."/>
                                <button type="submit" class="btn-primary-orange" style="white-space: nowrap; min-height: 44px; padding: 0 20px;">
                                    <span>Lọc kho</span>
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- THANH TIÊU ĐỀ KẾT QUẢ -->
            <div class="section-toolbar">
                <div>
                    <h1 class="section-heading">DANH MỤC KHO HÀNG PHỤ TÙNG CƠ KHÍ</h1>
                    <p class="section-subheading">
                        Tìm thấy <strong id="visibleProductsCount" class="tabular-nums"><c:out value="${products.size()}"/></strong> mã phụ tùng khớp điều kiện tra cứu
                    </p>
                </div>

                <div class="filter-controls">
                    <div class="realtime-search-box">
                        <input type="text"
                               id="realtimeFilterInput"
                               class="realtime-input"
                               placeholder="Gõ lọc tức thời trên danh sách này..."
                               aria-label="Gõ lọc tức thời"/>
                    </div>
                    <a href="${pageContext.request.contextPath}/san-pham" class="btn-outline-navy">
                        <span>Đặt lại bộ lọc</span>
                    </a>
                </div>
            </div>

            <!-- LƯỚI HIỂN THỊ PHỤ TÙNG -->
            <c:choose>
                <c:when test="${not empty products}">
                    <div class="products-grid">
                        <c:forEach var="p" items="${products}">
                            <article class="product-card"
                                     data-category="${p.category}"
                                     data-search="${p.name} ${p.oemCode} ${p.brand} ${p.engineModel} ${p.subSystem}">
                                <div>
                                    <div class="product-schematic-preview">
                                        <div class="schematic-top-row">
                                            <span class="category-badge ${p.category == 'MAY-THUY' ? 'marine' : 'truck'}">
                                                <c:out value="${p.categoryLabel}"/>
                                            </span>
                                            <span class="brand-tag"><c:out value="${p.brand}"/></span>
                                        </div>

                                        <c:choose>
                                            <c:when test="${p.hasImage}">
                                                <div class="product-photo-box">
                                                    <img src="${p.imageUrl}" alt="${p.name}" class="product-photo-img"/>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="schematic-svg-box" aria-hidden="true">
                                                    <svg width="180" height="86" viewBox="0 0 180 86" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <line x1="8" y1="43" x2="172" y2="43" stroke="#F8C600" stroke-width="1.2" stroke-dasharray="10 4 2 4"/>
                                                        <line x1="90" y1="8" x2="90" y2="78" stroke="#F8C600" stroke-width="1" stroke-dasharray="6 3"/>
                                                        <rect x="28" y="16" width="124" height="54" rx="3" stroke="#64B5F6" stroke-width="1.8" fill="rgba(56, 189, 248, 0.10)"/>
                                                        <rect x="18" y="28" width="144" height="30" stroke="#E2E8F0" stroke-width="1.5" fill="rgba(15, 23, 42, 0.45)"/>
                                                        <circle cx="90" cy="43" r="14" stroke="#F8C600" stroke-width="1.8"/>
                                                        <text x="42" y="81" fill="#38BDF8" font-family="Consolas, monospace" font-size="9.5">L=180mm ±0.02 | H7</text>
                                                    </svg>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                        <div class="schematic-bottom-row">
                                            <span><c:out value="${p.subSystem}"/></span>
                                            <span>Cấp H7</span>
                                        </div>
                                    </div>

                                    <div class="product-body">
                                        <div class="oem-code-row">
                                            <span class="oem-pill">OEM: <c:out value="${p.oemCode}"/></span>
                                            <span class="stock-pill">Tồn: <c:out value="${p.stock}"/> bộ</span>
                                        </div>

                                        <h2 class="product-title">
                                            <a href="${pageContext.request.contextPath}/san-pham/chi-tiet?id=${p.id}">
                                                <c:out value="${p.name}"/>
                                            </a>
                                        </h2>

                                        <div class="product-meta-list">
                                            <div class="product-meta-item">
                                                <strong>Dòng máy:</strong> <c:out value="${p.engineModel}"/>
                                            </div>
                                            <div class="product-meta-item">
                                                <strong>Dung sai:</strong> <c:out value="${p.toleranceSpec}"/>
                                            </div>
                                            <div class="product-meta-item">
                                                <strong>Kho trực:</strong> <c:out value="${p.warehouseLocation}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="product-footer">
                                    <div class="price-block">
                                        <span class="price-label">Đơn giá (Có VAT):</span>
                                        <span class="price-value"><c:out value="${p.formattedPrice}"/></span>
                                    </div>

                                    <div class="card-actions">
                                        <a href="${pageContext.request.contextPath}/san-pham/chi-tiet?id=${p.id}" class="btn-card-detail">
                                            <span>Thông số CAD</span>
                                        </a>
                                        <form action="${pageContext.request.contextPath}/gio-hang" method="post">
                                            <input type="hidden" name="action" value="add"/>
                                            <input type="hidden" name="productId" value="${p.id}"/>
                                            <input type="hidden" name="quantity" value="1"/>
                                            <button type="submit" class="btn-card-add">
                                                <span>Thêm vào giỏ</span>
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </article>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="panel-card" style="padding: 40px; text-align: center;">
                        <h2 style="font-size: 20px; color: var(--color-navy-deep);">Không tìm thấy phụ tùng khớp với tiêu chí lọc</h2>
                        <p style="font-size: 15px; color: var(--color-text-muted); margin-top: 8px; margin-bottom: 20px;">
                            Vui lòng kiểm tra lại ký hiệu mã OEM hoặc gọi trực tiếp kỹ sư kho qua số <strong>0912.345.678</strong>.
                        </p>
                        <a href="${pageContext.request.contextPath}/san-pham" class="btn-primary-orange">
                            <span>Xem toàn bộ 12 mã phụ tùng trong kho</span>
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/footer.jsp"/>

</body>
</html>
