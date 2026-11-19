<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Cửa Hàng Phụ Tùng Cơ Khí Thoại Hằng - Thoại Hằng Heavy Parts (Máy Thủy &amp; Xe Tải Nặng)</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

    <jsp:include page="/WEB-INF/views/header.jsp"/>

    <main>

        <!-- HERO BANNER: CỘT TRÁI 250PX KHỚP NÚT DANH MỤC SẢN PHẨM | CỘT PHẢI SLIDER 10S & 4 CAM KẾT VÀNG -->
        <section class="hero-section">
            <div class="container hero-grid">
                <!-- Cột trái: Danh mục hệ thống cơ khí động lấy từ CSDL / Admin với icon tương ứng -->
                <aside class="mechanical-sidebar" aria-label="Danh mục hệ thống cơ khí">
                    <div class="mechanical-menu">
                        <c:forEach var="cat" items="${categories}">
                            <c:set var="targetLink" value="${cat.targetUrl}"/>
                            <c:choose>
                                <c:when test="${empty targetLink}">
                                    <c:set var="finalUrl" value="${pageContext.request.contextPath}/san-pham"/>
                                </c:when>
                                <c:when test="${targetLink.startsWith('http://') or targetLink.startsWith('https://')}">
                                    <c:set var="finalUrl" value="${targetLink}"/>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="finalUrl" value="${pageContext.request.contextPath}${targetLink.startsWith('/') ? '' : '/'}${targetLink}"/>
                                </c:otherwise>
                            </c:choose>
                            <a href="<c:out value='${finalUrl}'/>" class="mechanical-menu-item">
                                <span class="mech-item-left">
                                    <c:choose>
                                        <c:when test="${cat.iconType == 'engine'}">
                                            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                                <rect x="4" y="3" width="16" height="18" rx="2"></rect>
                                                <line x1="8" y1="8" x2="16" y2="8"></line>
                                                <line x1="12" y1="8" x2="12" y2="18"></line>
                                            </svg>
                                        </c:when>
                                        <c:when test="${cat.iconType == 'pump'}">
                                            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                                <circle cx="12" cy="12" r="9"></circle>
                                                <circle cx="12" cy="12" r="3"></circle>
                                            </svg>
                                        </c:when>
                                        <c:when test="${cat.iconType == 'gearbox'}">
                                            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                                <circle cx="12" cy="12" r="3"></circle>
                                                <path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4"></path>
                                            </svg>
                                        </c:when>
                                        <c:when test="${cat.iconType == 'injector'}">
                                            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                                <path d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z"></path>
                                            </svg>
                                        </c:when>
                                        <c:when test="${cat.iconType == 'turbo'}">
                                            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                                <path d="M12 2a10 10 0 1 0 10 10H12V2z"></path>
                                            </svg>
                                        </c:when>
                                        <c:when test="${cat.iconType == 'bearing'}">
                                            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                                <circle cx="12" cy="12" r="10"></circle>
                                                <circle cx="12" cy="12" r="6"></circle>
                                            </svg>
                                        </c:when>
                                        <c:when test="${cat.iconType == 'clutch'}">
                                            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                                <circle cx="12" cy="12" r="9"></circle>
                                                <line x1="12" y1="3" x2="12" y2="21"></line>
                                            </svg>
                                        </c:when>
                                        <c:when test="${cat.iconType == 'crown'}">
                                            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                                <polygon points="12 2 2 7 12 12 22 7 12 2"></polygon>
                                                <polyline points="2 17 12 22 22 17"></polyline>
                                            </svg>
                                        </c:when>
                                        <c:when test="${cat.iconType == 'brake'}">
                                            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                                <rect x="3" y="6" width="18" height="12" rx="2"></rect>
                                                <line x1="7" y1="12" x2="17" y2="12"></line>
                                            </svg>
                                        </c:when>
                                        <c:when test="${cat.iconType == 'propeller'}">
                                            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                                <circle cx="12" cy="5" r="3"></circle>
                                                <line x1="12" y1="22" x2="12" y2="8"></line>
                                                <path d="M5 12H2a10 10 0 0 0 20 0h-3"></path>
                                            </svg>
                                        </c:when>
                                        <c:otherwise>
                                            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                                <polygon points="12 2 2 7 12 12 22 7 12 2"></polygon>
                                                <polyline points="2 17 12 22 22 17"></polyline>
                                            </svg>
                                        </c:otherwise>
                                    </c:choose>
                                    <span class="mech-item-title"><c:out value="${cat.name}"/></span>
                                </span>
                                <span class="mech-chevron">›</span>
                            </a>
                        </c:forEach>
                    </div>
                </aside>

                <!-- Cột phải: Slider Banner giới thiệu (10s tự đổi hoặc bấm Next/Prev) & 4 Cam kết Kỹ thuật Vàng -->
                <div class="hero-right-column">
                    <div id="heroSliderWrapper" class="hero-slider-wrapper">
                        <!-- Nút bấm Prev / Next trực tiếp trên Banner -->
                        <button type="button" id="heroPrevBtn" class="hero-slider-nav-btn prev" aria-label="Slide trước">
                            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <polyline points="15 18 9 12 15 6"></polyline>
                            </svg>
                        </button>
                        <button type="button" id="heroNextBtn" class="hero-slider-nav-btn next" aria-label="Slide tiếp theo (Next)">
                            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <polyline points="9 18 15 12 9 6"></polyline>
                            </svg>
                        </button>

                        <c:forEach var="slide" items="${bannerSlides}" varStatus="st">
                            <div class="hero-slide-item ${st.first ? 'active' : ''}">
                                <c:choose>
                                    <c:when test="${slide.customUploadedImage}">
                                        <!-- Chế độ hiển thị nguyên tấm ảnh Banner do Admin tải lên -->
                                        <a href="${pageContext.request.contextPath}${slide.targetLink}">
                                            <img src="${slide.imageUrl}" alt="${slide.title}" class="hero-slide-full-img"/>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Chế độ bố cục chuẩn Công nghiệp BinhMinhJSC (Trái: Thông tin & Danh mục cụm chi tiết | Phải: Ảnh cụm phụ tùng) -->
                                        <div class="hero-slide-split">
                                            <div class="hero-slide-left">
                                                <div>
                                                    <div class="hero-slide-brand-title"><c:out value="${slide.title}"/></div>
                                                    <p class="hero-slide-subtitle"><c:out value="${slide.subtitle}"/></p>

                                                    <div class="hero-slide-mid">
                                                        <div class="hero-slide-icon-box" aria-hidden="true">
                                                            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                                <path d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z"></path>
                                                            </svg>
                                                        </div>
                                                        <ul class="hero-slide-bullets">
                                                            <c:forEach var="bItem" items="${slide.bulletList}">
                                                                <li><c:out value="${bItem}"/></li>
                                                            </c:forEach>
                                                        </ul>
                                                    </div>
                                                </div>

                                                <div class="hero-slide-bottom-bar">
                                                    <div>
                                                        <div style="font-size: 13px; font-weight: 600; color: var(--color-navy-primary);">
                                                            THOẠI HẰNG HEAVY PARTS
                                                        </div>
                                                        <div style="font-size: 12px; color: var(--color-text-muted);">
                                                            Chuẩn dung sai Panme H7 (L = 180mm ±0.02)
                                                        </div>
                                                    </div>
                                                    <a href="${pageContext.request.contextPath}${slide.targetLink}" class="btn-primary-orange" style="min-height: 40px; padding: 8px 16px; font-size: 14px;">
                                                        <span>Xem danh mục</span>
                                                    </a>
                                                </div>
                                            </div>

                                            <div class="hero-slide-right">
                                                <img src="${slide.imageUrl}" alt="${slide.title}"/>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:forEach>

                        <!-- Thanh điều khiển dưới của Slider (Chấm chọn Slide + Đồng hồ đếm ngược 10s + Nút Next) -->
                        <div class="hero-slider-controls-bar">
                            <div class="hero-slider-dots" role="tablist" aria-label="Chọn slide giới thiệu">
                                <c:forEach var="slide" items="${bannerSlides}" varStatus="st">
                                    <button type="button"
                                            class="hero-dot-btn ${st.first ? 'active' : ''}"
                                            data-slide-index="${st.index}"
                                            aria-label="Slide ${st.count}: ${slide.title}">
                                    </button>
                                </c:forEach>
                            </div>

                            <div style="display: flex; align-items: center; gap: 12px; font-size: 13px;">
                                <span style="color: var(--color-text-inverse-muted);">
                                    Tự động đổi ảnh sau: <strong id="heroTimerCountdown" class="tabular-nums" style="color: var(--color-gold-accent);">10s</strong>
                                </span>
                                <button type="button"
                                        onclick="document.getElementById('heroNextBtn').click();"
                                        style="background-color: var(--color-gold-accent); color: var(--color-navy-deep); border: none; padding: 4px 12px; border-radius: var(--radius-sm); font-size: 12px; font-weight: 600;">
                                    Next Slide
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- 4 CAM KẾT KỸ THUẬT VÀNG -->
                    <div class="hero-banner-card" style="padding: 18px 20px;">
                        <div class="commitments-grid" style="padding-top: 0; border-top: none;">
                            <div class="commitment-card">
                                <div class="commitment-icon" aria-hidden="true">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                        <polyline points="20 6 9 17 4 12"></polyline>
                                    </svg>
                                </div>
                                <div>
                                    <div class="commitment-title">1. Chuẩn xác mã OEM</div>
                                    <div class="commitment-desc">Đối chiếu đúng sơ đồ rã máy Yanmar, Cummins, Hino, Howo</div>
                                </div>
                            </div>

                            <div class="commitment-card">
                                <div class="commitment-icon" aria-hidden="true">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                        <circle cx="12" cy="12" r="10"></circle>
                                        <line x1="12" y1="8" x2="12" y2="12"></line>
                                        <line x1="12" y1="16" x2="12.01" y2="16"></line>
                                    </svg>
                                </div>
                                <div>
                                    <div class="commitment-title">2. Kiểm định Panme dung sai H7</div>
                                    <div class="commitment-desc">Đo kiểm dưỡng Panme từng cổ trục &amp; sơ mi trước khi giao</div>
                                </div>
                            </div>

                            <div class="commitment-card">
                                <div class="commitment-icon" aria-hidden="true">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                        <rect x="1" y="3" width="15" height="13"></rect>
                                        <polygon points="16 8 20 8 23 11 23 16 16 16 16 8"></polygon>
                                        <circle cx="5.5" cy="18.5" r="2.5"></circle>
                                        <circle cx="18.5" cy="18.5" r="2.5"></circle>
                                    </svg>
                                </div>
                                <div>
                                    <div class="commitment-title">3. Gửi chành xe 24/7</div>
                                    <div class="commitment-desc">Xuất hàng hỏa tốc ra xe Tô Châu, Phương Trang, cảng biển</div>
                                </div>
                            </div>

                            <div class="commitment-card">
                                <div class="commitment-icon" aria-hidden="true">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                                        <polyline points="14 2 14 8 20 8"></polyline>
                                        <line x1="16" y1="13" x2="8" y2="13"></line>
                                        <line x1="16" y1="17" x2="8" y2="17"></line>
                                    </svg>
                                </div>
                                <div>
                                    <div class="commitment-title">4. Hóa đơn VAT &amp; CO/CQ</div>
                                    <div class="commitment-desc">Chứng từ nhập khẩu đầy đủ phục vụ nghiệm thu đăng kiểm</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- DẢI BĂNG CHUYỀN LOGO THƯƠNG HIỆU ĐỐI TÁC CHUYỂN ĐỘNG (CHUẨN ẢNH 1) -->
        <section class="brands-section">
            <div class="container">
                <div class="brand-marquee-container">
                    <div class="brands-header">
                        <div class="brands-title">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
                            </svg>
                            <span>THƯƠNG HIỆU ĐỐI TÁC PHÂN PHỐI CHÍNH HÃNG (BĂNG CHUYỀN TỰ ĐỘNG)</span>
                        </div>
                        <span style="font-size: 13px; color: var(--color-text-muted);">Rê chuột vào để dừng tạm thời hoặc nhấp chọn thương hiệu để lọc mã OEM</span>
                    </div>

                    <div class="brand-marquee-viewport">
                        <div class="brand-marquee-track">
                            <!-- Lượt 1: Danh sách các thương hiệu đối tác -->
                            <c:forEach var="bp" items="${brandPartners}">
                                <a href="${pageContext.request.contextPath}/san-pham?q=${bp.name}"
                                   class="brand-logo-card"
                                   title="${bp.name} - ${bp.subtitle}">
                                    <img src="${bp.logoUrl}" alt="${bp.name}" class="brand-logo-img"/>
                                </a>
                            </c:forEach>
                            <!-- Lượt 2: Nhân đôi danh sách để tạo hiệu ứng chuyển động vòng lặp vô tận mượt mà -->
                            <c:forEach var="bp" items="${brandPartners}">
                                <a href="${pageContext.request.contextPath}/san-pham?q=${bp.name}"
                                   class="brand-logo-card"
                                   title="${bp.name} - ${bp.subtitle}"
                                   aria-hidden="true"
                                   tabindex="-1">
                                    <img src="${bp.logoUrl}" alt="${bp.name}" class="brand-logo-img"/>
                                </a>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- DANH MỤC PHỤ TÙNG TRƯNG BÀY & LỌC NHANH THEO TAB / TỪ KHÓA THỜI GIAN THỰC -->
        <section id="kho-phu-tung-chinh" class="catalog-section" style="padding-bottom: 24px;">
            <div class="container">
                <div class="section-toolbar">
                    <div>
                        <h2 class="section-heading">KHO PHỤ TÙNG CƠ KHÍ ĐẠI TU CHÍNH HÃNG</h2>
                        <p class="section-subheading">
                            Hiển thị <strong id="visibleProductsCount" class="tabular-nums"><c:out value="${products.size()}"/></strong> mã OEM có sẵn tại Kho Hải Phòng &amp; Kho TP.HCM
                        </p>
                    </div>

                    <div class="filter-controls">
                        <!-- Tab lọc nhanh: Tất cả / Máy thủy / Xe tải nặng -->
                        <div class="tab-group" role="tablist" aria-label="Phân loại phụ tùng">
                            <a href="${pageContext.request.contextPath}/home?tab=ALL"
                               data-filter-tab="ALL"
                               data-client-filter="true"
                               class="tab-btn ${selectedTab == 'ALL' ? 'active' : ''}">
                                <span>Tất cả</span>
                                <span class="tab-count"><c:out value="${allCount}"/></span>
                            </a>
                            <a href="${pageContext.request.contextPath}/home?tab=MAY-THUY"
                               data-filter-tab="MAY-THUY"
                               data-client-filter="true"
                               class="tab-btn ${selectedTab == 'MAY-THUY' ? 'active' : ''}">
                                <span>Máy thủy</span>
                                <span class="tab-count"><c:out value="${marineCount}"/></span>
                            </a>
                            <a href="${pageContext.request.contextPath}/home?tab=XE-TAI-NANG"
                               data-filter-tab="XE-TAI-NANG"
                               data-client-filter="true"
                               class="tab-btn ${selectedTab == 'XE-TAI-NANG' ? 'active' : ''}">
                                <span>Xe tải nặng</span>
                                <span class="tab-count"><c:out value="${truckCount}"/></span>
                            </a>
                        </div>

                        <!-- Ô lọc từ khóa thời gian thực -->
                        <div class="realtime-search-box">
                            <input type="text"
                                   id="realtimeFilterInput"
                                   class="realtime-input"
                                   placeholder="Lọc nhanh mã OEM, tên máy trên trang..."
                                   aria-label="Lọc nhanh phụ tùng theo thời gian thực"/>
                        </div>
                    </div>
                </div>

                <!-- LƯỚI 12 SẢN PHẨM CƠ KHÍ THỰC TẾ -->
                <div class="products-grid">
                    <c:forEach var="p" items="${products}">
                        <article class="product-card"
                                 data-category="${p.category}"
                                 data-search="${p.name} ${p.oemCode} ${p.brand} ${p.engineModel} ${p.subSystem}">
                            <div>
                                <!-- Khung bản vẽ kỹ thuật thu nhỏ -->
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
                                                    <!-- Đường tâm nét gạch chấm -->
                                                    <line x1="8" y1="43" x2="172" y2="43" stroke="#F8C600" stroke-width="1.2" stroke-dasharray="10 4 2 4"/>
                                                    <line x1="90" y1="8" x2="90" y2="78" stroke="#F8C600" stroke-width="1" stroke-dasharray="6 3"/>
                                                    <!-- Khung mặt cắt cơ khí -->
                                                    <rect x="28" y="16" width="124" height="54" rx="3" stroke="#64B5F6" stroke-width="1.8" fill="rgba(56, 189, 248, 0.10)"/>
                                                    <rect x="18" y="28" width="144" height="30" stroke="#E2E8F0" stroke-width="1.5" fill="rgba(15, 23, 42, 0.45)"/>
                                                    <circle cx="90" cy="43" r="14" stroke="#F8C600" stroke-width="1.8"/>
                                                    <!-- Ký hiệu kích thước L=180mm -->
                                                    <text x="42" y="81" fill="#38BDF8" font-family="Consolas, monospace" font-size="9.5">L=180mm ±0.02 | H7</text>
                                                </svg>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>

                                    <div class="schematic-bottom-row">
                                        <span>CAD: <c:out value="${p.cadProfileType}"/></span>
                                        <span>ISO H7 (±0.02mm)</span>
                                    </div>
                                </div>

                                <div class="product-body">
                                    <div class="oem-code-row">
                                        <span class="oem-pill">OEM: <c:out value="${p.oemCode}"/></span>
                                        <span class="stock-pill">Sẵn kho: <c:out value="${p.stock}"/> bộ</span>
                                    </div>

                                    <h3 class="product-title">
                                        <a href="${pageContext.request.contextPath}/san-pham/chi-tiet?id=${p.id}">
                                            <c:out value="${p.name}"/>
                                        </a>
                                    </h3>

                                    <div class="product-meta-list">
                                        <div class="product-meta-item">
                                            <strong>Tương thích:</strong> <c:out value="${p.engineModel}"/>
                                        </div>
                                        <div class="product-meta-item">
                                            <strong>Dung sai:</strong> <c:out value="${p.toleranceSpec}"/>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="product-footer">
                                <div class="price-block">
                                    <span class="price-label">Giá xuất kho (Đã gồm VAT):</span>
                                    <span class="price-value"><c:out value="${p.formattedPrice}"/></span>
                                </div>

                                <div class="card-actions">
                                    <a href="${pageContext.request.contextPath}/san-pham/chi-tiet?id=${p.id}" class="btn-card-detail">
                                        <span>Bản vẽ CAD</span>
                                    </a>
                                    <form action="${pageContext.request.contextPath}/gio-hang" method="post">
                                        <input type="hidden" name="action" value="add"/>
                                        <input type="hidden" name="productId" value="${p.id}"/>
                                        <input type="hidden" name="quantity" value="1"/>
                                        <button type="submit" class="btn-card-add">
                                            <span>Chọn mua</span>
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </article>
                    </c:forEach>
                </div>

                <!-- Thông báo khi bộ lọc không khớp -->
                <div id="realtimeEmptyState" class="panel-card" style="display: none; padding: 32px; text-align: center; margin-top: 20px;">
                    <h3 style="font-size: 18px; color: var(--color-navy-deep);">Không tìm thấy mã OEM phù hợp với từ khóa lọc nhanh</h3>
                    <p style="font-size: 14px; color: var(--color-text-muted); margin-top: 8px;">
                        Quý khách vui lòng gọi Hotline kỹ thuật <strong>0912.345.678</strong> để kỹ sư tra danh mục phụ tùng thay thế tương đương.
                    </p>
                </div>
            </div>
        </section>

        <!-- KHỐI TRƯNG BÀY PHÂN HỆ THEO CHUẨN BINHMINHJSC (#index_col_group_1 & #index_col_group_2) -->
        <section id="khoi-nhom-thuong-hieu" class="bm-showcase-section">
            <div class="container">
                <!-- KHỐI 1: PHÂN HỆ ĐẠI TU MÁY THỦY (YANMAR / CUMMINS / ADVANCE / MITSUBISHI) -->
                <div class="bm-group-wrapper">
                    <div class="bm-group-block">
                        <div class="bm-group-left">
                            <div class="bm-group-nav-col">
                                <div class="bm-group-color-bar">PHÂN HỆ MÁY THỦY</div>
                                <div class="bm-group-logo-box">
                                    <div style="font-size: 18px; font-weight: 600; color: var(--color-navy-primary);">YANMAR &amp; CUMMINS</div>
                                    <div style="font-size: 11px; color: var(--color-text-muted); margin-top: 2px;">Marine Overhaul Division</div>
                                </div>
                                <div class="bm-group-subtabs">
                                    <a href="${pageContext.request.contextPath}/san-pham?q=Bộ+hơi" class="bm-group-subtab-link">Bộ hơi máy thủy</a>
                                    <a href="${pageContext.request.contextPath}/san-pham?q=Bơm+nước" class="bm-group-subtab-link">Bơm nước biển thân đồng</a>
                                    <a href="${pageContext.request.contextPath}/san-pham?q=sinh+hàn" class="bm-group-subtab-link">Ruột sinh hàn làm mát</a>
                                    <a href="${pageContext.request.contextPath}/san-pham?brand=Advance" class="bm-group-subtab-link">Lá côn hộp số Advance 135A</a>
                                    <a href="${pageContext.request.contextPath}/san-pham?brand=Mitsubishi" class="bm-group-subtab-link">Bạc biên - Bạc balie S6R2</a>
                                    <a href="${pageContext.request.contextPath}/san-pham?brand=Holset" class="bm-group-subtab-link">Turbo tăng áp Holset</a>
                                </div>
                            </div>

                            <div class="bm-group-poster-col">
                                <div>
                                    <span class="dispatch-tag">CẢNG CHÙA VẼ &amp; TP.HCM</span>
                                    <h3 style="font-size: 20px; font-weight: 600; color: var(--color-gold-accent); margin-top: 12px;">
                                        Tổng Kho Đại Tu Máy Thủy &amp; Sà Lan
                                    </h3>
                                    <p style="font-size: 13px; color: var(--color-text-inverse-muted); margin-top: 8px; line-height: 1.5;">
                                        Cung ứng vật tư đồng bộ cho tàu đánh bắt xa bờ, sà lan tự hành: Yanmar 6CH, Cummins 6BT/6CTA, Mitsubishi S6R2, hộp số Advance 135A.
                                    </p>
                                </div>
                                <div style="border-top: 1px dashed var(--color-border-inverse); padding-top: 12px; font-family: var(--font-mono); font-size: 12px; color: var(--color-gold-accent);">
                                    <div>• Dung sai: L = 180mm ±0.02</div>
                                    <div>• Cấp lắp ghép: ISO H7</div>
                                    <div>• Xuất chành xe 24/7</div>
                                </div>
                            </div>
                        </div>

                        <div style="display: grid; grid-template-columns: repeat(3, minmax(0, 1fr));">
                            <c:forEach var="p" items="${products}">
                                <c:if test="${p.category == 'MAY-THUY'}">
                                    <div style="padding: 16px; border-right: 1px solid var(--color-border-hairline); border-bottom: 1px solid var(--color-border-hairline); text-align: center; display: flex; flex-direction: column; justify-content: space-between;">
                                        <div>
                                            <div style="font-size: 14px; font-weight: 600; color: var(--color-navy-primary); line-height: 1.35;">
                                                <a href="${pageContext.request.contextPath}/san-pham/chi-tiet?id=${p.id}">
                                                    <c:out value="${p.name}"/>
                                                </a>
                                            </div>
                                            <div class="mono-code" style="font-size: 12px; color: var(--color-text-muted); margin-top: 6px;">
                                                <c:out value="${p.oemCode}"/>
                                            </div>
                                        </div>
                                        <div style="margin-top: 10px;">
                                            <div class="tabular-nums" style="font-size: 15px; font-weight: 600; color: var(--color-orange-burnt);">
                                                <c:out value="${p.formattedPrice}"/>
                                            </div>
                                            <a href="${pageContext.request.contextPath}/san-pham/chi-tiet?id=${p.id}"
                                               style="display: inline-block; margin-top: 6px; font-size: 12px; color: var(--color-navy-primary); text-decoration: underline;">
                                                Xem bản vẽ CAD
                                            </a>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="bm-group-more-row">
                        <a href="${pageContext.request.contextPath}/san-pham?category=MAY-THUY" class="bm-group-more-link">Xem tất cả</a>
                    </div>
                </div>

                <!-- KHỐI 2: PHÂN HỆ XE TẢI NẶNG & COMMON RAIL (DENSO / HINO 500-700 / HYUNDAI / HOWO) -->
                <div class="bm-group-wrapper">
                    <div class="bm-group-block">
                        <div class="bm-group-left">
                            <div class="bm-group-nav-col">
                                <div class="bm-group-color-bar denso-red">XE TẢI NẶNG &amp; DENSO</div>
                                <div class="bm-group-logo-box">
                                    <div style="font-size: 18px; font-weight: 600; color: var(--color-orange-burnt);">HINO &amp; DENSO</div>
                                    <div style="font-size: 11px; color: var(--color-text-muted); margin-top: 2px;">Heavy Truck &amp; Common Rail</div>
                                </div>
                                <div class="bm-group-subtabs">
                                    <a href="${pageContext.request.contextPath}/san-pham?brand=Denso" class="bm-group-subtab-link">Kim phun Common Rail</a>
                                    <a href="${pageContext.request.contextPath}/san-pham?brand=Hino" class="bm-group-subtab-link">Bộ hơi Hino 500 J08E</a>
                                    <a href="${pageContext.request.contextPath}/san-pham?brand=Hyundai" class="bm-group-subtab-link">Bàn ép 430mm Hyundai HD320</a>
                                    <a href="${pageContext.request.contextPath}/san-pham?q=vi+sai" class="bm-group-subtab-link">Vành chậu cùi dứa Hino 700</a>
                                    <a href="${pageContext.request.contextPath}/san-pham?brand=Howo" class="bm-group-subtab-link">Bầu phanh lốc kê Howo 371</a>
                                </div>
                            </div>

                            <div class="bm-group-poster-col" style="background-color: var(--color-navy-primary);">
                                <div>
                                    <span class="dispatch-tag">BX MIỀN ĐÔNG MỚI &amp; CẦU ĐỒNG NAI</span>
                                    <h3 style="font-size: 20px; font-weight: 600; color: var(--color-gold-accent); margin-top: 12px;">
                                        Tổng Kho Phụ Tùng Ô Tô Tải Nặng
                                    </h3>
                                    <p style="font-size: 13px; color: var(--color-text-inverse-muted); margin-top: 8px; line-height: 1.5;">
                                        Phân phối bộ hơi, kim phun điện tử Denso, bàn ép ly hợp và bộ truyền vi sai cầu sau cho Hino 500/700, Hyundai HD320, Sinotruk Howo 371.
                                    </p>
                                </div>
                                <div style="border-top: 1px dashed var(--color-border-inverse); padding-top: 12px; font-family: var(--font-mono); font-size: 12px; color: var(--color-gold-accent);">
                                    <div>• Kim phun QR ECU 1800 Bar</div>
                                    <div>• Thép rèn 20CrMnTi thấm C</div>
                                    <div>• Giao nhanh Tô Châu, FUTA</div>
                                </div>
                            </div>
                        </div>

                        <div style="display: grid; grid-template-columns: repeat(3, minmax(0, 1fr));">
                            <c:forEach var="p" items="${products}">
                                <c:if test="${p.category == 'XE-TAI-NANG'}">
                                    <div style="padding: 16px; border-right: 1px solid var(--color-border-hairline); border-bottom: 1px solid var(--color-border-hairline); text-align: center; display: flex; flex-direction: column; justify-content: space-between;">
                                        <div>
                                            <div style="font-size: 14px; font-weight: 600; color: var(--color-navy-primary); line-height: 1.35;">
                                                <a href="${pageContext.request.contextPath}/san-pham/chi-tiet?id=${p.id}">
                                                    <c:out value="${p.name}"/>
                                                </a>
                                            </div>
                                            <div class="mono-code" style="font-size: 12px; color: var(--color-text-muted); margin-top: 6px;">
                                                <c:out value="${p.oemCode}"/>
                                            </div>
                                        </div>
                                        <div style="margin-top: 10px;">
                                            <div class="tabular-nums" style="font-size: 15px; font-weight: 600; color: var(--color-orange-burnt);">
                                                <c:out value="${p.formattedPrice}"/>
                                            </div>
                                            <a href="${pageContext.request.contextPath}/san-pham/chi-tiet?id=${p.id}"
                                               style="display: inline-block; margin-top: 6px; font-size: 12px; color: var(--color-navy-primary); text-decoration: underline;">
                                                Xem bản vẽ CAD
                                            </a>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="bm-group-more-row">
                        <a href="${pageContext.request.contextPath}/san-pham?category=XE-TAI-NANG" class="bm-group-more-link">Xem tất cả</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- KHỐI BÁO GIÁ ĐẠI TU B2B & QUY TRÌNH GỬI CHÀNH XE -->
        <section id="bao-gia-b2b" style="padding-bottom: 32px;">
            <div class="container">
                <div class="panel-card">
                    <div class="panel-card-header">
                        <div class="panel-card-title">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                                <polyline points="14 2 14 8 20 8"></polyline>
                            </svg>
                            <span>DỊCH VỤ BÁO GIÁ ĐẠI TU ĐỒNG BỘ B2B &amp; GỬI CHÀNH XE TOÀN QUỐC</span>
                        </div>
                        <span class="dispatch-tag">Hỗ trợ xưởng đóng tàu &amp; đội xe vận tải</span>
                    </div>
                    <div class="panel-card-body">
                        <div class="commitments-grid" style="border-top: none; padding-top: 0;">
                            <div style="padding: 16px; background-color: var(--color-bg-subtle); border-radius: var(--radius-sm); border: 1px solid var(--color-border-hairline);">
                                <strong style="color: var(--color-navy-primary); display: block; margin-bottom: 6px;">Bước 1: Tiếp nhận Mã OEM / Số Khung Số Máy</strong>
                                <p style="font-size: 14px; color: var(--color-text-secondary);">Thuyền trưởng hoặc thợ máy gửi mã hiệu động cơ (VD: Yanmar 6CH, Cummins 6BT, Hino J08E) để đối chiếu sơ đồ rã máy.</p>
                            </div>
                            <div style="padding: 16px; background-color: var(--color-bg-subtle); border-radius: var(--radius-sm); border: 1px solid var(--color-border-hairline);">
                                <strong style="color: var(--color-navy-primary); display: block; margin-bottom: 6px;">Bước 2: Đo Kiểm Panme Dung Sai H7</strong>
                                <p style="font-size: 14px; color: var(--color-text-secondary);">Kỹ sư kho đo kiểm kích thước thực tế bằng Panme Mitutoyo Nhật Bản (L = 180mm ±0.02, cấp H7) kèm phiếu KCS.</p>
                            </div>
                            <div style="padding: 16px; background-color: var(--color-bg-subtle); border-radius: var(--radius-sm); border: 1px solid var(--color-border-hairline);">
                                <strong style="color: var(--color-navy-primary); display: block; margin-bottom: 6px;">Bước 3: Đóng Thùng Gỗ &amp; Giao Chành Xe</strong>
                                <p style="font-size: 14px; color: var(--color-text-secondary);">Bọc màng dầu chống gỉ, đóng kiện gỗ và chuyển ra nhà xe Tô Châu, Phương Trang, Viettel Post hoặc cảng cá trong 60 phút.</p>
                            </div>
                            <div style="padding: 16px; background-color: var(--color-bg-subtle); border-radius: var(--radius-sm); border: 1px solid var(--color-border-hairline);">
                                <strong style="color: var(--color-navy-primary); display: block; margin-bottom: 6px;">Bước 4: Gửi Mã Vận Đơn &amp; Hóa Đơn VAT</strong>
                                <p style="font-size: 14px; color: var(--color-text-secondary);">Cung cấp số phiếu gửi xe, biển số xe khách chở hàng, số điện thoại phụ xe và bộ hồ sơ CO/CQ gốc đi kèm.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <jsp:include page="/WEB-INF/views/footer.jsp"/>

</body>
</html>
