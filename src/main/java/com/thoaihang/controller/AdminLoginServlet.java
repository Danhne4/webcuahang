package com.thoaihang.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Controller xử lý trang Đăng nhập Cổng Quản trị Nội bộ (/admin-login).
 * Chỉ mở khóa khi nhập đúng mật khẩu quản lý kho: "thoaihang2026".
 */
@WebServlet(name = "AdminLoginServlet", urlPatterns = {"/admin-login"})
public class AdminLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public static final String ADMIN_SESSION_KEY = "THOAIHANG_ADMIN_AUTH";
    private static final String DEFAULT_ADMIN_PASS = "thoaihang2026";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session != null && Boolean.TRUE.equals(session.getAttribute(ADMIN_SESSION_KEY))) {
            response.sendRedirect(request.getContextPath() + "/admin");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/views/admin-login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String password = request.getParameter("password");

        if (DEFAULT_ADMIN_PASS.equals(password)) {
            HttpSession session = request.getSession(true);
            session.setAttribute(ADMIN_SESSION_KEY, Boolean.TRUE);
            session.setAttribute("adminRoleName", "Thủ Kho Trưởng - Thoại Hằng Heavy Parts");
            response.sendRedirect(request.getContextPath() + "/admin");
        } else {
            request.setAttribute("errorMessage",
                    "CẢNH BÁO BẢO MẬT: Mật khẩu nội bộ không chính xác! Truy cập bị từ chối.");
            request.getRequestDispatcher("/WEB-INF/views/admin-login.jsp").forward(request, response);
        }
    }
}
