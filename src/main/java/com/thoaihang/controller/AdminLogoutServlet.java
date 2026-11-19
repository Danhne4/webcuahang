package com.thoaihang.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Controller xử lý Đăng xuất khỏi Cổng Quản trị Nội bộ (/admin-logout).
 */
@WebServlet(name = "AdminLogoutServlet", urlPatterns = {"/admin-logout"})
public class AdminLogoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processLogout(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processLogout(request, response);
    }

    private void processLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute(AdminLoginServlet.ADMIN_SESSION_KEY);
            session.removeAttribute("adminRoleName");
            session.removeAttribute("adminNotice");
        }
        response.sendRedirect(request.getContextPath() + "/home");
    }
}
