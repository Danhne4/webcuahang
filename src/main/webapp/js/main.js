/**
 * THOẠI HẰNG HEAVY PARTS - HỆ THỐNG KỸ THUẬT CƠ KHÍ & BẢN VẼ CAD BLUEPRINT
 * Pure Vanilla JavaScript (ES6) - Không phụ thuộc thư viện ngoài
 */

document.addEventListener("DOMContentLoaded", function () {
    initStickyCompactHeader();
    initHeroBannerSlider();
    initRealtimeProductFilter();
    initQuantitySelectors();
    initCadBlueprintCanvas();
});

/**
 * Thu gọn Header khi cuộn trang xuống:
 * Ẩn Tầng 1 và Tầng 3 theo luồng cuộn tự nhiên, chỉ ghim cố định Tầng 2
 * (Logo Thoại Hằng thu gọn + Thanh tìm kiếm + Giỏ hàng & Hotline liên hệ)
 */
function initStickyCompactHeader() {
    const stickyHeader = document.getElementById("stickyMainHeader");
    if (!stickyHeader) {
        return;
    }

    function onScroll() {
        if (window.scrollY > 45) {
            stickyHeader.classList.add("is-compact");
        } else {
            stickyHeader.classList.remove("is-compact");
        }
    }

    window.addEventListener("scroll", onScroll, { passive: true });
    onScroll();
}

/**
 * 0. Slider Banner giới thiệu trên Trang chủ:
 *    - Tự động chuyển đổi sau mỗi 10 giây (10.000ms)
 *    - Có nút bấm Next / Prev và các chấm chọn Slide trực tiếp
 */
function initHeroBannerSlider() {
    const slides = document.querySelectorAll(".hero-slide-item");
    const dots = document.querySelectorAll(".hero-dot-btn");
    const prevBtn = document.getElementById("heroPrevBtn");
    const nextBtn = document.getElementById("heroNextBtn");
    const countdownEl = document.getElementById("heroTimerCountdown");
    const sliderWrapper = document.getElementById("heroSliderWrapper");

    if (slides.length <= 1) {
        return;
    }

    let currentIndex = 0;
    let remainingSeconds = 10;
    let isPaused = false;

    function showSlide(index) {
        if (index < 0) {
            index = slides.length - 1;
        } else if (index >= slides.length) {
            index = 0;
        }
        currentIndex = index;

        slides.forEach(function (slide, idx) {
            if (idx === currentIndex) {
                slide.classList.add("active");
            } else {
                slide.classList.remove("active");
            }
        });

        dots.forEach(function (dot, idx) {
            if (idx === currentIndex) {
                dot.classList.add("active");
            } else {
                dot.classList.remove("active");
            }
        });

        remainingSeconds = 10;
        if (countdownEl) {
            countdownEl.textContent = remainingSeconds + "s";
        }
    }

    if (nextBtn) {
        nextBtn.addEventListener("click", function () {
            showSlide(currentIndex + 1);
        });
    }

    if (prevBtn) {
        prevBtn.addEventListener("click", function () {
            showSlide(currentIndex - 1);
        });
    }

    dots.forEach(function (dot) {
        dot.addEventListener("click", function () {
            const idx = parseInt(dot.getAttribute("data-slide-index") || "0", 10);
            showSlide(idx);
        });
    });

    if (sliderWrapper) {
        sliderWrapper.addEventListener("mouseenter", function () {
            isPaused = true;
        });
        sliderWrapper.addEventListener("mouseleave", function () {
            isPaused = false;
        });
    }

    // Chu kỳ đếm ngược mỗi 1 giây -> đủ 10 giây tự động sang Slide kế tiếp
    setInterval(function () {
        if (isPaused) {
            return;
        }
        remainingSeconds--;
        if (remainingSeconds <= 0) {
            showSlide(currentIndex + 1);
        } else if (countdownEl) {
            countdownEl.textContent = remainingSeconds + "s";
        }
    }, 1000);
}

/**
 * 1. Lọc nhanh sản phẩm theo Tab (Tất cả / Máy thủy / Xe tải nặng) & Tìm kiếm thời gian thực
 */
function initRealtimeProductFilter() {
    const filterInput = document.getElementById("realtimeFilterInput");
    const tabButtons = document.querySelectorAll("[data-filter-tab]");
    const productCards = document.querySelectorAll(".product-card[data-category]");
    const emptyState = document.getElementById("realtimeEmptyState");
    const visibleCountEl = document.getElementById("visibleProductsCount");

    if (productCards.length === 0) {
        return;
    }

    let currentTab = "ALL";
    tabButtons.forEach(function (btn) {
        if (btn.classList.contains("active")) {
            currentTab = btn.getAttribute("data-filter-tab") || "ALL";
        }
    });

    function applyFilter() {
        const keyword = filterInput ? filterInput.value.trim().toLowerCase() : "";
        let visibleCount = 0;

        productCards.forEach(function (card) {
            const cardCat = (card.getAttribute("data-category") || "").toUpperCase();
            const cardSearchText = (card.getAttribute("data-search") || "").toLowerCase();

            const matchTab = (currentTab === "ALL") || (cardCat === currentTab);
            const matchKeyword = (keyword === "") || cardSearchText.indexOf(keyword) !== -1;

            if (matchTab && matchKeyword) {
                card.style.display = "flex";
                visibleCount++;
            } else {
                card.style.display = "none";
            }
        });

        if (visibleCountEl) {
            visibleCountEl.textContent = visibleCount;
        }
        if (emptyState) {
            emptyState.style.display = (visibleCount === 0) ? "block" : "none";
        }
    }

    tabButtons.forEach(function (btn) {
        btn.addEventListener("click", function (e) {
            if (btn.hasAttribute("data-client-filter")) {
                e.preventDefault();
                tabButtons.forEach(function (b) {
                    b.classList.remove("active");
                });
                btn.classList.add("active");
                currentTab = (btn.getAttribute("data-filter-tab") || "ALL").toUpperCase();
                applyFilter();
            }
        });
    });

    if (filterInput) {
        filterInput.addEventListener("input", applyFilter);
    }
}

/**
 * 2. Điều khiển nút tăng / giảm số lượng phụ tùng (+/-)
 */
function initQuantitySelectors() {
    const qtyControls = document.querySelectorAll(".qty-control");
    qtyControls.forEach(function (ctrl) {
        const minusBtn = ctrl.querySelector("[data-qty-minus]");
        const plusBtn = ctrl.querySelector("[data-qty-plus]");
        const input = ctrl.querySelector(".qty-input");

        if (!input) {
            return;
        }

        const maxStock = parseInt(input.getAttribute("max") || "99", 10);

        if (minusBtn) {
            minusBtn.addEventListener("click", function () {
                let current = parseInt(input.value || "1", 10);
                if (isNaN(current) || current <= 1) {
                    current = 1;
                } else {
                    current--;
                }
                input.value = current;
            });
        }

        if (plusBtn) {
            plusBtn.addEventListener("click", function () {
                let current = parseInt(input.value || "1", 10);
                if (isNaN(current) || current < 1) {
                    current = 1;
                } else if (current < maxStock) {
                    current++;
                }
                input.value = current;
            });
        }
    });
}

/**
 * 3. Vẽ sơ đồ bản vẽ kỹ thuật CAD Blueprint trên HTML5 Canvas
 *    - Vạch dung sai: L = 180mm ±0.02
 *    - Cấp chính xác: H7 (ISO 286-2)
 *    - Đường tâm trục nét đứt (Center Axis Line)
 */
function initCadBlueprintCanvas() {
    const canvas = document.getElementById("cadBlueprintCanvas");
    if (!canvas) {
        return;
    }

    const ctx = canvas.getContext("2d");
    const oemCode = canvas.getAttribute("data-oem") || "119574-42502";
    const partName = canvas.getAttribute("data-name") || "CỤM CHI TIẾT CƠ KHÍ ĐẠI TU";
    const profileType = (canvas.getAttribute("data-profile") || "PUMP").toUpperCase();
    const brandName = canvas.getAttribute("data-brand") || "OEM GENUINE";

    let currentViewMode = "SECTION_AA"; // SECTION_AA hoặc FLANGE_BB

    function drawBlueprint() {
        const w = canvas.width;
        const h = canvas.height;

        // 3.1 Nền xanh Blueprint kỹ thuật (#0B192C)
        ctx.fillStyle = "#0B192C";
        ctx.fillRect(0, 0, w, h);

        // 3.2 Lưới tọa độ kỹ thuật (Minor 20px & Major 80px)
        ctx.lineWidth = 0.5;
        ctx.strokeStyle = "rgba(100, 181, 246, 0.10)";
        for (let x = 20; x < w; x += 20) {
            ctx.beginPath();
            ctx.moveTo(x, 0);
            ctx.lineTo(x, h);
            ctx.stroke();
        }
        for (let y = 20; y < h; y += 20) {
            ctx.beginPath();
            ctx.moveTo(0, y);
            ctx.lineTo(w, y);
            ctx.stroke();
        }

        ctx.lineWidth = 0.8;
        ctx.strokeStyle = "rgba(100, 181, 246, 0.22)";
        for (let x = 80; x < w; x += 80) {
            ctx.beginPath();
            ctx.moveTo(x, 0);
            ctx.lineTo(x, h);
            ctx.stroke();
        }
        for (let y = 80; y < h; y += 80) {
            ctx.beginPath();
            ctx.moveTo(0, y);
            ctx.lineTo(w, y);
            ctx.stroke();
        }

        // 3.3 Khung bản vẽ tiêu chuẩn ISO
        ctx.strokeStyle = "#64B5F6";
        ctx.lineWidth = 2;
        ctx.strokeRect(12, 12, w - 24, h - 24);
        ctx.lineWidth = 1;
        ctx.strokeRect(18, 18, w - 36, h - 36);

        // Tọa độ tâm bản vẽ
        const cx = 310;
        const cy = 205;

        // 3.4 Đường tâm trục nét đứt (Center Axis Line - Nét gạch chấm tiêu chuẩn cơ khí)
        ctx.save();
        ctx.strokeStyle = "#F8C600";
        ctx.lineWidth = 1.4;
        ctx.setLineDash([18, 6, 4, 6]);
        // Trục ngang chính
        ctx.beginPath();
        ctx.moveTo(45, cy);
        ctx.lineTo(575, cy);
        ctx.stroke();
        // Trục đứng tâm
        ctx.beginPath();
        ctx.moveTo(cx, 55);
        ctx.lineTo(cx, 355);
        ctx.stroke();
        ctx.restore();

        // Nhãn đường tâm
        ctx.fillStyle = "#F8C600";
        ctx.font = "bold 11px Consolas, monospace";
        ctx.fillText("CL (ĐƯỜNG TÂM TRỤC CHUẨN)", 52, cy - 8);

        // 3.5 Vẽ hình chiếu cơ khí theo chế độ xem
        if (currentViewMode === "SECTION_AA") {
            drawLongitudinalSection(ctx, cx, cy, profileType);
        } else {
            drawRadialFlangeView(ctx, cx, cy, profileType);
        }

        // 3.6 Vẽ đường kích thước & Vạch dung sai L = 180mm ±0.02 và Cấp H7
        drawDimensionLine(
            ctx,
            cx - 150,
            cy + 95,
            cx + 150,
            cy + 95,
            cy + 132,
            "L = 180mm ±0.02 (CHUẨN LẮP GHÉP PANME)"
        );

        // Vạch dung sai đường kính lỗ / cổ trục H7
        drawVerticalToleranceCallout(
            ctx,
            cx + 150,
            cy - 54,
            cy + 54,
            cx + 205,
            "Ø112.00 H7 (+0.022 / 0)"
        );

        // Ký hiệu độ nhám bề mặt & độ đồng tâm
        drawTechnicalCallouts(ctx, cx, cy);

        // 3.7 Khung tên kỹ thuật góc phải dưới (CAD Title Block)
        drawTitleBlock(ctx, w, h, oemCode, partName, brandName);
    }

    function drawLongitudinalSection(ctx, cx, cy, profile) {
        ctx.save();

        // Thân vỏ ngoài mặt cắt (L = 300px tương ứng 180mm tỷ lệ 1.66:1)
        const left = cx - 150;
        const right = cx + 150;

        // Vẽ khối thân trụ bậc cơ khí
        ctx.strokeStyle = "#E2E8F0";
        ctx.lineWidth = 2.2;
        ctx.fillStyle = "rgba(30, 64, 175, 0.28)";

        // Nửa trên mặt cắt
        ctx.beginPath();
        ctx.moveTo(left, cy - 82);
        ctx.lineTo(left + 38, cy - 82);
        ctx.lineTo(left + 38, cy - 64);
        ctx.lineTo(right - 38, cy - 64);
        ctx.lineTo(right - 38, cy - 82);
        ctx.lineTo(right, cy - 82);
        ctx.lineTo(right, cy - 34);
        ctx.lineTo(left, cy - 34);
        ctx.closePath();
        ctx.fill();
        ctx.stroke();

        // Nửa dưới mặt cắt
        ctx.beginPath();
        ctx.moveTo(left, cy + 34);
        ctx.lineTo(right, cy + 34);
        ctx.lineTo(right, cy + 82);
        ctx.lineTo(right - 38, cy + 82);
        ctx.lineTo(right - 38, cy + 64);
        ctx.lineTo(left + 38, cy + 64);
        ctx.lineTo(left + 38, cy + 82);
        ctx.lineTo(left, cy + 82);
        ctx.closePath();
        ctx.fill();
        ctx.stroke();

        // Gạch mặt cắt kim loại 45 độ (Hatching)
        ctx.strokeStyle = "rgba(148, 163, 184, 0.45)";
        ctx.lineWidth = 1;
        for (let hx = left + 8; hx < right; hx += 14) {
            // Hatch trên
            ctx.beginPath();
            ctx.moveTo(hx, cy - 62);
            ctx.lineTo(Math.min(hx + 24, right), cy - 35);
            ctx.stroke();
            // Hatch dưới
            ctx.beginPath();
            ctx.moveTo(hx, cy + 35);
            ctx.lineTo(Math.min(hx + 24, right), cy + 62);
            ctx.stroke();
        }

        // Lòng trục chính cấp dung sai H7
        ctx.strokeStyle = "#38BDF8";
        ctx.lineWidth = 2;
        ctx.strokeRect(left - 24, cy - 22, 348, 44);

        // Rãnh xéc-măng / Rãnh phớt làm kín / Bạc đỡ tùy theo loại phụ tùng
        ctx.fillStyle = "#F8C600";
        const groovePositions = [-95, -45, 45, 95];
        groovePositions.forEach(function (offset) {
            ctx.fillRect(cx + offset - 5, cy - 34, 10, 12);
            ctx.fillRect(cx + offset - 5, cy + 22, 10, 12);
        });

        // Lỗ bu lông mặt bích 2 đầu
        ctx.strokeStyle = "#F8C600";
        ctx.lineWidth = 1.2;
        ctx.strokeRect(left, cy - 74, 38, 12);
        ctx.strokeRect(right - 38, cy - 74, 38, 12);
        ctx.strokeRect(left, cy + 62, 38, 12);
        ctx.strokeRect(right - 38, cy + 62, 38, 12);

        // Nhãn mặt cắt A-A
        ctx.fillStyle = "#38BDF8";
        ctx.font = "bold 12px Consolas, monospace";
        ctx.fillText("MẶT CẮT DỌC A-A (" + profile + " ASSEMBLY)", left, cy - 95);

        ctx.restore();
    }

    function drawRadialFlangeView(ctx, cx, cy, profile) {
        ctx.save();

        // Vòng tròn mặt bích ngoài
        ctx.strokeStyle = "#E2E8F0";
        ctx.lineWidth = 2.2;
        ctx.fillStyle = "rgba(30, 64, 175, 0.25)";
        ctx.beginPath();
        ctx.arc(cx, cy, 88, 0, Math.PI * 2);
        ctx.fill();
        ctx.stroke();

        // Vòng chia tâm lỗ bu lông (Pitch Circle Diameter - PCD)
        ctx.save();
        ctx.strokeStyle = "#F8C600";
        ctx.lineWidth = 1.2;
        ctx.setLineDash([8, 4, 2, 4]);
        ctx.beginPath();
        ctx.arc(cx, cy, 68, 0, Math.PI * 2);
        ctx.stroke();
        ctx.restore();

        // 8 lỗ bu lông định vị xung quanh
        for (let i = 0; i < 8; i++) {
            const angle = (i * Math.PI) / 4;
            const bx = cx + Math.cos(angle) * 68;
            const by = cy + Math.sin(angle) * 68;
            ctx.fillStyle = "#0B192C";
            ctx.strokeStyle = "#38BDF8";
            ctx.lineWidth = 1.6;
            ctx.beginPath();
            ctx.arc(bx, by, 8, 0, Math.PI * 2);
            ctx.fill();
            ctx.stroke();
        }

        // Lỗ trục tâm chuẩn H7 có rãnh then hoa
        ctx.fillStyle = "#0B192C";
        ctx.strokeStyle = "#F8C600";
        ctx.lineWidth = 2.4;
        ctx.beginPath();
        ctx.arc(cx, cy, 38, 0, Math.PI * 2);
        ctx.fill();
        ctx.stroke();

        // Rãnh then chuẩn DIN 6885
        ctx.fillStyle = "#0B192C";
        ctx.fillRect(cx - 7, cy - 46, 14, 10);
        ctx.strokeRect(cx - 7, cy - 46, 14, 10);

        ctx.fillStyle = "#38BDF8";
        ctx.font = "bold 12px Consolas, monospace";
        ctx.fillText("HÌNH CHIẾU MẶT BÍCH ĐỊNH TÂM B-B (" + profile + ")", cx - 135, cy - 102);

        ctx.restore();
    }

    function drawDimensionLine(ctx, x1, yRef, x2, yRef2, yDim, labelText) {
        ctx.save();
        ctx.strokeStyle = "#38BDF8";
        ctx.fillStyle = "#38BDF8";
        ctx.lineWidth = 1.3;

        // Đường gióng kích thước
        ctx.beginPath();
        ctx.moveTo(x1, yRef);
        ctx.lineTo(x1, yDim + 8);
        ctx.moveTo(x2, yRef2);
        ctx.lineTo(x2, yDim + 8);
        ctx.stroke();

        // Đường kích thước ngang
        ctx.beginPath();
        ctx.moveTo(x1, yDim);
        ctx.lineTo(x2, yDim);
        ctx.stroke();

        // Mũi tên trái
        ctx.beginPath();
        ctx.moveTo(x1, yDim);
        ctx.lineTo(x1 + 10, yDim - 4);
        ctx.lineTo(x1 + 10, yDim + 4);
        ctx.closePath();
        ctx.fill();

        // Mũi tên phải
        ctx.beginPath();
        ctx.moveTo(x2, yDim);
        ctx.lineTo(x2 - 10, yDim - 4);
        ctx.lineTo(x2 - 10, yDim + 4);
        ctx.closePath();
        ctx.fill();

        // Chữ kích thước L = 180mm ±0.02
        ctx.fillStyle = "#F8C600";
        ctx.font = "bold 13px Consolas, monospace";
        const textWidth = ctx.measureText(labelText).width;
        ctx.fillText(labelText, (x1 + x2 - textWidth) / 2, yDim - 8);
        ctx.restore();
    }

    function drawVerticalToleranceCallout(ctx, xRef, yTop, yBottom, xDim, labelText) {
        ctx.save();
        ctx.strokeStyle = "#F8C600";
        ctx.fillStyle = "#F8C600";
        ctx.lineWidth = 1.2;

        // Đường gióng ngang
        ctx.beginPath();
        ctx.moveTo(xRef, yTop);
        ctx.lineTo(xDim + 6, yTop);
        ctx.moveTo(xRef, yBottom);
        ctx.lineTo(xDim + 6, yBottom);
        ctx.stroke();

        // Đường đo dọc
        ctx.beginPath();
        ctx.moveTo(xDim, yTop);
        ctx.lineTo(xDim, yBottom);
        ctx.stroke();

        // Nhãn cấp dung sai H7
        ctx.font = "bold 12px Consolas, monospace";
        ctx.fillText(labelText, xDim + 12, (yTop + yBottom) / 2 - 4);
        ctx.fillStyle = "#38BDF8";
        ctx.font = "11px Consolas, monospace";
        ctx.fillText("CẤP DUNG SAI: H7 / g6", xDim + 12, (yTop + yBottom) / 2 + 14);
        ctx.restore();
    }

    function drawTechnicalCallouts(ctx, cx, cy) {
        ctx.save();
        ctx.fillStyle = "#E2E8F0";
        ctx.font = "12px Consolas, monospace";
        ctx.fillText("• Độ nhám bề mặt làm việc: Ra 0.4 µm", 32, 48);
        ctx.fillText("• Độ đảo đồng tâm trục: ≤ 0.015 mm", 32, 66);
        ctx.fillText("• Kiểm định: Panme Mitutoyo Nhật Bản", 32, 84);
        ctx.restore();
    }

    function drawTitleBlock(ctx, w, h, oem, name, brand) {
        ctx.save();
        const tbW = 310;
        const tbH = 74;
        const tbX = w - tbW - 22;
        const tbY = h - tbH - 22;

        ctx.fillStyle = "rgba(19, 28, 78, 0.92)";
        ctx.strokeStyle = "#F8C600";
        ctx.lineWidth = 1.5;
        ctx.fillRect(tbX, tbY, tbW, tbH);
        ctx.strokeRect(tbX, tbY, tbW, tbH);

        ctx.fillStyle = "#F8C600";
        ctx.font = "bold 12px Consolas, monospace";
        ctx.fillText("THOẠI HẰNG HEAVY PARTS - CAD BLUEPRINT", tbX + 10, tbY + 18);

        ctx.fillStyle = "#FFFFFF";
        ctx.font = "12px Consolas, monospace";
        ctx.fillText("MÃ OEM: " + oem + " | HÃNG: " + brand, tbX + 10, tbY + 38);

        ctx.fillStyle = "#38BDF8";
        ctx.font = "11px Consolas, monospace";
        ctx.fillText("DUNG SAI: L = 180mm ±0.02 | CẤP H7 (ISO)", tbX + 10, tbY + 58);
        ctx.restore();
    }

    drawBlueprint();

    // Nút chuyển góc nhìn bản vẽ CAD
    const viewButtons = document.querySelectorAll("[data-cad-view]");
    viewButtons.forEach(function (btn) {
        btn.addEventListener("click", function () {
            viewButtons.forEach(function (b) {
                b.classList.remove("active");
            });
            btn.classList.add("active");
            currentViewMode = btn.getAttribute("data-cad-view") || "SECTION_AA";
            drawBlueprint();
        });
    });
}
