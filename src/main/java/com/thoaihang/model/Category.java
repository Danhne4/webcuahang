package com.thoaihang.model;

import java.io.Serializable;

/**
 * Model đại diện cho Danh mục hệ thống phụ tùng cơ khí (Máy thủy / Xe tải nặng / Hệ thống cụm chi tiết).
 * Hỗ trợ liên kết động tới bộ lọc tìm kiếm và biểu tượng SVG tương ứng.
 */
public class Category implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id;
    private String name;
    private String groupType; // "MARINE" (Máy thủy) hoặc "TRUCK" (Xe tải nặng)
    private String description;
    private String technicalCode;
    private String targetUrl; // Link lọc sản phẩm khi bấm (VD: /san-pham?q=Bộ+hơi)
    private String iconType;  // Loại icon SVG: engine, pump, gearbox, injector, turbo, bearing, clutch, crown, brake, propeller

    public Category() {
    }

    public Category(String id, String name, String groupType, String description, String technicalCode) {
        this(id, name, groupType, description, technicalCode, "/san-pham", "engine");
    }

    public Category(String id, String name, String groupType, String description, String technicalCode,
                    String targetUrl, String iconType) {
        this.id = id;
        this.name = name;
        this.groupType = groupType;
        this.description = description;
        this.technicalCode = technicalCode;
        this.targetUrl = targetUrl;
        this.iconType = iconType;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGroupType() {
        return groupType;
    }

    public void setGroupType(String groupType) {
        this.groupType = groupType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTechnicalCode() {
        return technicalCode;
    }

    public void setTechnicalCode(String technicalCode) {
        this.technicalCode = technicalCode;
    }

    public String getTargetUrl() {
        return targetUrl;
    }

    public void setTargetUrl(String targetUrl) {
        this.targetUrl = targetUrl;
    }

    public String getIconType() {
        return iconType;
    }

    public void setIconType(String iconType) {
        this.iconType = iconType;
    }
}
