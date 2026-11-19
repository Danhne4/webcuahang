<%@page contentType="text/html" pageEncoding="UTF-8"%>

<footer class="site-footer">
    <div class="container">
        <div class="footer-grid">
            <!-- Cột 1: Logo chính thức Cửa Hàng Thoại Hằng + Huy hiệu Đã thông báo Bộ Công Thương -->
            <div>
                <div class="footer-logo-card">
                    <img src="${pageContext.request.contextPath}/images/logo-thoai-hang.jpg"
                         alt="Cửa Hàng Thoại Hằng - Phụ Tùng Tàu Thuyền - Xe Tải"/>
                </div>

                <p style="font-size: 13px; color: var(--color-text-inverse-muted); line-height: 1.6;">
                    Chuyên nhập khẩu và phân phối phụ tùng cơ khí đại tu máy thủy (Yanmar, Cummins, Mitsubishi, hộp số Advance) và phụ tùng xe tải nặng (Hino 500/700, Hyundai HD320, Sinotruk Howo 371).
                </p>

                <div class="bct-verified-badge">
                    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                        <polyline points="22 4 12 14.01 9 11.01"></polyline>
                    </svg>
                    <div>
                        <div>ĐÃ THÔNG BÁO</div>
                        <div style="font-size: 11px; font-weight: 400;">BỘ CÔNG THƯƠNG &amp; VR</div>
                    </div>
                </div>
            </div>

            <!-- Cột 2: DANH MỤC (Chuẩn dấu › BinhMinhJSC) -->
            <div>
                <div class="footer-heading">DANH MỤC</div>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/home">› Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/home#khoi-nhom-thuong-hieu">› Giới thiệu Tổng kho</a></li>
                    <li><a href="${pageContext.request.contextPath}/san-pham">› Siêu thị phụ tùng</a></li>
                    <li><a href="${pageContext.request.contextPath}/san-pham?category=MAY-THUY">› Phụ tùng Đại tu Máy Thủy</a></li>
                    <li><a href="${pageContext.request.contextPath}/san-pham?category=XE-TAI-NANG">› Phụ tùng Xe Tải Nặng</a></li>
                    <li><a href="${pageContext.request.contextPath}/gio-hang">› Đặt hàng Gửi Chành Xe 24/7</a></li>
                    <li><a href="${pageContext.request.contextPath}/home#bao-gia-b2b">› Báo giá Đại tu B2B</a></li>
                </ul>
            </div>

            <!-- Cột 3: CHĂM SÓC KHÁCH HÀNG & KẾT NỐI -->
            <div>
                <div class="footer-heading">CHĂM SÓC KHÁCH HÀNG</div>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/san-pham">› Tìm kiếm mã chuẩn OEM</a></li>
                    <li><a href="${pageContext.request.contextPath}/gio-hang">› Chính sách vận chuyển Chành xe</a></li>
                    <li><a href="${pageContext.request.contextPath}/home#bao-gia-b2b">› Bảo mật thông tin khách hàng</a></li>
                    <li><a href="${pageContext.request.contextPath}/home#bao-gia-b2b">› Chính sách bảo hành dung sai H7</a></li>
                    <li><a href="${pageContext.request.contextPath}/gio-hang">› Hình thức thanh toán &amp; Hóa đơn VAT</a></li>
                    <li><a href="${pageContext.request.contextPath}/home#bao-gia-b2b">› Điều khoản dịch vụ &amp; CO/CQ</a></li>
                </ul>
            </div>

            <!-- Cột 4: LIÊN HỆ & HỆ THỐNG 2 TỔNG KHO -->
            <div>
                <div class="footer-heading">LIÊN HỆ</div>
                <div class="footer-links" style="font-size: 13px; line-height: 1.55;">
                    <strong style="color: var(--color-text-inverse);">Cửa Hàng Phụ Tùng Cơ Khí Thoại Hằng (Thoại Hằng Heavy Parts)</strong>
                    <div>
                        <strong style="color: var(--color-gold-accent);">Kho Hải Phòng:</strong> Khu dịch vụ Hàng hải Cảng Chùa Vẽ, Quận Hải An, TP. Hải Phòng.
                    </div>
                    <div>
                        <strong style="color: var(--color-gold-accent);">Kho TP.HCM:</strong> Quốc lộ 1A, Bến xe Miền Đông mới / Cầu Đồng Nai, TP. Thủ Đức, TP.HCM.
                    </div>
                    <div>
                        <strong>Hotline Kỹ thuật 24/7:</strong> <span class="tabular-nums" style="color: var(--color-gold-accent); font-weight: 600;">0912.345.678</span>
                    </div>
                    <div>
                        <strong>Email:</strong> kythuat@thoaihangpart.example
                    </div>
                </div>
            </div>
        </div>

        <!-- DẢI HUY HIỆU HÌNH THỨC THANH TOÁN & VẬN CHUYỂN CHUẨN BINHMINHJSC -->
        <div class="payment-methods-block">
            <div class="payment-methods-title">HÌNH THỨC THANH TOÁN &amp; ĐỐI TÁC CHÀNH XE</div>
            <div class="payment-badges-row">
                <span class="payment-badge-item" style="color: #D97706;">GeoTrust</span>
                <span class="payment-badge-item" style="color: #DC2626;">C O D</span>
                <span class="payment-badge-item" style="color: #1D2C7B;">TÔ CHÂU</span>
                <span class="payment-badge-item" style="color: #C2410C;">FUTA Express</span>
                <span class="payment-badge-item" style="color: #0284C7;">VietinBank</span>
                <span class="payment-badge-item" style="color: #1E3A8A;">VISA</span>
                <span class="payment-badge-item" style="color: #B91C1C;">MasterCard</span>
                <span class="payment-badge-item" style="color: #15803D;">J C B</span>
            </div>
        </div>

        <div class="footer-bottom">
            <span>&copy; Bản quyền thuộc về <strong style="color: var(--color-gold-accent);">Cửa Hàng Phụ Tùng Cơ Khí Thoại Hằng (Thoại Hằng Heavy Parts)</strong>.</span>
            <span>Kho Hải Phòng (Cảng Chùa Vẽ) | Kho TP.HCM (BX Miền Đông Mới / Cầu Đồng Nai) | Hotline: 0912.345.678</span>
        </div>
    </div>
</footer>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
