package com.thoaihang.controller;

import com.thoaihang.dao.ProductDAO;
import com.thoaihang.model.CartItem;
import com.thoaihang.model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Controller xử lý Đặt hàng gửi Chành xe (/dat-hang, /thanh-toan).
 * Sinh mã đơn ORD-2026-XXXX và hiển thị hướng dẫn nhận hàng chành xe 24/7.
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/dat-hang", "/thanh-toan"})
public class CheckoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        ProductDAO dao = ProductDAO.getInstance();

        String codeParam = request.getParameter("code");
        Order order = null;
        if (codeParam != null && !codeParam.isBlank()) {
            order = dao.getOrderByCode(codeParam);
        }
        if (order == null) {
            order = (Order) session.getAttribute("lastOrder");
        }
        if (order == null) {
            List<Order> allOrders = dao.getAllOrders();
            if (!allOrders.isEmpty()) {
                order = allOrders.get(0);
            }
        }

        request.setAttribute("order", order);
        request.setAttribute("activeMenu", "chanhxe");
        request.getRequestDispatcher("/WEB-INF/views/order-success.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        List<CartItem> cart = CartServlet.getOrCreateCart(session);

        if (cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/gio-hang");
            return;
        }

        String customerName = getCleanParam(request, "customerName", "Thuyền trưởng / Chủ xe");
        String phone = getCleanParam(request, "phone", "0912.345.678");
        String vesselOrPlate = getCleanParam(request, "vesselOrPlateNumber", "Tàu thủy / Xe tải nặng");
        String shippingCarrier = getCleanParam(request, "shippingCarrier", "Chành xe Tô Châu");
        String dispatchWarehouse = getCleanParam(request, "dispatchWarehouse", "Kho Hải Phòng (Cảng Chùa Vẽ)");
        String deliveryAddress = getCleanParam(request, "deliveryAddress", "Nhận tại trạm chành xe trung tâm");
        String technicalNotes = getCleanParam(request, "technicalNotes",
                "Đo kiểm dung sai Panme cấp H7, đóng kiện chống va đập, kèm phiếu xuất kho & CO/CQ.");

        ProductDAO dao = ProductDAO.getInstance();
        Order createdOrder = dao.createOrder(
                customerName,
                phone,
                vesselOrPlate,
                shippingCarrier,
                dispatchWarehouse,
                deliveryAddress,
                technicalNotes,
                cart
        );

        // Xóa giỏ hàng sau khi tạo phiếu xuất chành xe thành công
        cart.clear();
        CartServlet.syncCartMetrics(session, cart);
        session.setAttribute("lastOrder", createdOrder);

        request.setAttribute("order", createdOrder);
        request.setAttribute("activeMenu", "chanhxe");
        request.getRequestDispatcher("/WEB-INF/views/order-success.jsp").forward(request, response);
    }

    private String getCleanParam(HttpServletRequest request, String name, String fallback) {
        String val = request.getParameter(name);
        if (val == null || val.trim().isEmpty()) {
            return fallback;
        }
        return val.trim();
    }
}
