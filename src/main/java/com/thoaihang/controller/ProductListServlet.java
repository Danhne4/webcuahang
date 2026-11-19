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
 * Controller xử lý trang Siêu thị Phụ tùng (/san-pham):
 * Hiển thị toàn bộ kho hàng, lọc theo phân hệ Máy thủy / Xe tải nặng, thương hiệu và sắp xếp.
 */
@WebServlet(name = "ProductListServlet", urlPatterns = {"/san-pham"})
public class ProductListServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        ProductDAO dao = ProductDAO.getInstance();

        String keyword = request.getParameter("q");
        String category = request.getParameter("category");
        String brand = request.getParameter("brand");
        String sort = request.getParameter("sort");

        if (keyword == null) {
            keyword = "";
        }
        if (category == null || category.isBlank()) {
            category = "ALL";
        }
        if (brand == null || brand.isBlank()) {
            brand = "ALL";
        }
        if (sort == null || sort.isBlank()) {
            sort = "default";
        }

        List<Product> products = dao.searchProducts(keyword, category, brand, sort);

        request.setAttribute("products", products);
        request.setAttribute("categories", dao.getCategories());
        request.setAttribute("selectedCategory", category.toUpperCase());
        request.setAttribute("selectedBrand", brand);
        request.setAttribute("selectedSort", sort);
        request.setAttribute("searchKeyword", keyword);
        request.setAttribute("totalInventoryUnits", dao.getTotalInventoryUnits());

        if ("MAY-THUY".equalsIgnoreCase(category)) {
            request.setAttribute("activeMenu", "marine");
        } else if ("XE-TAI-NANG".equalsIgnoreCase(category)) {
            request.setAttribute("activeMenu", "truck");
        } else {
            request.setAttribute("activeMenu", "products");
        }

        request.getRequestDispatcher("/WEB-INF/views/products.jsp").forward(request, response);
    }
}
