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
 * Controller xử lý Trang chủ (/home) của Cửa hàng Phụ tùng Cơ khí Thoại Hằng.
 * Hỗ trợ lọc nhanh theo Tab (Tất cả, Máy thủy, Xe tải nặng) và tìm kiếm từ khóa.
 */
@WebServlet(name = "HomeController", urlPatterns = {"/home"})
public class HomeController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        ProductDAO dao = ProductDAO.getInstance();

        String tab = request.getParameter("tab");
        if (tab == null || tab.isBlank()) {
            tab = "ALL";
        }
        String keyword = request.getParameter("q");
        if (keyword == null) {
            keyword = "";
        }

        List<Product> filteredProducts = dao.searchProducts(keyword, tab, "ALL", "");
        List<Product> allProducts = dao.getAllProducts();
        List<Product> marineProducts = dao.getProductsByCategory("MAY-THUY");
        List<Product> truckProducts = dao.getProductsByCategory("XE-TAI-NANG");

        request.setAttribute("products", filteredProducts);
        request.setAttribute("allCount", allProducts.size());
        request.setAttribute("marineCount", marineProducts.size());
        request.setAttribute("truckCount", truckProducts.size());
        request.setAttribute("categories", dao.getCategories());
        request.setAttribute("bannerSlides", dao.getBannerSlides());
        request.setAttribute("brandPartners", dao.getBrandPartners());
        request.setAttribute("selectedTab", tab.toUpperCase());
        request.setAttribute("searchKeyword", keyword);
        request.setAttribute("activeMenu", "home");

        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
}
