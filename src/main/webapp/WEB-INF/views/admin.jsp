<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Bảng Điều Khiển Quản Trị Tổng Kho - Thoại Hằng Heavy Parts</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

    <!-- THANH ĐIỀU HÀNH NỘI BỘ DÀNH RIÊNG CHO THỦ KHO (TÔNG XANH NƯỚC BIỂN HÀI HÒA) -->
    <header class="site-header">
        <div class="header-tier-1">
            <div class="container tier-1-inner">
                <div class="warehouse-strip">
                    <span class="warehouse-item">
                        <strong>CỔNG QUẢN TRỊ NỘI BỘ BẢO MẬT:</strong> Tổng Kho Hải Phòng (Cảng Chùa Vẽ) &amp; Tổng Kho TP.HCM (BX Miền Đông Mới)
                    </span>
                </div>
                <div class="hotline-strip">
                    <span class="dispatch-tag"><c:out value="${sessionScope.adminRoleName}"/></span>
                </div>
            </div>
        </div>

        <div class="header-tier-2">
            <div class="container" style="display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 16px;">
                <div class="brand-logo">
                    <img src="${pageContext.request.contextPath}/images/logo-thoai-hang.jpg"
                         alt="Cửa Hàng Thoại Hằng - Phụ Tùng Tàu Thuyền - Xe Tải"
                         class="brand-logo-official"/>
                    <div class="brand-text">
                        <div class="brand-title">TRUNG TÂM ĐIỀU VẬN &amp; QUẢN LÝ KHO THOẠI HẰNG</div>
                        <div class="brand-subtitle">Hệ thống quản trị tinh gọn theo Mục lục: Đơn hàng, Tồn kho, Ảnh mặt hàng, Banner &amp; Thương hiệu</div>
                    </div>
                </div>

                <div style="display: flex; align-items: center; gap: 12px;">
                    <a href="${pageContext.request.contextPath}/home" class="btn-secondary-gold" style="min-height: 42px; padding: 8px 16px; font-size: 14px;">
                        <span>Xem Trang chủ Khách hàng</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin-logout" class="btn-primary-orange" style="min-height: 42px; padding: 8px 16px; font-size: 14px;">
                        <span>Đăng xuất (/admin-logout)</span>
                    </a>
                </div>
            </div>
        </div>
    </header>

    <main class="container" style="padding-top: 24px; padding-bottom: 48px;">
        <c:if test="${not empty sessionScope.adminNotice}">
            <div class="success-alert-box">
                <c:out value="${sessionScope.adminNotice}"/>
            </div>
            <c:remove var="adminNotice" scope="session"/>
        </c:if>

        <!-- THỐNG KÊ TỔNG QUAN KHO (KPIs) -->
        <section aria-label="Thống kê kho hàng">
            <div class="admin-kpi-grid">
                <div class="admin-kpi-card">
                    <div class="admin-kpi-label">Danh mục Mã OEM lưu kho</div>
                    <div class="admin-kpi-value"><c:out value="${totalSkuCount}"/> mã chuẩn</div>
                    <div style="font-size: 13px; color: var(--color-text-muted); margin-top: 4px;">Đủ Máy thủy &amp; Xe tải nặng</div>
                </div>

                <div class="admin-kpi-card">
                    <div class="admin-kpi-label">Tổng số lượng bộ phụ tùng</div>
                    <div class="admin-kpi-value"><c:out value="${totalUnitsCount}"/> bộ</div>
                    <div style="font-size: 13px; color: var(--color-success-text); margin-top: 4px;">Đã kiểm định Panme cấp H7</div>
                </div>

                <div class="admin-kpi-card">
                    <div class="admin-kpi-label">Tổng giá trị vật tư tồn kho</div>
                    <div class="admin-kpi-value" style="color: var(--color-navy-primary);"><c:out value="${totalInventoryValue}"/></div>
                    <div style="font-size: 13px; color: var(--color-text-muted); margin-top: 4px;">Kho Hải Phòng &amp; Kho TP.HCM</div>
                </div>

                <div class="admin-kpi-card" style="border-top-color: var(--color-gold-accent);">
                    <div class="admin-kpi-label">Đơn gửi Chành xe (<c:out value="${totalOrdersCount}"/> đơn)</div>
                    <div class="admin-kpi-value" style="color: var(--color-navy-deep);"><c:out value="${totalOrdersRevenue}"/></div>
                    <div style="font-size: 13px; color: var(--color-text-muted); margin-top: 4px;">Doanh thu đơn hàng hiệu lực</div>
                </div>
            </div>
        </section>

        <!-- BỐ CỤC QUẢN TRỊ TINH GỌN: CỘT TRÁI MỤC LỤC | CỘT PHẢI NỘI DUNG TỪNG MỤC -->
        <div class="admin-workspace-layout">
            <!-- CỘT TRÁI: MỤC LỤC QUẢN TRỊ (TABLE OF CONTENTS) -->
            <aside class="admin-toc-sidebar" aria-label="Mục lục quản trị">
                <div class="admin-toc-header">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <line x1="8" y1="6" x2="21" y2="6"></line>
                        <line x1="8" y1="12" x2="21" y2="12"></line>
                        <line x1="8" y1="18" x2="21" y2="18"></line>
                        <line x1="3" y1="6" x2="3.01" y2="6"></line>
                        <line x1="3" y1="12" x2="3.01" y2="12"></line>
                        <line x1="3" y1="18" x2="3.01" y2="18"></line>
                    </svg>
                    <span>MỤC LỤC QUẢN TRỊ</span>
                </div>

                <nav class="admin-toc-list">
                    <button type="button"
                            data-admin-tab="orders"
                            class="admin-toc-btn ${empty activeTab || activeTab == 'orders' ? 'active' : ''}">
                        <span class="admin-toc-btn-left">
                            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <rect x="1" y="3" width="15" height="13"></rect>
                                <polygon points="16 8 20 8 23 11 23 16 16 16 16 8"></polygon>
                                <circle cx="5.5" cy="18.5" r="2.5"></circle>
                                <circle cx="18.5" cy="18.5" r="2.5"></circle>
                            </svg>
                            <span>1. Đơn hàng Chành xe</span>
                        </span>
                        <span class="admin-toc-badge"><c:out value="${orders.size()}"/></span>
                    </button>

                    <button type="button"
                            data-admin-tab="inventory"
                            class="admin-toc-btn ${activeTab == 'inventory' ? 'active' : ''}">
                        <span class="admin-toc-btn-left">
                            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path>
                            </svg>
                            <span>2. Kho OEM &amp; Đổi ảnh</span>
                        </span>
                        <span class="admin-toc-badge"><c:out value="${products.size()}"/></span>
                    </button>

                    <button type="button"
                            data-admin-tab="add-product"
                            class="admin-toc-btn ${activeTab == 'add-product' ? 'active' : ''}">
                        <span class="admin-toc-btn-left">
                            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <circle cx="12" cy="12" r="10"></circle>
                                <line x1="12" y1="8" x2="12" y2="16"></line>
                                <line x1="8" y1="12" x2="16" y2="12"></line>
                            </svg>
                            <span>3. Nhập mã OEM mới</span>
                        </span>
                        <span class="admin-toc-badge" style="background-color: var(--color-gold-accent); color: var(--color-navy-darker);">+Mới</span>
                    </button>

                    <button type="button"
                            data-admin-tab="banners"
                            class="admin-toc-btn ${activeTab == 'banners' ? 'active' : ''}">
                        <span class="admin-toc-btn-left">
                            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <rect x="3" y="3" width="18" height="18" rx="2"></rect>
                                <circle cx="8.5" cy="8.5" r="1.5"></circle>
                                <polyline points="21 15 16 10 5 21"></polyline>
                            </svg>
                            <span>4. Slider Banner (10s)</span>
                        </span>
                        <span class="admin-toc-badge"><c:out value="${bannerSlides.size()}"/></span>
                    </button>

                    <button type="button"
                            data-admin-tab="brands"
                            class="admin-toc-btn ${activeTab == 'brands' ? 'active' : ''}">
                        <span class="admin-toc-btn-left">
                            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
                            </svg>
                            <span>5. Logo Thương hiệu</span>
                        </span>
                        <span class="admin-toc-badge"><c:out value="${brandPartners.size()}"/></span>
                    </button>

                    <button type="button"
                            data-admin-tab="categories"
                            class="admin-toc-btn ${activeTab == 'categories' ? 'active' : ''}">
                        <span class="admin-toc-btn-left">
                            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <line x1="8" y1="6" x2="21" y2="6"></line>
                                <line x1="8" y1="12" x2="21" y2="12"></line>
                                <line x1="8" y1="18" x2="21" y2="18"></line>
                                <line x1="3" y1="6" x2="3.01" y2="6"></line>
                                <line x1="3" y1="12" x2="3.01" y2="12"></line>
                                <line x1="3" y1="18" x2="3.01" y2="18"></line>
                            </svg>
                            <span>6. Danh mục sản phẩm</span>
                        </span>
                        <span class="admin-toc-badge"><c:out value="${categories.size()}"/></span>
                    </button>
                </nav>
            </aside>

            <!-- CỘT PHẢI: KHUNG LÀM VIỆC THEO TỪNG MỤC LỤC -->
            <div>
                <!-- MỤC 1: QUẢN LÝ ĐƠN HÀNG GỬI CHÀNH XE -->
                <section id="panel-orders" class="admin-tab-panel ${empty activeTab || activeTab == 'orders' ? 'active' : ''}">
                    <div class="panel-card">
                        <div class="panel-card-header">
                            <div class="panel-card-title">
                                <span>MỤC 1: DANH SÁCH ĐƠN HÀNG GỬI CHÀNH XE &amp; CẬP NHẬT TRẠNG THÁI</span>
                            </div>
                            <span class="dispatch-tag tabular-nums">Tổng số: <c:out value="${orders.size()}"/> vận đơn</span>
                        </div>

                        <div class="panel-card-body" style="padding: 0; overflow-x: auto;">
                            <table class="data-table" aria-label="Bảng quản lý đơn hàng chành xe">
                                <thead>
                                    <tr>
                                        <th>Mã đơn &amp; Ngày lập</th>
                                        <th>Thuyền trưởng / Chủ xe</th>
                                        <th>Tàu / Biển số &amp; Chành xe nhận</th>
                                        <th>Chi tiết Mã OEM</th>
                                        <th>Tổng tiền</th>
                                        <th>Trạng thái</th>
                                        <th>Đổi trạng thái</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="o" items="${orders}">
                                        <tr>
                                            <td>
                                                <div class="mono-code" style="font-weight: 600; color: var(--color-navy-primary);">
                                                    <c:out value="${o.orderCode}"/>
                                                </div>
                                                <div style="font-size: 12px; color: var(--color-text-muted); margin-top: 4px;" class="tabular-nums">
                                                    <c:out value="${o.createdAt}"/>
                                                </div>
                                            </td>
                                            <td>
                                                <div style="font-weight: 600;"><c:out value="${o.customerName}"/></div>
                                                <div class="mono-code" style="font-size: 13px; color: var(--color-text-secondary); margin-top: 4px;">
                                                    SĐT: <c:out value="${o.phone}"/>
                                                </div>
                                            </td>
                                            <td>
                                                <div style="font-weight: 600; color: var(--color-navy-deep);">
                                                    <c:out value="${o.vesselOrPlateNumber}"/>
                                                </div>
                                                <div style="font-size: 13px; color: var(--color-navy-primary); margin-top: 2px;">
                                                    <c:out value="${o.shippingCarrier}"/>
                                                </div>
                                                <div style="font-size: 12px; color: var(--color-text-muted); margin-top: 2px;">
                                                    Xuất từ: <c:out value="${o.dispatchWarehouse}"/>
                                                </div>
                                            </td>
                                            <td style="font-size: 13px; max-width: 260px;">
                                                <c:out value="${o.itemsSummary}"/>
                                            </td>
                                            <td class="tabular-nums" style="font-weight: 600; color: var(--color-navy-deep); white-space: nowrap;">
                                                <c:out value="${o.formattedTotalAmount}"/>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${o.status == 'Chờ xác nhận'}">
                                                        <span class="status-badge status-pending">Chờ xác nhận</span>
                                                    </c:when>
                                                    <c:when test="${o.status == 'Đang đóng thùng'}">
                                                        <span class="status-badge status-packing">Đang đóng thùng</span>
                                                    </c:when>
                                                    <c:when test="${o.status == 'Đã giao chành xe'}">
                                                        <span class="status-badge status-shipped">Đã giao chành xe</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge status-cancelled"><c:out value="${o.status}"/></span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <form action="${pageContext.request.contextPath}/admin" method="post" style="display: flex; align-items: center; gap: 6px;">
                                                    <input type="hidden" name="action" value="updateOrderStatus"/>
                                                    <input type="hidden" name="orderCode" value="${o.orderCode}"/>
                                                    <select name="status"
                                                            aria-label="Đổi trạng thái đơn ${o.orderCode}"
                                                            style="padding: 6px 10px; border: 1px solid var(--color-border-strong); border-radius: var(--radius-sm); font-size: 13px;">
                                                        <option value="Chờ xác nhận" ${o.status == 'Chờ xác nhận' ? 'selected' : ''}>Chờ xác nhận</option>
                                                        <option value="Đang đóng thùng" ${o.status == 'Đang đóng thùng' ? 'selected' : ''}>Đang đóng thùng</option>
                                                        <option value="Đã giao chành xe" ${o.status == 'Đã giao chành xe' ? 'selected' : ''}>Đã giao chành xe</option>
                                                        <option value="Đã hủy" ${o.status == 'Đã hủy' ? 'selected' : ''}>Đã hủy</option>
                                                    </select>
                                                    <button type="submit"
                                                            style="padding: 6px 12px; background-color: var(--color-navy-primary); color: var(--color-text-inverse); border: none; border-radius: var(--radius-sm); font-size: 13px; font-weight: 500;">
                                                        Lưu
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </section>

                <!-- MỤC 2: KHO PHỤ TÙNG OEM & CẬP NHẬT ẢNH / TỒN KHO TINH GỌN -->
                <section id="panel-inventory" class="admin-tab-panel ${activeTab == 'inventory' ? 'active' : ''}">
                    <div class="panel-card">
                        <div class="panel-card-header">
                            <div class="panel-card-title">
                                <span>MỤC 2: DANH MỤC MÃ OEM TỒN KHO &amp; CẬP NHẬT ẢNH MẶT HÀNG (<c:out value="${products.size()}"/> MÃ)</span>
                            </div>
                            <div style="display: flex; align-items: center; gap: 10px;">
                                <input type="text"
                                       id="adminInventorySearch"
                                       placeholder="Tìm nhanh mã OEM, tên hàng..."
                                       aria-label="Tìm nhanh mã OEM trong kho"
                                       style="padding: 6px 12px; border-radius: var(--radius-sm); border: 1px solid var(--color-border-gold); font-size: 13px; min-width: 220px;"/>
                                <button type="button"
                                        onclick="switchAdminTab('add-product');"
                                        class="btn-secondary-gold"
                                        style="min-height: 36px; padding: 6px 14px; font-size: 13px;">
                                    + Nhập mã OEM mới
                                </button>
                            </div>
                        </div>

                        <div class="panel-card-body" style="padding: 0; overflow-x: auto;">
                            <table class="data-table" aria-label="Bảng tồn kho phụ tùng OEM">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Ảnh</th>
                                        <th>Phụ tùng &amp; Mã OEM</th>
                                        <th>Đơn giá</th>
                                        <th>Số lượng tồn</th>
                                        <th>Thao tác Ảnh mặt hàng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="p" items="${products}">
                                        <tr class="admin-inv-row" data-inv-search="${p.name} ${p.oemCode} ${p.brand} ${p.engineModel}">
                                            <td class="mono-code">#<c:out value="${p.id}"/></td>
                                            <td>
                                                <div class="admin-thumb-box">
                                                    <c:choose>
                                                        <c:when test="${p.hasImage}">
                                                            <img src="${p.imageUrl}" alt="${p.name}" class="admin-thumb-img"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span>CAD H7</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </td>
                                            <td>
                                                <div style="font-weight: 600; color: var(--color-navy-deep);">
                                                    <a href="${pageContext.request.contextPath}/san-pham/chi-tiet?id=${p.id}">
                                                        <c:out value="${p.name}"/>
                                                    </a>
                                                </div>
                                                <div style="margin-top: 4px; display: flex; flex-wrap: wrap; gap: 6px; align-items: center;">
                                                    <span class="oem-pill">OEM: <c:out value="${p.oemCode}"/></span>
                                                    <span style="font-size: 12px; color: var(--color-text-muted);">
                                                        <c:out value="${p.brand}"/> (<c:out value="${p.category == 'MAY-THUY' ? 'Máy thủy' : 'Xe tải nặng'}"/>)
                                                    </span>
                                                </div>
                                            </td>
                                            <td class="tabular-nums" style="font-weight: 600; color: var(--color-navy-primary); white-space: nowrap;">
                                                <c:out value="${p.formattedPrice}"/>
                                            </td>
                                            <td>
                                                <form action="${pageContext.request.contextPath}/admin" method="post" style="display: flex; align-items: center; gap: 4px;">
                                                    <input type="hidden" name="action" value="updateStock"/>
                                                    <input type="hidden" name="productId" value="${p.id}"/>
                                                    <input type="number"
                                                           name="stock"
                                                           value="${p.stock}"
                                                           min="0"
                                                           aria-label="Tồn kho của ${p.oemCode}"
                                                           class="tabular-nums"
                                                           style="width: 60px; padding: 5px 6px; border: 1px solid var(--color-border-strong); border-radius: var(--radius-sm); text-align: center;"/>
                                                    <button type="submit"
                                                            style="padding: 5px 10px; background-color: var(--color-navy-primary); border: none; color: var(--color-text-inverse); border-radius: var(--radius-sm); font-size: 12px;">
                                                        Lưu
                                                    </button>
                                                </form>
                                            </td>
                                            <td style="min-width: 220px;">
                                                <div style="display: flex; align-items: center; gap: 6px;">
                                                    <button type="button"
                                                            onclick="toggleImageDrawer('imgDrawer-${p.id}');"
                                                            style="padding: 5px 12px; background-color: var(--color-bg-subtle); color: var(--color-navy-deep); border: 1px solid var(--color-border-strong); border-radius: var(--radius-sm); font-size: 12px; font-weight: 600;">
                                                        <c:out value="${p.hasImage ? 'Đổi ảnh khác' : '+ Thêm ảnh'}"/>
                                                    </button>

                                                    <c:if test="${p.hasImage}">
                                                        <form action="${pageContext.request.contextPath}/admin" method="post" style="display: inline;">
                                                            <input type="hidden" name="action" value="updateImage"/>
                                                            <input type="hidden" name="productId" value="${p.id}"/>
                                                            <input type="hidden" name="clearImage" value="true"/>
                                                            <button type="submit"
                                                                    style="padding: 5px 8px; background-color: var(--color-danger-bg); color: var(--color-danger-text); border: 1px solid var(--color-danger-border); border-radius: var(--radius-sm); font-size: 12px;">
                                                                Gỡ ảnh
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                </div>

                                                <!-- Ngăn kéo thu gọn để tải tệp ảnh hoặc dán URL ảnh (chỉ mở khi bấm "+ Thêm ảnh / Đổi ảnh") -->
                                                <div id="imgDrawer-${p.id}" class="admin-img-drawer">
                                                    <form action="${pageContext.request.contextPath}/admin"
                                                          method="post"
                                                          enctype="multipart/form-data"
                                                          style="display: flex; flex-direction: column; gap: 6px;">
                                                        <input type="hidden" name="action" value="updateImage"/>
                                                        <input type="hidden" name="productId" value="${p.id}"/>
                                                        <input type="file"
                                                               name="imageFile"
                                                               accept="image/*"
                                                               aria-label="Chọn file ảnh cho ${p.name}"
                                                               style="font-size: 12px;"/>
                                                        <div style="display: flex; gap: 4px;">
                                                            <input type="text"
                                                                   name="imageUrl"
                                                                   placeholder="Hoặc dán URL ảnh..."
                                                                   style="flex: 1; padding: 4px 8px; border: 1px solid var(--color-border-strong); border-radius: 4px; font-size: 12px;"/>
                                                            <button type="submit"
                                                                    style="padding: 4px 10px; background-color: var(--color-navy-primary); color: var(--color-text-inverse); border: none; border-radius: 4px; font-size: 12px; font-weight: 600;">
                                                                Tải lên
                                                            </button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </section>

                <!-- MỤC 3: NHẬP KHO MÃ PHỤ TÙNG OEM MỚI -->
                <section id="panel-add-product" class="admin-tab-panel ${activeTab == 'add-product' ? 'active' : ''}">
                    <div class="panel-card">
                        <div class="panel-card-header">
                            <div class="panel-card-title">
                                <span>MỤC 3: NHẬP KHO MÃ PHỤ TÙNG CƠ KHÍ OEM MỚI (KÈM ẢNH THỰC TẾ)</span>
                            </div>
                        </div>

                        <div class="panel-card-body">
                            <form action="${pageContext.request.contextPath}/admin"
                                  method="post"
                                  enctype="multipart/form-data">
                                <input type="hidden" name="action" value="addProduct"/>

                                <div class="form-row-2">
                                    <div class="form-group">
                                        <label class="form-label" for="newName">1. Tên phụ tùng cơ khí (*)</label>
                                        <input type="text"
                                               id="newName"
                                               name="name"
                                               required
                                               class="form-control"
                                               placeholder="VD: Trục cơ (Trục khuỷu) máy thủy Yanmar 6CH"/>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label" for="newOem">2. Mã chuẩn OEM (*)</label>
                                        <input type="text"
                                               id="newOem"
                                               name="oemCode"
                                               required
                                               class="form-control"
                                               placeholder="VD: 119574-21700"/>
                                    </div>
                                </div>

                                <div class="form-row-2">
                                    <div class="form-group">
                                        <label class="form-label" for="newBrand">3. Thương hiệu (*)</label>
                                        <input type="text"
                                               id="newBrand"
                                               name="brand"
                                               required
                                               class="form-control"
                                               placeholder="VD: Yanmar / Cummins / Hino / Denso"/>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label" for="newCategory">4. Phân hệ cơ khí (*)</label>
                                        <select id="newCategory" name="category" class="form-control">
                                            <option value="MAY-THUY">Máy Thủy &amp; Tàu Xà Lan</option>
                                            <option value="XE-TAI-NANG">Xe Tải Nặng &amp; Đầu Kéo</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-row-2">
                                    <div class="form-group">
                                        <label class="form-label" for="newSubSystem">5. Cụm hệ thống</label>
                                        <input type="text"
                                               id="newSubSystem"
                                               name="subSystem"
                                               class="form-control"
                                               placeholder="VD: Bộ hơi &amp; Cơ cấu trục khuỷu"/>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label" for="newEngine">6. Dòng động cơ / Hộp số tương thích</label>
                                        <input type="text"
                                               id="newEngine"
                                               name="engineModel"
                                               class="form-control"
                                               placeholder="VD: Yanmar 6CH-HT / Cummins 6BT / Hino J08E"/>
                                    </div>
                                </div>

                                <div class="form-row-2">
                                    <div class="form-group">
                                        <label class="form-label" for="newPrice">7. Đơn giá xuất kho VNĐ (*)</label>
                                        <input type="number"
                                               id="newPrice"
                                               name="price"
                                               required
                                               min="100000"
                                               step="50000"
                                               value="12500000"
                                               class="form-control"/>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label" for="newStock">8. Số lượng nhập kho (*)</label>
                                        <input type="number"
                                               id="newStock"
                                               name="stock"
                                               required
                                               min="1"
                                               value="15"
                                               class="form-control"/>
                                    </div>
                                </div>

                                <div class="form-row-2">
                                    <div class="form-group">
                                        <label class="form-label" for="newTolerance">9. Thông số dung sai Panme &amp; CAD</label>
                                        <input type="text"
                                               id="newTolerance"
                                               name="toleranceSpec"
                                               class="form-control"
                                               value="L = 180mm ±0.02, Dung sai lắp ghép cấp H7"/>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label" for="newMaterial">10. Vật liệu &amp; Xuất xứ</label>
                                        <input type="text"
                                               id="newMaterial"
                                               name="materialSpec"
                                               class="form-control"
                                               placeholder="VD: Thép rèn hợp kim Cr-Mo tôi cao tần HRC 58"/>
                                    </div>
                                </div>

                                <div class="form-group" style="background-color: var(--color-bg-subtle); padding: 16px; border-radius: var(--radius-sm); border: 1px solid var(--color-border-strong);">
                                    <label class="form-label" for="newImageFile">11. Đính kèm Hình ảnh mặt hàng (Tải tệp ảnh từ máy tính hoặc dán link URL ảnh)</label>
                                    <div class="form-row-2">
                                        <input type="file"
                                               id="newImageFile"
                                               name="imageFile"
                                               accept="image/*"
                                               class="form-control"/>
                                        <input type="text"
                                               id="newImageUrl"
                                               name="imageUrl"
                                               class="form-control"
                                               placeholder="Hoặc dán link URL ảnh trực tiếp (https://...)"/>
                                    </div>
                                    <div id="newProductImagePreviewWrap" style="display: none; margin-top: 12px;">
                                        <div style="font-size: 12px; color: var(--color-text-muted); margin-bottom: 4px;">Xem trước ảnh phụ tùng:</div>
                                        <img id="newProductImagePreview" src="" alt="Xem trước ảnh mặt hàng" style="max-height: 140px; border-radius: var(--radius-sm); border: 1px solid var(--color-border-strong);"/>
                                    </div>
                                </div>

                                <button type="submit" class="btn-primary-orange" style="width: 100%; margin-top: 8px;">
                                    <span>Lưu Mã Phụ Tùng Mới Vào Tổng Kho</span>
                                </button>
                            </form>
                        </div>
                    </div>
                </section>

                <!-- MỤC 4: QUẢN LÝ SLIDER BANNER GIỚI THIỆU (10 GIÂY ĐỔI 1 LẦN / NÚT NEXT) -->
                <section id="panel-banners" class="admin-tab-panel ${activeTab == 'banners' ? 'active' : ''}">
                    <div class="panel-card">
                        <div class="panel-card-header">
                            <div class="panel-card-title">
                                <span>MỤC 4: QUẢN LÝ BANNER GIỚI THIỆU TRANG CHỦ (TỰ ĐỔI 10 GIÂY / NÚT NEXT)</span>
                            </div>
                            <span class="dispatch-tag tabular-nums">Đang chạy: <c:out value="${bannerSlides.size()}"/> Slide</span>
                        </div>

                        <div class="panel-card-body">
                            <div class="cart-page-grid" style="margin-bottom: 0;">
                                <!-- Cột trái: Form thêm Slide mới -->
                                <form action="${pageContext.request.contextPath}/admin"
                                      method="post"
                                      enctype="multipart/form-data"
                                      style="background-color: var(--color-bg-subtle); padding: 18px; border-radius: var(--radius-sm); border: 1px solid var(--color-border-strong);">
                                    <input type="hidden" name="action" value="addBannerSlide"/>
                                    <h3 style="font-size: 16px; color: var(--color-navy-deep); margin-bottom: 14px;">
                                        Thêm Slide Banner Giới Thiệu Mới
                                    </h3>

                                    <div class="form-row-2">
                                        <div class="form-group">
                                            <label class="form-label" for="bannerTitle">1. Tiêu đề Banner (*)</label>
                                            <input type="text"
                                                   id="bannerTitle"
                                                   name="title"
                                                   required
                                                   class="form-control"
                                                   placeholder="VD: DENSO Common rail"/>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label" for="bannerLink">2. Đường dẫn đích</label>
                                            <input type="text"
                                                   id="bannerLink"
                                                   name="targetLink"
                                                   value="/san-pham"
                                                   class="form-control"/>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label" for="bannerSubtitle">3. Dòng mô tả phụ</label>
                                        <input type="text"
                                               id="bannerSubtitle"
                                               name="subtitle"
                                               class="form-control"
                                               placeholder="VD: Hệ thống nhiên liệu áp suất cao chính hãng Nhật Bản"/>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label" for="bannerBullets">4. Các mục nổi bật (Ngăn cách bởi dấu | )</label>
                                        <input type="text"
                                               id="bannerBullets"
                                               name="bulletPoints"
                                               class="form-control"
                                               value="KIM PHUN|BƠM CAO ÁP|ĐẦU KIM|BỘ KIT SỬA CHỮA KIM PHUN"/>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label" for="bannerFile">5. Tải tệp ảnh Banner từ máy tính hoặc dán URL (*)</label>
                                        <input type="file"
                                               id="bannerFile"
                                               name="imageFile"
                                               accept="image/*"
                                               class="form-control"
                                               style="margin-bottom: 8px;"/>
                                        <input type="text"
                                               name="imageUrl"
                                               class="form-control"
                                               placeholder="Hoặc dán link URL ảnh Banner (https://...)"/>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label" for="fullImageMode">6. Kiểu bố cục Slide</label>
                                        <select id="fullImageMode" name="fullImageMode" class="form-control">
                                            <option value="false">Chuẩn BinhMinhJSC (Chữ bên trái + Ảnh bên phải)</option>
                                            <option value="true">Hiển thị nguyên tấm ảnh Banner toàn khung</option>
                                        </select>
                                    </div>

                                    <button type="submit" class="btn-primary-orange" style="width: 100%;">
                                        <span>Thêm Slide Vào Trang Chủ</span>
                                    </button>
                                </form>

                                <!-- Cột phải: Danh sách các Slide hiện có -->
                                <div>
                                    <h3 style="font-size: 16px; color: var(--color-navy-deep); margin-bottom: 14px;">
                                        Các Slide đang trình chiếu (Tự động đổi mỗi 10s):
                                    </h3>
                                    <div style="display: flex; flex-direction: column; gap: 12px;">
                                        <c:forEach var="bs" items="${bannerSlides}" varStatus="st">
                                            <div style="display: flex; align-items: center; justify-content: space-between; gap: 12px; padding: 12px; border: 1px solid var(--color-border-strong); border-radius: var(--radius-sm); background-color: var(--color-bg-card);">
                                                <div style="display: flex; align-items: center; gap: 12px;">
                                                    <img src="${bs.imageUrl}"
                                                         alt="${bs.title}"
                                                         style="width: 96px; height: 60px; object-fit: cover; border-radius: 4px; border: 1px solid var(--color-border-strong); flex-shrink: 0;"/>
                                                    <div>
                                                        <div style="font-weight: 600; color: var(--color-navy-deep);">
                                                            Slide #<c:out value="${st.count}"/>: <c:out value="${bs.title}"/>
                                                        </div>
                                                        <div style="font-size: 12px; color: var(--color-text-muted); margin-top: 2px;">
                                                            <c:out value="${bs.subtitle}"/>
                                                        </div>
                                                    </div>
                                                </div>

                                                <form action="${pageContext.request.contextPath}/admin" method="post">
                                                    <input type="hidden" name="action" value="deleteBannerSlide"/>
                                                    <input type="hidden" name="bannerId" value="${bs.id}"/>
                                                    <button type="submit"
                                                            style="padding: 6px 12px; background-color: var(--color-danger-bg); color: var(--color-danger-text); border: 1px solid var(--color-danger-border); border-radius: var(--radius-sm); font-size: 12px;">
                                                        Xóa
                                                    </button>
                                                </form>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- MỤC 5: QUẢN LÝ BĂNG CHUYỀN LOGO THƯƠNG HIỆU ĐỐI TÁC -->
                <section id="panel-brands" class="admin-tab-panel ${activeTab == 'brands' ? 'active' : ''}">
                    <div class="panel-card">
                        <div class="panel-card-header">
                            <div class="panel-card-title">
                                <span>MỤC 5: QUẢN LÝ LOGO THƯƠNG HIỆU ĐỐI TÁC (BĂNG CHUYỀN CHUYỂN ĐỘNG)</span>
                            </div>
                            <span class="dispatch-tag tabular-nums">Tổng số: <c:out value="${brandPartners.size()}"/> thương hiệu</span>
                        </div>

                        <div class="panel-card-body">
                            <div class="cart-page-grid" style="margin-bottom: 0;">
                                <!-- Cột trái: Form thêm Logo thương hiệu -->
                                <form action="${pageContext.request.contextPath}/admin"
                                      method="post"
                                      enctype="multipart/form-data"
                                      style="background-color: var(--color-bg-subtle); padding: 18px; border-radius: var(--radius-sm); border: 1px solid var(--color-border-strong);">
                                    <input type="hidden" name="action" value="addBrandPartner"/>
                                    <h3 style="font-size: 16px; color: var(--color-navy-deep); margin-bottom: 14px;">
                                        Thêm Thương Hiệu &amp; Ảnh Logo Mới
                                    </h3>

                                    <div class="form-group">
                                        <label class="form-label" for="brandNameInput">1. Tên thương hiệu (*)</label>
                                        <input type="text"
                                               id="brandNameInput"
                                               name="brandName"
                                               required
                                               class="form-control"
                                               placeholder="VD: Cummins / ZF / Delphi / Garrett"/>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label" for="brandSubInput">2. Quốc gia / Nhóm sản phẩm</label>
                                        <input type="text"
                                               id="brandSubInput"
                                               name="brandSubtitle"
                                               class="form-control"
                                               placeholder="VD: Germany Gearbox / USA Diesel"/>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label" for="brandLogoFile">3. Tải tệp ảnh Logo hoặc dán URL ảnh</label>
                                        <input type="file"
                                               id="brandLogoFile"
                                               name="imageFile"
                                               accept="image/*"
                                               class="form-control"
                                               style="margin-bottom: 8px;"/>
                                        <input type="text"
                                               name="imageUrl"
                                               class="form-control"
                                               placeholder="Hoặc dán link URL ảnh Logo (https://...)"/>
                                    </div>

                                    <button type="submit" class="btn-primary-orange" style="width: 100%;">
                                        <span>Thêm Vào Băng Chuyền Thương Hiệu</span>
                                    </button>
                                </form>

                                <!-- Cột phải: Lưới các Logo thương hiệu đang chạy -->
                                <div>
                                    <h3 style="font-size: 16px; color: var(--color-navy-deep); margin-bottom: 14px;">
                                        Danh sách Logo đang chạy trên băng chuyền Trang chủ:
                                    </h3>
                                    <div style="display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 10px;">
                                        <c:forEach var="bp" items="${brandPartners}">
                                            <div style="display: flex; align-items: center; justify-content: space-between; gap: 8px; padding: 10px; border: 1px solid var(--color-border-strong); border-radius: var(--radius-sm); background-color: var(--color-bg-card);">
                                                <div style="display: flex; align-items: center; gap: 10px; min-width: 0;">
                                                    <img src="${bp.logoUrl}"
                                                         alt="${bp.name}"
                                                         style="width: 72px; height: 38px; object-fit: contain; border: 1px solid var(--color-border-hairline); background-color: #ffffff; flex-shrink: 0;"/>
                                                    <div style="min-width: 0;">
                                                        <div style="font-weight: 600; font-size: 13px; color: var(--color-navy-deep);"><c:out value="${bp.name}"/></div>
                                                        <div style="font-size: 11px; color: var(--color-text-muted);"><c:out value="${bp.subtitle}"/></div>
                                                    </div>
                                                </div>

                                                <form action="${pageContext.request.contextPath}/admin" method="post">
                                                    <input type="hidden" name="action" value="deleteBrandPartner"/>
                                                    <input type="hidden" name="brandId" value="${bp.id}"/>
                                                    <button type="submit"
                                                            style="padding: 4px 8px; background-color: var(--color-danger-bg); color: var(--color-danger-text); border: 1px solid var(--color-danger-border); border-radius: var(--radius-sm); font-size: 11px;">
                                                        Xóa
                                                    </button>
                                                </form>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <!-- MỤC 6: QUẢN LÝ DANH MỤC CƠ KHÍ & LIÊN KẾT TRANG CHỦ -->
                <section id="panel-categories" class="admin-tab-panel ${activeTab == 'categories' ? 'active' : ''}">
                    <div class="panel-card">
                        <div class="panel-card-header">
                            <div class="panel-card-title">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <line x1="8" y1="6" x2="21" y2="6"></line>
                                    <line x1="8" y1="12" x2="21" y2="12"></line>
                                    <line x1="8" y1="18" x2="21" y2="18"></line>
                                    <line x1="3" y1="6" x2="3.01" y2="6"></line>
                                    <line x1="3" y1="12" x2="3.01" y2="12"></line>
                                    <line x1="3" y1="18" x2="3.01" y2="18"></line>
                                </svg>
                                <span>MỤC 6: QUẢN LÝ DANH MỤC CƠ KHÍ &amp; LIÊN KẾT TRANG CHỦ</span>
                            </div>
                            <span class="dispatch-tag tabular-nums">Tổng số: <c:out value="${categories.size()}"/> danh mục</span>
                        </div>

                        <div class="panel-card-body">
                            <!-- Bố cục 2 cột: Cột trái form Thêm/Sửa - Cột phải Bảng danh mục -->
                            <div style="display: grid; grid-template-columns: minmax(320px, 380px) minmax(0, 1fr); gap: 24px;">
                                <!-- Cột trái: Form Thêm / Sửa Danh mục -->
                                <div>
                                    <h3 id="catFormTitle" style="font-size: 16px; color: var(--color-navy-deep); margin-bottom: 12px; display: flex; align-items: center; justify-content: space-between;">
                                        <span>Thêm danh mục cơ khí mới</span>
                                        <button type="button" id="btnCancelEditCat" onclick="resetCategoryForm()" style="display: none; padding: 2px 8px; font-size: 11px; background-color: var(--color-bg-base); border: 1px solid var(--color-border-hairline); border-radius: var(--radius-sm); cursor: pointer;">Hủy sửa</button>
                                    </h3>
                                    <form id="categoryForm" action="${pageContext.request.contextPath}/admin" method="post">
                                        <input type="hidden" id="catFormAction" name="action" value="addCategory"/>

                                        <div class="form-group">
                                            <label class="form-label" for="catId">1. Mã định danh (ID / Slug)</label>
                                            <input type="text"
                                                   id="catId"
                                                   name="id"
                                                   class="form-control"
                                                   placeholder="VD: CAT-BO-HOI (để trống tự sinh)"
                                                   required/>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label" for="catName">2. Tên danh mục hiển thị</label>
                                            <input type="text"
                                                   id="catName"
                                                   name="name"
                                                   class="form-control"
                                                   placeholder="VD: Phụ tùng động cơ & Bộ hơi"
                                                   required/>
                                        </div>

                                        <div class="form-row-2">
                                            <div class="form-group">
                                                <label class="form-label" for="catGroup">3. Phân hệ chính</label>
                                                <select id="catGroup" name="groupType" class="form-control">
                                                    <option value="MARINE">Máy thủy &amp; Sà lan</option>
                                                    <option value="TRUCK">Xe tải nặng &amp; Đầu kéo</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label class="form-label" for="catTechCode">4. Mã kỹ thuật</label>
                                                <input type="text"
                                                       id="catTechCode"
                                                       name="technicalCode"
                                                       class="form-control"
                                                       placeholder="VD: MECH-01"/>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label" for="catTargetUrl">5. Link lọc khi bấm (Target URL)</label>
                                            <input type="text"
                                                   id="catTargetUrl"
                                                   name="targetUrl"
                                                   class="form-control"
                                                   placeholder="VD: /san-pham?q=Bộ+hơi hoặc brand=Advance"
                                                   required/>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label" for="catIconType">6. Loại icon SVG</label>
                                            <select id="catIconType" name="iconType" class="form-control">
                                                <option value="engine">engine (Động cơ &amp; Bộ hơi)</option>
                                                <option value="pump">pump (Bơm nước &amp; Sinh hàn)</option>
                                                <option value="gearbox">gearbox (Hộp số thủy Advance)</option>
                                                <option value="injector">injector (Kim phun Common Rail)</option>
                                                <option value="turbo">turbo (Turbo tăng áp Holset)</option>
                                                <option value="bearing">bearing (Bạc biên &amp; Balie)</option>
                                                <option value="clutch">clutch (Bàn ép lá côn HD320)</option>
                                                <option value="crown">crown (Vành chậu cùi dứa Hino)</option>
                                                <option value="brake">brake (Bầu phanh lốc kê Howo)</option>
                                                <option value="propeller">propeller (Bạc trục chân vịt)</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label" for="catDesc">7. Mô tả kỹ thuật ngắn</label>
                                            <textarea id="catDesc"
                                                      name="description"
                                                      rows="2"
                                                      class="form-control"
                                                      placeholder="Mô tả tóm tắt chủng loại phụ tùng trong danh mục..."></textarea>
                                        </div>

                                        <button type="submit" id="catSubmitBtn" class="btn-primary-orange" style="width: 100%;">
                                            <span>Thêm Danh Mục Cơ Khí</span>
                                        </button>
                                    </form>
                                </div>

                                <!-- Cột phải: Bảng danh sách Danh mục cơ khí -->
                                <div>
                                    <h3 style="font-size: 16px; color: var(--color-navy-deep); margin-bottom: 12px;">
                                        Danh sách hệ thống cơ khí đang hiển thị Trang chủ:
                                    </h3>
                                    <div style="overflow-x: auto;">
                                        <table class="data-table" aria-label="Bảng quản lý danh mục cơ khí">
                                            <thead>
                                                <tr>
                                                    <th style="width: 45px;">Icon</th>
                                                    <th>Tên danh mục &amp; ID</th>
                                                    <th>Phân hệ</th>
                                                    <th>Link điều hướng</th>
                                                    <th style="text-align: center; width: 110px;">Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="cat" items="${categories}">
                                                    <tr>
                                                        <td style="text-align: center;">
                                                            <div style="width: 32px; height: 32px; border-radius: 4px; background: var(--color-bg-base); border: 1px solid var(--color-border-hairline); display: inline-flex; align-items: center; justify-content: center; color: var(--color-navy-primary);">
                                                                <c:choose>
                                                                    <c:when test="${cat.iconType == 'engine'}">
                                                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="4" y="3" width="16" height="18" rx="2"></rect><line x1="8" y1="8" x2="16" y2="8"></line><line x1="12" y1="8" x2="12" y2="18"></line></svg>
                                                                    </c:when>
                                                                    <c:when test="${cat.iconType == 'pump'}">
                                                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="9"></circle><circle cx="12" cy="12" r="3"></circle></svg>
                                                                    </c:when>
                                                                    <c:when test="${cat.iconType == 'gearbox'}">
                                                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="3"></circle><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4"></path></svg>
                                                                    </c:when>
                                                                    <c:when test="${cat.iconType == 'injector'}">
                                                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z"></path></svg>
                                                                    </c:when>
                                                                    <c:when test="${cat.iconType == 'turbo'}">
                                                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M12 2a10 10 0 1 0 10 10H12V2z"></path></svg>
                                                                    </c:when>
                                                                    <c:when test="${cat.iconType == 'bearing'}">
                                                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="10"></circle><circle cx="12" cy="12" r="6"></circle></svg>
                                                                    </c:when>
                                                                    <c:when test="${cat.iconType == 'clutch'}">
                                                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="9"></circle><line x1="12" y1="3" x2="12" y2="21"></line></svg>
                                                                    </c:when>
                                                                    <c:when test="${cat.iconType == 'crown'}">
                                                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><polygon points="12 2 2 7 12 12 22 7 12 2"></polygon><polyline points="2 17 12 22 22 17"></polyline></svg>
                                                                    </c:when>
                                                                    <c:when test="${cat.iconType == 'brake'}">
                                                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="3" y="6" width="18" height="12" rx="2"></rect><line x1="7" y1="12" x2="17" y2="12"></line></svg>
                                                                    </c:when>
                                                                    <c:when test="${cat.iconType == 'propeller'}">
                                                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="5" r="3"></circle><line x1="12" y1="22" x2="12" y2="8"></line><path d="M5 12H2a10 10 0 0 0 20 0h-3"></path></svg>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><polygon points="12 2 2 7 12 12 22 7 12 2"></polygon><polyline points="2 17 12 22 22 17"></polyline></svg>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div style="font-weight: 600; color: var(--color-navy-deep); font-size: 13px;">
                                                                <c:out value="${cat.name}"/>
                                                            </div>
                                                            <div style="font-size: 11px; color: var(--color-text-muted); font-family: monospace;">
                                                                ID: <c:out value="${cat.id}"/> | Mã: <c:out value="${cat.technicalCode}"/>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <span class="stock-badge ${cat.groupType == 'MARINE' ? 'instock' : 'order'}" style="font-size: 11px; padding: 2px 6px;">
                                                                <c:out value="${cat.groupType == 'MARINE' ? 'Máy Thủy' : 'Xe Tải'}"/>
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <div style="font-size: 12px; color: var(--color-navy-primary); max-width: 170px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;" title="<c:out value='${cat.targetUrl}'/>">
                                                                <c:out value="${cat.targetUrl}"/>
                                                            </div>
                                                            <div style="font-size: 10px; color: var(--color-text-muted);">
                                                                Icon: <c:out value="${cat.iconType}"/>
                                                            </div>
                                                        </td>
                                                        <td style="text-align: center; white-space: nowrap;">
                                                            <div style="display: flex; gap: 6px; justify-content: center;">
                                                                <button type="button"
                                                                        class="btn-edit-cat"
                                                                        style="padding: 4px 8px; background-color: var(--color-bg-base); color: var(--color-navy-primary); border: 1px solid var(--color-border-hairline); border-radius: var(--radius-sm); font-size: 11px; cursor: pointer;"
                                                                        data-id="<c:out value='${cat.id}'/>"
                                                                        data-name="<c:out value='${cat.name}'/>"
                                                                        data-group="<c:out value='${cat.groupType}'/>"
                                                                        data-tech="<c:out value='${cat.technicalCode}'/>"
                                                                        data-url="<c:out value='${cat.targetUrl}'/>"
                                                                        data-icon="<c:out value='${cat.iconType}'/>"
                                                                        data-desc="<c:out value='${cat.description}'/>"
                                                                        onclick="editCategoryFromRow(this)">
                                                                    Sửa
                                                                </button>
                                                                <form action="${pageContext.request.contextPath}/admin" method="post" onsubmit="return confirm('Xác nhận xóa danh mục cơ khí: ${cat.name}?');" style="display: inline;">
                                                                    <input type="hidden" name="action" value="deleteCategory"/>
                                                                    <input type="hidden" name="id" value="<c:out value='${cat.id}'/>"/>
                                                                    <button type="submit"
                                                                            style="padding: 4px 8px; background-color: var(--color-danger-bg); color: var(--color-danger-text); border: 1px solid var(--color-danger-border); border-radius: var(--radius-sm); font-size: 11px; cursor: pointer;">
                                                                        Xóa
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </main>

    <script>
        // 1. Chuyển đổi Mục lục Quản trị (Table of Contents Tabs) mượt mà không cần tải lại trang
        function switchAdminTab(tabName) {
            const tocButtons = document.querySelectorAll("[data-admin-tab]");
            const tabPanels = document.querySelectorAll(".admin-tab-panel");

            tocButtons.forEach(function (btn) {
                if (btn.getAttribute("data-admin-tab") === tabName) {
                    btn.classList.add("active");
                } else {
                    btn.classList.remove("active");
                }
            });

            tabPanels.forEach(function (panel) {
                if (panel.id === "panel-" + tabName) {
                    panel.classList.add("active");
                } else {
                    panel.classList.remove("active");
                }
            });
        }

        // 2. Đóng / Mở ngăn kéo tải ảnh của từng dòng sản phẩm trong Mục 2
        function toggleImageDrawer(drawerId) {
            const drawer = document.getElementById(drawerId);
            if (drawer) {
                drawer.classList.toggle("open");
            }
        }

        // 3. Quản lý danh mục cơ khí (Sửa / Hủy sửa) trong Mục 6
        function editCategoryFromRow(btn) {
            switchAdminTab("categories");
            const titleElem = document.getElementById("catFormTitle");
            if (titleElem) {
                const span = titleElem.querySelector("span");
                if (span) span.textContent = "Cập nhật danh mục cơ khí";
            }
            const btnCancel = document.getElementById("btnCancelEditCat");
            if (btnCancel) btnCancel.style.display = "inline-block";

            document.getElementById("catFormAction").value = "updateCategory";
            const catIdInput = document.getElementById("catId");
            catIdInput.value = btn.getAttribute("data-id") || "";
            catIdInput.readOnly = true;

            document.getElementById("catName").value = btn.getAttribute("data-name") || "";
            document.getElementById("catGroup").value = btn.getAttribute("data-group") || "MARINE";
            document.getElementById("catTechCode").value = btn.getAttribute("data-tech") || "";
            document.getElementById("catTargetUrl").value = btn.getAttribute("data-url") || "";
            document.getElementById("catIconType").value = btn.getAttribute("data-icon") || "engine";
            document.getElementById("catDesc").value = btn.getAttribute("data-desc") || "";

            const submitBtn = document.getElementById("catSubmitBtn");
            if (submitBtn) {
                const span = submitBtn.querySelector("span");
                if (span) span.textContent = "Lưu Cập Nhật Danh Mục";
            }

            const form = document.getElementById("categoryForm");
            if (form) {
                form.scrollIntoView({ behavior: "smooth", block: "nearest" });
            }
        }

        function resetCategoryForm() {
            const titleElem = document.getElementById("catFormTitle");
            if (titleElem) {
                const span = titleElem.querySelector("span");
                if (span) span.textContent = "Thêm danh mục cơ khí mới";
            }
            const btnCancel = document.getElementById("btnCancelEditCat");
            if (btnCancel) btnCancel.style.display = "none";

            document.getElementById("catFormAction").value = "addCategory";
            const catIdInput = document.getElementById("catId");
            catIdInput.value = "";
            catIdInput.readOnly = false;
            document.getElementById("categoryForm").reset();

            const submitBtn = document.getElementById("catSubmitBtn");
            if (submitBtn) {
                const span = submitBtn.querySelector("span");
                if (span) span.textContent = "Thêm Danh Mục Cơ Khí";
            }
        }

        document.addEventListener("DOMContentLoaded", function () {
            const tocButtons = document.querySelectorAll("[data-admin-tab]");
            tocButtons.forEach(function (btn) {
                btn.addEventListener("click", function () {
                    const target = btn.getAttribute("data-admin-tab");
                    switchAdminTab(target);
                });
            });

            // 3. Tìm kiếm nhanh trong bảng Tồn kho Mục 2
            const invSearch = document.getElementById("adminInventorySearch");
            const invRows = document.querySelectorAll(".admin-inv-row");
            if (invSearch && invRows.length > 0) {
                invSearch.addEventListener("input", function () {
                    const kw = invSearch.value.trim().toLowerCase();
                    invRows.forEach(function (row) {
                        const text = (row.getAttribute("data-inv-search") || "").toLowerCase();
                        row.style.display = (kw === "" || text.indexOf(kw) !== -1) ? "" : "none";
                    });
                });
            }

            // 4. Xem trước ảnh ngay khi chọn file hoặc dán URL ở Mục 3
            const fileInput = document.getElementById("newImageFile");
            const urlInput = document.getElementById("newImageUrl");
            const previewWrap = document.getElementById("newProductImagePreviewWrap");
            const previewImg = document.getElementById("newProductImagePreview");

            if (fileInput && previewWrap && previewImg) {
                fileInput.addEventListener("change", function () {
                    if (fileInput.files && fileInput.files[0]) {
                        const reader = new FileReader();
                        reader.onload = function (e) {
                            previewImg.src = e.target.result;
                            previewWrap.style.display = "block";
                        };
                        reader.readAsDataURL(fileInput.files[0]);
                    }
                });
            }

            if (urlInput && previewWrap && previewImg) {
                urlInput.addEventListener("input", function () {
                    const val = urlInput.value.trim();
                    if (val.length > 5 && (!fileInput || !fileInput.files || fileInput.files.length === 0)) {
                        previewImg.src = val;
                        previewWrap.style.display = "block";
                    }
                });
            }
        });
    </script>

</body>
</html>
