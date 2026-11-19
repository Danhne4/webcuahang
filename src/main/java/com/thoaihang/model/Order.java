package com.thoaihang.model;

import java.io.Serializable;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

/**
 * Model đại diện cho Đơn đặt hàng gửi Chành xe / Cảng biển của khách hàng.
 */
public class Order implements Serializable {

    private static final long serialVersionUID = 1L;

    private String orderCode;           // Mã đơn: ORD-2026-XXXX
    private String customerName;        // Họ tên Thuyền trưởng / Chủ xe
    private String phone;               // Số điện thoại liên hệ
    private String vesselOrPlateNumber; // Tên tàu / Số hiệu xà lan / Biển số xe
    private String shippingCarrier;     // Nhà xe nhận hàng (Tô Châu, Phương Trang, Viettel Post...)
    private String dispatchWarehouse;   // Kho xuất (Kho Hải Phòng / Kho TP.HCM)
    private String deliveryAddress;     // Địa chỉ bến nhận / Cảng nhận
    private String technicalNotes;      // Yêu cầu kỹ thuật (Đo kiểm Panme, VAT & CO/CQ...)
    private List<CartItem> items = new ArrayList<>();
    private long totalAmount;
    private String status;              // "Chờ xác nhận", "Đang đóng thùng", "Đã giao chành xe", "Đã hủy"
    private String createdAt;

    public Order() {
    }

    public Order(String orderCode, String customerName, String phone, String vesselOrPlateNumber,
                 String shippingCarrier, String dispatchWarehouse, String deliveryAddress,
                 String technicalNotes, List<CartItem> items, long totalAmount,
                 String status, String createdAt) {
        this.orderCode = orderCode;
        this.customerName = customerName;
        this.phone = phone;
        this.vesselOrPlateNumber = vesselOrPlateNumber;
        this.shippingCarrier = shippingCarrier;
        this.dispatchWarehouse = dispatchWarehouse;
        this.deliveryAddress = deliveryAddress;
        this.technicalNotes = technicalNotes;
        if (items != null) {
            this.items = new ArrayList<>(items);
        }
        this.totalAmount = totalAmount;
        this.status = status;
        this.createdAt = createdAt;
    }

    public String getFormattedTotalAmount() {
        DecimalFormatSymbols symbols = new DecimalFormatSymbols(Locale.forLanguageTag("vi-VN"));
        symbols.setGroupingSeparator('.');
        DecimalFormat df = new DecimalFormat("#,###", symbols);
        return df.format(this.totalAmount) + " đ";
    }

    public int getTotalItemsCount() {
        int count = 0;
        if (items != null) {
            for (CartItem item : items) {
                count += item.getQuantity();
            }
        }
        return count;
    }

    public String getItemsSummary() {
        if (items == null || items.isEmpty()) {
            return "Chưa có chi tiết phụ tùng";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < items.size(); i++) {
            CartItem item = items.get(i);
            if (i > 0) {
                sb.append(" | ");
            }
            sb.append(item.getProduct().getName())
              .append(" [OEM: ")
              .append(item.getProduct().getOemCode())
              .append("] x")
              .append(item.getQuantity());
        }
        return sb.toString();
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getVesselOrPlateNumber() {
        return vesselOrPlateNumber;
    }

    public void setVesselOrPlateNumber(String vesselOrPlateNumber) {
        this.vesselOrPlateNumber = vesselOrPlateNumber;
    }

    public String getShippingCarrier() {
        return shippingCarrier;
    }

    public void setShippingCarrier(String shippingCarrier) {
        this.shippingCarrier = shippingCarrier;
    }

    public String getDispatchWarehouse() {
        return dispatchWarehouse;
    }

    public void setDispatchWarehouse(String dispatchWarehouse) {
        this.dispatchWarehouse = dispatchWarehouse;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    public String getTechnicalNotes() {
        return technicalNotes;
    }

    public void setTechnicalNotes(String technicalNotes) {
        this.technicalNotes = technicalNotes;
    }

    public List<CartItem> getItems() {
        return items;
    }

    public void setItems(List<CartItem> items) {
        this.items = items;
    }

    public long getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(long totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
}
