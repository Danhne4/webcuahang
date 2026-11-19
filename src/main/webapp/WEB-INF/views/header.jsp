<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<!-- TẦNG 1: TOP BAR NỀN XANH NƯỚC BIỂN ĐẬM (Cuộn qua tự nhiên khi lăn chuột xuống) -->
<div class="header-tier-1">
    <div class="container tier-1-inner">
        <div class="warehouse-strip">
            <span class="warehouse-item">
                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
                    <circle cx="12" cy="10" r="3"></circle>
                </svg>
                <strong>Kho Hải Phòng:</strong> Cảng Chùa Vẽ, Hải An
            </span>
            <span class="warehouse-item">
                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
                    <circle cx="12" cy="10" r="3"></circle>
                </svg>
                <strong>Kho TP.HCM:</strong> Bến xe Miền Đông mới / Cầu Đồng Nai
            </span>
        </div>

        <div class="hotline-strip">
            <span class="dispatch-tag">Trực xuất kho gửi Chành xe &amp; Cảng cá 24/7</span>
            <span>Kiểm định Panme dung sai H7 | VAT &amp; CO/CQ</span>
        </div>
    </div>
</div>

<!-- TẦNG 2: THANH HEADER CHÍNH (GHIM CỐ ĐỊNH & TỰ THU NHỎ KHI LĂN CHUỘT XUỐNG: CHỈ HIỂN THỊ LOGO + TÌM KIẾM + LIÊN HỆ) -->
<header id="stickyMainHeader" class="header-tier-2">
    <div class="container tier-2-inner">
        <a href="${pageContext.request.contextPath}/home" class="brand-logo" aria-label="Cửa Hàng Thoại Hằng - Phụ Tùng Tàu Thuyền - Xe Tải">
            <img src="${pageContext.request.contextPath}/images/logo-thoai-hang.jpg"
                 alt="Cửa Hàng Thoại Hằng - Phụ Tùng Tàu Thuyền - Xe Tải"
                 class="brand-logo-official"/>
        </a>

        <form action="${pageContext.request.contextPath}/san-pham" method="get" class="search-bar-form" role="search">
            <input type="text"
                   name="q"
                   value="<c:out value='${searchKeyword}'/>"
                   class="search-input"
                   placeholder="Nhập Mã hàng, Tên hàng hoặc Tên thương hiệu (VD: 119574-42502, Yanmar, Cummins, Hino...)"
                   aria-label="Nhập Mã hàng, Tên hàng hoặc Tên thương hiệu"/>
            <button type="submit" class="search-submit-btn">
                <span>Search</span>
            </button>
        </form>

        <div class="header-actions">
            <a href="${pageContext.request.contextPath}/gio-hang" class="cart-trigger-btn" aria-label="Xem giỏ hàng và đặt gửi chành xe">
                <span class="cart-icon-wrap">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <circle cx="9" cy="21" r="1"></circle>
                        <circle cx="20" cy="21" r="1"></circle>
                        <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                    </svg>
                </span>
                <span class="cart-count-badge tabular-nums">
                    <c:out value="${not empty sessionScope.cartCount ? sessionScope.cartCount : 0}"/>
                </span>
            </a>

            <a href="tel:0912345678" class="hotline-badge" aria-label="Gọi Hotline kỹ thuật 0912.345.678">
                <svg width="19" height="19" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
                </svg>
                <span>Hotline: 0912.345.678</span>
            </a>
        </div>
    </div>
</header>

<!-- TẦNG 3: NÚT VÀNG "DANH MỤC SẢN PHẨM" 250PX + THANH MENU 7 Ô CÓ ICON TRÊN CHỮ (Ẩn đi khi lăn chuột xuống) -->
<nav class="header-tier-3" aria-label="Điều hướng chính">
    <div class="container tier-3-inner">
        <a href="${pageContext.request.contextPath}/san-pham" class="category-master-btn">
            <span>DANH MỤC SẢN PHẨM</span>
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <polyline points="6 9 12 15 18 9"></polyline>
            </svg>
        </a>

        <ul class="main-nav-list">
            <li>
                <a href="${pageContext.request.contextPath}/home"
                   class="main-nav-link ${activeMenu == 'home' ? 'active' : ''}">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                        <polyline points="9 22 9 12 15 12 15 22"></polyline>
                    </svg>
                    <span>Trang chủ</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/home#khoi-nhom-thuong-hieu"
                   class="main-nav-link">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                        <circle cx="9" cy="7" r="4"></circle>
                        <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                        <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                    </svg>
                    <span>Giới thiệu</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/san-pham"
                   class="main-nav-link ${activeMenu == 'products' ? 'active' : ''}">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <circle cx="12" cy="12" r="3"></circle>
                        <path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 2.83-2.83l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z"></path>
                    </svg>
                    <span>Siêu thị phụ tùng</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/san-pham?category=MAY-THUY"
                   class="main-nav-link ${activeMenu == 'marine' ? 'active' : ''}">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <circle cx="12" cy="5" r="3"></circle>
                        <line x1="12" y1="22" x2="12" y2="8"></line>
                        <path d="M5 12H2a10 10 0 0 0 20 0h-3"></path>
                    </svg>
                    <span>Máy thủy</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/san-pham?category=XE-TAI-NANG"
                   class="main-nav-link ${activeMenu == 'truck' ? 'active' : ''}">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <rect x="1" y="3" width="15" height="13"></rect>
                        <polygon points="16 8 20 8 23 11 23 16 16 16 16 8"></polygon>
                        <circle cx="5.5" cy="18.5" r="2.5"></circle>
                        <circle cx="18.5" cy="18.5" r="2.5"></circle>
                    </svg>
                    <span>Xe tải nặng</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/gio-hang"
                   class="main-nav-link ${activeMenu == 'cart' || activeMenu == 'chanhxe' ? 'active' : ''}">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path>
                        <polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline>
                        <line x1="12" y1="22.08" x2="12" y2="12"></line>
                    </svg>
                    <span>Gửi chành xe</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/home#bao-gia-b2b"
                   class="main-nav-link">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                        <polyline points="14 2 14 8 20 8"></polyline>
                        <line x1="16" y1="13" x2="8" y2="13"></line>
                        <line x1="16" y1="17" x2="8" y2="17"></line>
                    </svg>
                    <span>Báo giá đại tu B2B</span>
                </a>
            </li>
        </ul>
    </div>
</nav>
