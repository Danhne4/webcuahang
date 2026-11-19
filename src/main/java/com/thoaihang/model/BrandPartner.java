package com.thoaihang.model;

import java.io.Serializable;

/**
 * Model đại diện cho Thương hiệu đối tác hiển thị trên dải băng chuyền Logo chuyển động
 * (Hỗ trợ thêm mới / tải ảnh logo thương hiệu trong trang Admin).
 */
public class BrandPartner implements Serializable {

    private static final long serialVersionUID = 1L;

    private int id;
    private String name;
    private String subtitle;
    private String logoUrl; // Đường dẫn ảnh / Base64 Data URI / SVG Data URI

    public BrandPartner() {
    }

    public BrandPartner(int id, String name, String subtitle, String logoUrl) {
        this.id = id;
        this.name = name;
        this.subtitle = subtitle;
        this.logoUrl = logoUrl;
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

    public String getSubtitle() {
        return subtitle;
    }

    public void setSubtitle(String subtitle) {
        this.subtitle = subtitle;
    }

    public String getLogoUrl() {
        return logoUrl;
    }

    public void setLogoUrl(String logoUrl) {
        this.logoUrl = logoUrl;
    }
}
