<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>CỔNG QUẢN LÝ THOẠI HẰNG - KHU VỰC NỘI BỘ BẢO MẬT</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

    <main class="admin-lock-screen">
        <div class="admin-vault-card">
            <div class="admin-vault-header">
                <div style="display: inline-flex; width: 52px; height: 52px; border-radius: var(--radius-sm); background-color: var(--color-gold-accent); color: var(--color-navy-deep); align-items: center; justify-content: center; margin-bottom: 12px;">
                    <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                        <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                    </svg>
                </div>
                <h1 style="font-size: 20px; font-weight: 600; color: var(--color-gold-accent);">
                    CỔNG QUẢN LÝ THOẠI HẰNG - KHU VỰC NỘI BỘ BẢO MẬT
                </h1>
                <p style="font-size: 13px; color: var(--color-text-inverse-muted); margin-top: 6px;">
                    Hệ thống Điều vận Tổng Kho Hải Phòng (Cảng Chùa Vẽ) &amp; Kho TP.HCM
                </p>
            </div>

            <div class="admin-vault-body">
                <!-- Cảnh báo khu vực dành riêng cho thủ kho -->
                <div class="security-alert-box">
                    <strong>CẢNH BÁO AN NINH NỘI BỘ:</strong> Đây là khu vực quản trị kho hàng và điều phối vận đơn chành xe dành riêng cho <strong>Thủ kho &amp; Ban quản lý Thoại Hằng Heavy Parts</strong>. Khách mua hàng vui lòng không truy cập trái phép.
                </div>

                <!-- Thông báo lỗi màu đỏ nếu nhập sai mật khẩu -->
                <c:if test="${not empty errorMessage}">
                    <div class="error-alert-box" role="alert">
                        <c:out value="${errorMessage}"/>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/admin-login" method="post">
                    <div class="form-group">
                        <label class="form-label" for="adminPassword">Mật khẩu Quản lý Kho Nội bộ (*)</label>
                        <input type="password"
                               id="adminPassword"
                               name="password"
                               required
                               autofocus
                               class="form-control"
                               placeholder="Nhập mật khẩu xác thực thủ kho..."/>
                    </div>

                    <button type="submit" class="btn-primary-orange" style="width: 100%; margin-top: 8px; margin-bottom: 16px;">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"></path>
                            <polyline points="10 17 15 12 10 7"></polyline>
                            <line x1="15" y1="12" x2="3" y2="12"></line>
                        </svg>
                        <span>Mở Khóa Hệ Thống Quản Trị Kho</span>
                    </button>
                </form>

                <div style="padding-top: 16px; border-top: 1px solid var(--color-border-hairline); text-align: center;">
                    <a href="${pageContext.request.contextPath}/home" class="btn-outline-navy" style="width: 100%;">
                        <span>Quay lại trang mua hàng cho khách</span>
                    </a>
                </div>
            </div>
        </div>
    </main>

</body>
</html>
