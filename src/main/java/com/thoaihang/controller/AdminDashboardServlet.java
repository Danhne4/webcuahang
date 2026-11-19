package com.thoaihang.controller;

import com.thoaihang.dao.ProductDAO;
import com.thoaihang.model.Category;
import com.thoaihang.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.Base64;

/**
 * Controller Quản trị Tổng Kho Nội Bộ (/admin).
 * Bắt buộc xác thực qua Session; nếu chưa đăng nhập lập tức chặn và chuyển hướng về /admin-login.
 * Hỗ trợ tải ảnh phụ tùng từ máy tính (Multipart Upload) hoặc gắn link ảnh trực tiếp cho từng mặt hàng.
 */
@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,      // 1 MB
        maxFileSize = 10 * 1024 * 1024,       // 10 MB
        maxRequestSize = 20 * 1024 * 1024     // 20 MB
)
public class AdminDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private boolean isAuthenticated(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && Boolean.TRUE.equals(session.getAttribute(AdminLoginServlet.ADMIN_SESSION_KEY));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        if (!isAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }

        ProductDAO dao = ProductDAO.getInstance();

        String activeTab = request.getParameter("tab");
        if (activeTab == null || activeTab.isBlank()) {
            activeTab = "orders";
        }

        request.setAttribute("products", dao.getAllProducts());
        request.setAttribute("orders", dao.getAllOrders());
        request.setAttribute("categories", dao.getCategories());
        request.setAttribute("bannerSlides", dao.getBannerSlides());
        request.setAttribute("brandPartners", dao.getBrandPartners());
        request.setAttribute("totalSkuCount", dao.getAllProducts().size());
        request.setAttribute("totalUnitsCount", dao.getTotalInventoryUnits());
        request.setAttribute("totalInventoryValue", dao.getFormattedTotalInventoryValue());
        request.setAttribute("totalOrdersRevenue", dao.getFormattedTotalOrdersRevenue());
        request.setAttribute("totalOrdersCount", dao.getAllOrders().size());
        request.setAttribute("activeTab", activeTab);

        request.getRequestDispatcher("/WEB-INF/views/admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        if (!isAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }

        HttpSession session = request.getSession();
        ProductDAO dao = ProductDAO.getInstance();
        String action = request.getParameter("action");
        String targetTab = "orders";

        if ("updateOrderStatus".equalsIgnoreCase(action)) {
            targetTab = "orders";
            String orderCode = request.getParameter("orderCode");
            String status = request.getParameter("status");
            boolean ok = dao.updateOrderStatus(orderCode, status);
            if (ok) {
                session.setAttribute("adminNotice",
                        "Đã cập nhật trạng thái đơn hàng chành xe [" + orderCode + "] sang: " + status);
            }
        } else if ("addProduct".equalsIgnoreCase(action)) {
            targetTab = "inventory";
            String name = request.getParameter("name");
            String oemCode = request.getParameter("oemCode");
            String brand = request.getParameter("brand");
            String category = request.getParameter("category");
            String subSystem = request.getParameter("subSystem");
            String engineModel = request.getParameter("engineModel");
            long price = parseLongSafe(request.getParameter("price"), 5000000L);
            int stock = parseIntSafe(request.getParameter("stock"), 10);
            String origin = request.getParameter("origin");
            String materialSpec = request.getParameter("materialSpec");
            String toleranceSpec = request.getParameter("toleranceSpec");
            String dimensions = request.getParameter("dimensions");
            double weightKg = parseDoubleSafe(request.getParameter("weightKg"), 10.0);
            String description = request.getParameter("description");
            String resolvedImage = resolveProductImage(request);

            if (name != null && !name.isBlank() && oemCode != null && !oemCode.isBlank()) {
                Product created = dao.addProduct(
                        name.trim(),
                        oemCode.trim(),
                        (brand != null && !brand.isBlank()) ? brand.trim() : "OEM Heavy",
                        (category != null && !category.isBlank()) ? category.trim() : "MAY-THUY",
                        subSystem,
                        engineModel,
                        price,
                        stock,
                        origin,
                        materialSpec,
                        toleranceSpec,
                        dimensions,
                        weightKg,
                        description,
                        resolvedImage
                );
                session.setAttribute("adminNotice",
                        "Đã nhập kho mã phụ tùng mới: [" + created.getName() + " - OEM: " + created.getOemCode()
                        + "]" + (created.isHasImage() ? " (Đã đính kèm ảnh phụ tùng)" : ""));
            }
        } else if ("updateStock".equalsIgnoreCase(action)) {
            targetTab = "inventory";
            int productId = parseIntSafe(request.getParameter("productId"), -1);
            int newStock = parseIntSafe(request.getParameter("stock"), 0);
            if (dao.updateProductStock(productId, newStock)) {
                session.setAttribute("adminNotice",
                        "Đã cập nhật số lượng tồn kho cho phụ tùng ID #" + productId + " thành " + newStock + " bộ.");
            }
        } else if ("updateImage".equalsIgnoreCase(action)) {
            targetTab = "inventory";
            int productId = parseIntSafe(request.getParameter("productId"), -1);
            String clearFlag = request.getParameter("clearImage");
            Product p = dao.getProductById(productId);
            if (p != null) {
                if ("true".equalsIgnoreCase(clearFlag)) {
                    dao.updateProductImage(productId, null);
                    session.setAttribute("adminNotice",
                            "Đã xóa ảnh thực tế và chuyển về chế độ Bản vẽ CAD cho mã OEM: " + p.getOemCode());
                } else {
                    String resolvedImage = resolveProductImage(request);
                    if (resolvedImage != null && !resolvedImage.isBlank()) {
                        dao.updateProductImage(productId, resolvedImage);
                        session.setAttribute("adminNotice",
                                "Đã cập nhật ảnh thực tế cho mặt hàng [" + p.getName() + " - OEM: " + p.getOemCode() + "] thành công.");
                    } else {
                        session.setAttribute("adminNotice",
                                "Vui lòng chọn tệp ảnh từ máy tính hoặc nhập đường dẫn URL ảnh cho mã OEM: " + p.getOemCode());
                    }
                }
            }
        } else if ("addBannerSlide".equalsIgnoreCase(action)) {
            targetTab = "banners";
            String title = request.getParameter("title");
            String subtitle = request.getParameter("subtitle");
            String bulletPoints = request.getParameter("bulletPoints");
            String targetLink = request.getParameter("targetLink");
            String accentColor = request.getParameter("accentColor");
            String fullImageMode = request.getParameter("fullImageMode");
            String resolvedImage = resolveProductImage(request);

            if (resolvedImage != null && !resolvedImage.isBlank()) {
                boolean isFull = "true".equalsIgnoreCase(fullImageMode);
                dao.addBannerSlide(title, subtitle, bulletPoints, resolvedImage, targetLink, accentColor, isFull);
                session.setAttribute("adminNotice",
                        "Đã thêm Slide Banner giới thiệu mới lên Trang chủ (Tự động chuyển 10s/lần).");
            } else {
                session.setAttribute("adminNotice",
                        "Vui lòng tải lên tệp ảnh Banner hoặc nhập URL ảnh cho Slide giới thiệu.");
            }
        } else if ("deleteBannerSlide".equalsIgnoreCase(action)) {
            targetTab = "banners";
            int bannerId = parseIntSafe(request.getParameter("bannerId"), -1);
            if (dao.deleteBannerSlide(bannerId)) {
                session.setAttribute("adminNotice", "Đã xóa Slide Banner giới thiệu #" + bannerId + ".");
            } else {
                session.setAttribute("adminNotice", "Hệ thống giữ tối thiểu 1 Slide Banner trên Trang chủ.");
            }
        } else if ("addBrandPartner".equalsIgnoreCase(action)) {
            targetTab = "brands";
            String brandName = request.getParameter("brandName");
            String brandSubtitle = request.getParameter("brandSubtitle");
            String resolvedLogo = resolveProductImage(request);
            if (brandName != null && !brandName.isBlank()) {
                dao.addBrandPartner(brandName, brandSubtitle, resolvedLogo);
                session.setAttribute("adminNotice",
                        "Đã thêm thương hiệu [" + brandName.trim() + "] vào dải băng chuyền Logo đối tác.");
            }
        } else if ("deleteBrandPartner".equalsIgnoreCase(action)) {
            targetTab = "brands";
            int brandId = parseIntSafe(request.getParameter("brandId"), -1);
            if (dao.deleteBrandPartner(brandId)) {
                session.setAttribute("adminNotice", "Đã xóa thương hiệu đối tác #" + brandId + " khỏi dải băng chuyền.");
            }
        } else if ("addCategory".equalsIgnoreCase(action)) {
            targetTab = "categories";
            String catId = request.getParameter("id");
            String name = request.getParameter("name");
            String groupType = request.getParameter("groupType");
            String technicalCode = request.getParameter("technicalCode");
            String targetUrl = request.getParameter("targetUrl");
            String iconType = request.getParameter("iconType");
            String description = request.getParameter("description");

            if (name != null && !name.isBlank()) {
                Category cat = dao.addCategory(catId, name, groupType, description, technicalCode, targetUrl, iconType);
                session.setAttribute("adminNotice",
                        "Đã thêm mới danh mục cơ khí: [" + cat.getName() + " - Mã: " + cat.getId() + "] thành công.");
            } else {
                session.setAttribute("adminNotice", "Vui lòng nhập Tên danh mục cơ khí.");
            }
        } else if ("updateCategory".equalsIgnoreCase(action)) {
            targetTab = "categories";
            String catId = request.getParameter("id");
            String name = request.getParameter("name");
            String groupType = request.getParameter("groupType");
            String technicalCode = request.getParameter("technicalCode");
            String targetUrl = request.getParameter("targetUrl");
            String iconType = request.getParameter("iconType");
            String description = request.getParameter("description");

            if (catId != null && !catId.isBlank()) {
                boolean ok = dao.updateCategory(catId, name, groupType, description, technicalCode, targetUrl, iconType);
                if (ok) {
                    session.setAttribute("adminNotice",
                            "Đã cập nhật danh mục cơ khí [" + name + " - Mã: " + catId + "] thành công.");
                } else {
                    session.setAttribute("adminNotice", "Không tìm thấy danh mục cơ khí có mã: " + catId);
                }
            }
        } else if ("deleteCategory".equalsIgnoreCase(action)) {
            targetTab = "categories";
            String catId = request.getParameter("id");
            if (catId != null && !catId.isBlank()) {
                boolean ok = dao.deleteCategory(catId);
                if (ok) {
                    session.setAttribute("adminNotice", "Đã xóa danh mục cơ khí [" + catId + "] thành công.");
                } else {
                    session.setAttribute("adminNotice", "Không tìm thấy danh mục cơ khí mã: " + catId);
                }
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin?tab=" + targetTab);
    }

    /**
     * Xử lý ảnh tải lên từ file máy tính (input type="file" name="imageFile")
     * hoặc đường dẫn URL ảnh (input type="text" name="imageUrl").
     */
    private String resolveProductImage(HttpServletRequest request) {
        try {
            String contentType = request.getContentType();
            if (contentType != null && contentType.toLowerCase().startsWith("multipart/")) {
                Part filePart = request.getPart("imageFile");
                if (filePart != null && filePart.getSize() > 0) {
                    String submittedName = filePart.getSubmittedFileName();
                    if (submittedName != null && !submittedName.isBlank()) {
                        String mimeType = filePart.getContentType();
                        if (mimeType == null || !mimeType.startsWith("image/")) {
                            mimeType = "image/jpeg";
                        }

                        byte[] fileBytes;
                        try (InputStream is = filePart.getInputStream()) {
                            fileBytes = is.readAllBytes();
                        }

                        // Lưu bản sao vật lý vào thư mục /uploads của ứng dụng nếu có quyền ghi
                        try {
                            String uploadsRealPath = getServletContext().getRealPath("/uploads");
                            if (uploadsRealPath != null) {
                                File uploadDir = new File(uploadsRealPath);
                                if (!uploadDir.exists()) {
                                    uploadDir.mkdirs();
                                }
                                String safeName = System.currentTimeMillis() + "_"
                                        + submittedName.replaceAll("[^a-zA-Z0-9._-]", "_");
                                Path targetPath = new File(uploadDir, safeName).toPath();
                                Files.write(targetPath, fileBytes);
                            }
                        } catch (Exception ignored) {
                        }

                        // Trả về chuỗi Data URI Base64 giúp hiển thị tức thời trên mọi trang không lo lỗi đường dẫn Tomcat
                        String base64 = Base64.getEncoder().encodeToString(fileBytes);
                        return "data:" + mimeType + ";base64," + base64;
                    }
                }
            }
        } catch (Exception ignored) {
        }

        String imageUrlParam = request.getParameter("imageUrl");
        if (imageUrlParam != null && !imageUrlParam.trim().isEmpty()) {
            return imageUrlParam.trim();
        }
        return null;
    }

    private int parseIntSafe(String val, int fallback) {
        if (val == null || val.isBlank()) {
            return fallback;
        }
        try {
            return Integer.parseInt(val.trim().replaceAll("[^0-9-]", ""));
        } catch (NumberFormatException e) {
            return fallback;
        }
    }

    private long parseLongSafe(String val, long fallback) {
        if (val == null || val.isBlank()) {
            return fallback;
        }
        try {
            return Long.parseLong(val.trim().replaceAll("[^0-9]", ""));
        } catch (NumberFormatException e) {
            return fallback;
        }
    }

    private double parseDoubleSafe(String val, double fallback) {
        if (val == null || val.isBlank()) {
            return fallback;
        }
        try {
            return Double.parseDouble(val.trim().replace(',', '.'));
        } catch (NumberFormatException e) {
            return fallback;
        }
    }
}
