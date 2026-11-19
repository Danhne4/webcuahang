package com.thoaihang.model;

import java.io.Serializable;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Locale;

/**
 * Model đại diện cho một mục phụ tùng trong giỏ hàng (lưu trong HttpSession).
 */
public class CartItem implements Serializable {

    private static final long serialVersionUID = 1L;

    private Product product;
    private int quantity;

    public CartItem() {
    }

    public CartItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    public long getSubTotal() {
        if (product == null) {
            return 0L;
        }
        return product.getPrice() * quantity;
    }

    public String getFormattedSubTotal() {
        DecimalFormatSymbols symbols = new DecimalFormatSymbols(Locale.forLanguageTag("vi-VN"));
        symbols.setGroupingSeparator('.');
        DecimalFormat df = new DecimalFormat("#,###", symbols);
        return df.format(getSubTotal()) + " đ";
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
