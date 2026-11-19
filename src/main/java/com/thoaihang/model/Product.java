package com.thoaihang.model;

import java.io.Serializable;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Locale;

/**
 * Model đại diện cho Phụ tùng cơ khí công nghiệp nặng (Máy thủy & Xe tải nặng).
 * Lưu trữ đầy đủ mã OEM, thông số vật liệu, dung sai Panme cấp H7 và cấu hình bản vẽ CAD.
 */
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;

    private int id;
    private String name;
    private String oemCode;
    private String brand;
    private String category;       // "MAY-THUY" hoặc "XE-TAI-NANG"
    private String categoryLabel;  // "Máy Thủy & Tàu Xà Lan" hoặc "Xe Tải Nặng & Đầu Kéo"
    private String subSystem;      // Hệ thống cụm chi tiết
    private String engineModel;    // Dòng động cơ / Hộp số tương thích
    private long price;
    private int stock;
    private String origin;
    private String materialSpec;
    private String toleranceSpec;
    private String dimensions;
    private double weightKg;
    private String warehouseLocation;
    private String description;
    private String cadProfileType; // Loại mặt cắt CAD: PUMP, COOLER, CLUTCH, PISTON, BRAKE, INJECTOR, BEARING, GEAR, TURBO
    private String imageUrl;       // Đường dẫn ảnh hoặc Data URI ảnh thực tế của phụ tùng

    public Product() {
    }

    public Product(int id, String name, String oemCode, String brand, String category,
                   String categoryLabel, String subSystem, String engineModel, long price,
                   int stock, String origin, String materialSpec, String toleranceSpec,
                   String dimensions, double weightKg, String warehouseLocation,
                   String description, String cadProfileType) {
        this(id, name, oemCode, brand, category, categoryLabel, subSystem, engineModel,
             price, stock, origin, materialSpec, toleranceSpec, dimensions, weightKg,
             warehouseLocation, description, cadProfileType, null);
    }

    public Product(int id, String name, String oemCode, String brand, String category,
                   String categoryLabel, String subSystem, String engineModel, long price,
                   int stock, String origin, String materialSpec, String toleranceSpec,
                   String dimensions, double weightKg, String warehouseLocation,
                   String description, String cadProfileType, String imageUrl) {
        this.id = id;
        this.name = name;
        this.oemCode = oemCode;
        this.brand = brand;
        this.category = category;
        this.categoryLabel = categoryLabel;
        this.subSystem = subSystem;
        this.engineModel = engineModel;
        this.price = price;
        this.stock = stock;
        this.origin = origin;
        this.materialSpec = materialSpec;
        this.toleranceSpec = toleranceSpec;
        this.dimensions = dimensions;
        this.weightKg = weightKg;
        this.warehouseLocation = warehouseLocation;
        this.description = description;
        this.cadProfileType = cadProfileType;
        this.imageUrl = imageUrl;
    }

    public String getFormattedPrice() {
        DecimalFormatSymbols symbols = new DecimalFormatSymbols(Locale.forLanguageTag("vi-VN"));
        symbols.setGroupingSeparator('.');
        DecimalFormat df = new DecimalFormat("#,###", symbols);
        return df.format(this.price) + " đ";
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getOemCode() {
        return oemCode;
    }

    public void setOemCode(String oemCode) {
        this.oemCode = oemCode;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getCategoryLabel() {
        return categoryLabel;
    }

    public void setCategoryLabel(String categoryLabel) {
        this.categoryLabel = categoryLabel;
    }

    public String getSubSystem() {
        return subSystem;
    }

    public void setSubSystem(String subSystem) {
        this.subSystem = subSystem;
    }

    public String getEngineModel() {
        return engineModel;
    }

    public void setEngineModel(String engineModel) {
        this.engineModel = engineModel;
    }

    public long getPrice() {
        return price;
    }

    public void setPrice(long price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getMaterialSpec() {
        return materialSpec;
    }

    public void setMaterialSpec(String materialSpec) {
        this.materialSpec = materialSpec;
    }

    public String getToleranceSpec() {
        return toleranceSpec;
    }

    public void setToleranceSpec(String toleranceSpec) {
        this.toleranceSpec = toleranceSpec;
    }

    public String getDimensions() {
        return dimensions;
    }

    public void setDimensions(String dimensions) {
        this.dimensions = dimensions;
    }

    public double getWeightKg() {
        return weightKg;
    }

    public void setWeightKg(double weightKg) {
        this.weightKg = weightKg;
    }

    public String getWarehouseLocation() {
        return warehouseLocation;
    }

    public void setWarehouseLocation(String warehouseLocation) {
        this.warehouseLocation = warehouseLocation;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCadProfileType() {
        return cadProfileType;
    }

    public void setCadProfileType(String cadProfileType) {
        this.cadProfileType = cadProfileType;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public boolean isHasImage() {
        return imageUrl != null && !imageUrl.trim().isEmpty();
    }
}
