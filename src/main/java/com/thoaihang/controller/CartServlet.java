package com.thoaihang.controller;

import com.thoaihang.dao.ProductDAO;
import com.thoaihang.model.CartItem;
import com.thoaihang.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Controller quản lý Giỏ hàng (/gio-hang) thông qua HttpSession.
 * Hỗ trợ thêm, cập nhật số lượng, xóa mã phụ tùng và tính tổng tiền đơn hàng gửi chành xe.
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/gio-hang"})
public class CartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @SuppressWarnings("unchecked")
    public static List<CartItem> getOrCreateCart(HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    public static void syncCartMetrics(HttpSession session, List<CartItem> cart) {
        int totalQty = 0;
        long totalAmount = 0L;
        for (CartItem item : cart) {
            totalQty += item.getQuantity();
            totalAmount += item.getSubTotal();
        }
        session.setAttribute("cartCount", totalQty);
        session.setAttribute("cartTotal", totalAmount);
        session.setAttribute("cartTotalFormatted", ProductDAO.formatVnd(totalAmount));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action != null && !action.isBlank()) {
            processCartAction(request, response, action);
            return;
        }

        HttpSession session = request.getSession();
        List<CartItem> cart = getOrCreateCart(session);
        syncCartMetrics(session, cart);

        request.setAttribute("activeMenu", "cart");
        request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null || action.isBlank()) {
            action = "add";
        }
        processCartAction(request, response, action);
    }

    private void processCartAction(HttpServletRequest request, HttpServletResponse response, String action)
            throws IOException {
        HttpSession session = request.getSession();
        List<CartItem> cart = getOrCreateCart(session);
        ProductDAO dao = ProductDAO.getInstance();

        int productId = parseIntSafe(request.getParameter("productId"), -1);
        int quantity = parseIntSafe(request.getParameter("quantity"), 1);

        if ("add".equalsIgnoreCase(action)) {
            Product product = dao.getProductById(productId);
            if (product != null) {
                if (quantity < 1) {
                    quantity = 1;
                }
                boolean found = false;
                for (CartItem item : cart) {
                    if (item.getProduct().getId() == productId) {
                        int newQty = Math.min(item.getQuantity() + quantity, Math.max(product.getStock(), 1));
                        item.setQuantity(newQty);
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    cart.add(new CartItem(product, Math.min(quantity, Math.max(product.getStock(), 1))));
                }
                session.setAttribute("cartFlashMessage",
                        "Đã thêm [" + product.getName() + " - OEM: " + product.getOemCode() + "] vào phiếu xuất giỏ hàng.");
            }
        } else if ("update".equalsIgnoreCase(action)) {
            Iterator<CartItem> it = cart.iterator();
            while (it.hasNext()) {
                CartItem item = it.next();
                if (item.getProduct().getId() == productId) {
                    if (quantity <= 0) {
                        it.remove();
                    } else {
                        int maxStock = Math.max(item.getProduct().getStock(), 1);
                        item.setQuantity(Math.min(quantity, maxStock));
                    }
                    break;
                }
            }
        } else if ("remove".equalsIgnoreCase(action)) {
            cart.removeIf(item -> item.getProduct().getId() == productId);
        } else if ("clear".equalsIgnoreCase(action)) {
            cart.clear();
        }

        syncCartMetrics(session, cart);
        response.sendRedirect(request.getContextPath() + "/gio-hang");
    }

    private int parseIntSafe(String val, int defaultVal) {
        if (val == null || val.isBlank()) {
            return defaultVal;
        }
        try {
            return Integer.parseInt(val.trim());
        } catch (NumberFormatException e) {
            return defaultVal;
        }
    }
}
