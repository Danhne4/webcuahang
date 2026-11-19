package com.thoaihang.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Model đại diện cho một Slide Banner giới thiệu trên Trang chủ
 * (Tự động chuyển sau mỗi 10 giây hoặc bấm nút Next / Prev, quản lý trực tiếp trong Admin).
 */
public class BannerSlide implements Serializable {

    private static final long serialVersionUID = 1L;

    private int id;
    private String title;
    private String subtitle;
    private String bulletPoints; // Ngăn cách bằng dấu '|'
    private String imageUrl;     // Ảnh banner tải lên từ Admin hoặc SVG Data URI mặc định
    private String targetLink;
    private String accentColor;  // Màu điểm nhấn (VD: #D32F2F, #1D2C7B, #C2410C)
    private boolean customUploadedImage;

    public BannerSlide() {
    }

    public BannerSlide(int id, String title, String subtitle, String bulletPoints,
                       String imageUrl, String targetLink, String accentColor,
                       boolean customUploadedImage) {
        this.id = id;
        this.title = title;
        this.subtitle = subtitle;
        this.bulletPoints = bulletPoints;
        this.imageUrl = imageUrl;
        this.targetLink = targetLink;
        this.accentColor = accentColor;
        this.customUploadedImage = customUploadedImage;
    }

    public List<String> getBulletList() {
        List<String> list = new ArrayList<>();
        if (bulletPoints != null && !bulletPoints.isBlank()) {
            String[] parts = bulletPoints.split("\\|");
            for (String part : parts) {
                if (!part.trim().isEmpty()) {
                    list.add(part.trim());
                }
            }
        }
        return list;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSubtitle() {
        return subtitle;
    }

    public void setSubtitle(String subtitle) {
        this.subtitle = subtitle;
    }

    public String getBulletPoints() {
        return bulletPoints;
    }

    public void setBulletPoints(String bulletPoints) {
        this.bulletPoints = bulletPoints;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getTargetLink() {
        return targetLink;
    }

    public void setTargetLink(String targetLink) {
        this.targetLink = targetLink;
    }

    public String getAccentColor() {
        return accentColor;
    }

    public void setAccentColor(String accentColor) {
        this.accentColor = accentColor;
    }

    public boolean isCustomUploadedImage() {
        return customUploadedImage;
    }

    public void setCustomUploadedImage(boolean customUploadedImage) {
        this.customUploadedImage = customUploadedImage;
    }
}
