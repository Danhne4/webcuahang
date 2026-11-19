package com.thoaihang.controller;

import com.thoaihang.dao.ProductDAO;
import com.thoaihang.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Controller xử lý Trang chi tiết phụ tùng (/san-pham/chi-tiet):
 * Hiển thị thông số kỹ thuật, bản vẽ CAD Blueprint HTML5 Canvas (L = 180mm ±0.02, cấp H7)
 * và cho phép chọn số lượng thêm vào giỏ hàng.
 */
@WebServlet(name = "ProductDetailServlet", urlPatterns = {"/san-pham/chi-tiet"})
public class ProductDetailServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        ProductDAO dao = ProductDAO.getInstance();
        Product product = null;

        String idParam = request.getParameter("id");
        String oemParam = request.getParameter("oem");

        if (idParam != null && !idParam.isBlank()) {
            try {
                int id = Integer.parseInt(idParam.trim());
                product = dao.getProductById(id);
            } catch (NumberFormatException ignored) {
            }
        } else if (oemParam != null && !oemParam.isBlank()) {
            product = dao.getProductByOem(oemParam.trim());
        }

        if (product == null) {
            // Mặc định hiển thị phụ tùng số 1 nếu mã không hợp lệ
            product = dao.getProductById(1);
        }

        List<Product> relatedProducts = dao.getRelatedProducts(product.getId(), product.getCategory(), 4);

        request.setAttribute("product", product);
        request.setAttribute("relatedProducts", relatedProducts);
        request.setAttribute("activeMenu", "products");

        request.getRequestDispatcher("/WEB-INF/views/product-detail.jsp").forward(request, response);
    }
}
