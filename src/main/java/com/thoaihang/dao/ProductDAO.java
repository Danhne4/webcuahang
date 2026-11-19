package com.thoaihang.dao;

import com.thoaihang.model.BannerSlide;
import com.thoaihang.model.BrandPartner;
import com.thoaihang.model.CartItem;
import com.thoaihang.model.Category;
import com.thoaihang.model.Order;
import com.thoaihang.model.Product;
import java.nio.charset.StandardCharsets;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * ProductDAO (Singleton): Quản lý kho phụ tùng cơ khí, đơn hàng chành xe,
 * slide banner giới thiệu (10s chuyển động) và dải logo thương hiệu đối tác.
 */
public class ProductDAO {

    private static volatile ProductDAO instance;

    private final List<Product> products = new CopyOnWriteArrayList<>();
    private final List<Category> categories = new CopyOnWriteArrayList<>();
    private final List<Order> orders = new CopyOnWriteArrayList<>();
    private final List<BannerSlide> bannerSlides = new CopyOnWriteArrayList<>();
    private final List<BrandPartner> brandPartners = new CopyOnWriteArrayList<>();
    private final AtomicInteger idGenerator = new AtomicInteger(12);
    private final AtomicInteger orderSeq = new AtomicInteger(1042);
    private final AtomicInteger bannerIdGen = new AtomicInteger(3);
    private final AtomicInteger brandIdGen = new AtomicInteger(12);

    private ProductDAO() {
        initCategories();
        initProducts();
        initSampleOrders();
        initBannerSlides();
        initBrandPartners();
    }

    public static ProductDAO getInstance() {
        if (instance == null) {
            synchronized (ProductDAO.class) {
                if (instance == null) {
                    instance = new ProductDAO();
                }
            }
        }
        return instance;
    }

    private void initCategories() {
        categories.add(new Category(
                "CAT-BO-HOI",
                "Phụ tùng động cơ & Bộ hơi",
                "MARINE",
                "Piston, xéc măng, sơ mi xi lanh động cơ máy thủy & xe tải",
                "MECH-01",
                "/san-pham?q=Bộ+hơi",
                "engine"
        ));
        categories.add(new Category(
                "CAT-BOM-NUOC",
                "Bơm nước biển & Sinh hàn",
                "MARINE",
                "Bơm nước biển tự mồi thân đồng, ruột sinh hàn làm mát nước ngọt",
                "MECH-02",
                "/san-pham?q=nước",
                "pump"
        ));
        categories.add(new Category(
                "CAT-HOP-SO",
                "Hộp số thủy Advance 135A",
                "MARINE",
                "Hộp số đảo chiều máy thủy Advance 135A, 06, D300A, lá côn đồng",
                "MECH-03",
                "/san-pham?brand=Advance",
                "gearbox"
        ));
        categories.add(new Category(
                "CAT-KIM-PHUN",
                "Kim phun Denso Common Rail",
                "TRUCK",
                "Kim phun dầu điện tử áp suất cao Denso Euro 4 / Euro 5",
                "MECH-04",
                "/san-pham?brand=Denso",
                "injector"
        ));
        categories.add(new Category(
                "CAT-TURBO",
                "Turbo tăng áp Holset HX40W",
                "MARINE",
                "Turbo tăng áp Holset chính hãng cho Cummins, Yuchai, Weichai",
                "MECH-05",
                "/san-pham?brand=Holset",
                "turbo"
        ));
        categories.add(new Category(
                "CAT-BAC-BIEN",
                "Bạc biên & Bạc balie S6R2",
                "MARINE",
                "Bạc lót trục khuỷu, bạc biên balie Mitsubishi S6R2, S12R",
                "MECH-06",
                "/san-pham?q=bạc",
                "bearing"
        ));
        categories.add(new Category(
                "CAT-BAN-EP",
                "Bàn ép lá côn 430mm HD320",
                "TRUCK",
                "Cụm mâm ép lá côn ly hợp đường kính 430mm xe tải Hyundai HD320",
                "MECH-07",
                "/san-pham?brand=Hyundai",
                "clutch"
        ));
        categories.add(new Category(
                "CAT-VANH-CHAU",
                "Vành chậu cùi dứa Hino 700",
                "TRUCK",
                "Cặp bánh răng vành chậu cùi dứa cầu sau xe Hino 700 / 500",
                "MECH-08",
                "/san-pham?brand=Hino",
                "crown"
        ));
        categories.add(new Category(
                "CAT-BAU-PHANH",
                "Bầu phanh lốc kê Howo 371",
                "TRUCK",
                "Búp sen bầu phanh hơi lốc kê lò xo kép xe đầu kéo Howo A7 / 371",
                "MECH-09",
                "/san-pham?brand=Howo",
                "brake"
        ));
        categories.add(new Category(
                "CAT-BAC-TRUC",
                "Bạc cao su đỡ trục chân vịt",
                "MARINE",
                "Bạc cao su bọc đồng đỡ trục láp chân vịt tàu biển Ø80 - Ø150mm",
                "MECH-10",
                "/san-pham?q=chân+vịt",
                "propeller"
        ));
    }

    private void initProducts() {
        // 1. Bơm nước biển thân đồng máy thủy Yanmar 6CH
        products.add(new Product(
                1,
                "Bơm nước biển thân đồng máy thủy Yanmar 6CH",
                "119574-42502",
                "Yanmar",
                "MAY-THUY",
                "Máy Thủy & Tàu Xà Lan",
                "Hệ thống làm mát máy thủy",
                "Yanmar 6CH-HT / 6CH-DT / 6CH-WDT",
                14500000L,
                18,
                "Nhật Bản (Yanmar Marine Genuine)",
                "Thân đồng thau đúc áp lực C95800 chống ăn mòn nước mặn, trục Inox SUS316L, cánh cao su Neoprene 12 lá",
                "L = 180mm ±0.02, Cổ trục lắp bi Ø35mm cấp dung sai H7/k6, độ đảo hướng kính ≤ 0.015mm",
                "L = 180mm × Ø145mm × Họng hút/xả Ø50mm",
                14.8,
                "Kho Hải Phòng (Cảng Chùa Vẽ) & Kho TP.HCM",
                "Cụm bơm nước biển tự mồi chuyên dụng cho động cơ máy thủy Yanmar 6CH. Tích hợp phớt cơ khí Ceramic-Carbon chịu mặn, kiểm định kín áp 4.5 bar và đo kiểm Panme cổ trục cấp H7 trước khi xuất kho.",
                "PUMP"
        ));

        // 2. Ruột sinh hàn làm mát nước ngọt Cummins 6BT
        products.add(new Product(
                2,
                "Ruột sinh hàn làm mát nước ngọt Cummins 6BT",
                "3918292",
                "Cummins",
                "MAY-THUY",
                "Máy Thủy & Tàu Xà Lan",
                "Hệ thống làm mát máy thủy",
                "Cummins Marine 6BT5.9-M / 6BTA5.9",
                9800000L,
                24,
                "Mỹ / Liên doanh Cummins Marine",
                "Chùm ống đồng hợp kim CuNi 90/10 (Đồng - Niken) hàn bạc chống rỗ mọt nước biển, vách ngăn đồng thau dày 8mm",
                "L = 180mm ±0.02 (tâm khoang trao đổi nhiệt), Đường kính bó ống Ø110mm dung sai lắp vỏ H7",
                "Tổng dài 460mm × L_core = 180mm × Ø110mm (142 ống trao đổi nhiệt Ø6mm)",
                9.5,
                "Kho Hải Phòng (Cảng Chùa Vẽ) & Kho TP.HCM",
                "Ruột bầu sinh hàn giải nhiệt nước ngọt tuần hoàn cho động cơ thủy Cummins 6BT 5.9L. Đã thử kín khí nén ngâm bồn áp suất 10 bar, kèm bộ gioăng cao su Viton chịu nhiệt 180°C.",
                "COOLER"
        ));

        // 3. Bộ lá côn đồng & lá thép hộp số thủy Advance 135A
        products.add(new Product(
                3,
                "Bộ lá côn đồng & lá thép hộp số thủy Advance 135A",
                "135A-02-001",
                "Advance",
                "MAY-THUY",
                "Máy Thủy & Tàu Xà Lan",
                "Hộp số thủy & Truyền động",
                "Advance Marine Gearbox MB270A / 135A / HC135",
                6200000L,
                32,
                "Nhà máy Advance Hangzhou (Chính hãng)",
                "Lá đồng thiêu kết bột kim loại (Sintered Bronze) rãnh thoát dầu xoắn ốc, lá thép hợp kim 65Mn nhiệt luyện phẳng",
                "Đường kính ngoài Ø180mm ±0.02, Răng trong then hoa 38T dung sai H7, Độ phẳng bề mặt ≤ 0.02mm",
                "Ø180mm × Ø128mm × Dày 3.2mm (Bộ gồm 8 lá đồng + 8 lá thép)",
                6.4,
                "Kho Hải Phòng (Cảng Chùa Vẽ) & Kho TP.HCM",
                "Bộ đĩa ma sát côn tiến/lùi hộp số thủy Advance 135A chuyên dùng cho tàu cá xa bờ và sà lan chở cát. Hệ số ma sát động ổn định trong môi trường dầu thủy lực áp suất cao.",
                "CLUTCH"
        ));

        // 4. Bộ hơi đại tu động cơ Cummins 6BT 5.9L
        products.add(new Product(
                4,
                "Bộ hơi đại tu động cơ Cummins 6BT 5.9L",
                "3802747",
                "Cummins",
                "MAY-THUY",
                "Máy Thủy & Tàu Xà Lan",
                "Bộ hơi & Cơ cấu trục khuỷu",
                "Cummins 6BT 5.9L (Tàu thủy & Máy phát hàng hải)",
                18500000L,
                15,
                "Mỹ (Cummins Heavy Duty OEM)",
                "Sơ mi xylanh gang hợp kim Bo-Crôm võng lưới Honing 45°, Piston nhôm đúc Al-Si12 có vòng gang chống mòn rãnh xéc-măng số 1",
                "Hành trình váy L = 180mm ±0.02, Đường kính lòng xylanh Ø102.00mm cấp dung sai H7 (+0.022/0)",
                "Bộ 6 máy: Xylanh Ø102mm × L = 180mm, Chốt piston Ø40mm × 82mm + Bộ xéc-măng 3 lá",
                26.5,
                "Kho Hải Phòng (Cảng Chùa Vẽ) & Kho TP.HCM",
                "Trọn bộ hơi đại tu 6 máy động cơ Cummins 6BT 5.9L bao gồm: 6 sơ mi xylanh, 6 quả piston buồng đốt Omega, 6 bộ xéc-măng mạ Crôm kim cương, 6 ắc piston và phe hãm đồng bộ.",
                "PISTON"
        ));

        // 5. Bộ hơi xe tải Hino 500 FL/FG động cơ J08E
        products.add(new Product(
                5,
                "Bộ hơi xe tải Hino 500 FL/FG động cơ J08E",
                "S1140-71541",
                "Hino",
                "XE-TAI-NANG",
                "Xe Tải Nặng & Đầu Kéo",
                "Bộ hơi & Cơ cấu trục khuỷu",
                "Hino 500 Series FG8J / FL8J / FM8J (Động cơ J08E-UF / J08C)",
                21000000L,
                14,
                "Nhật Bản (Hino Motors Genuine Parts)",
                "Sơ mi xylanh bán khô mạ phosphate đen, Piston phủ lớp Graphite Molypden giảm ma sát khi khởi động lạnh",
                "Chiều cao sơ mi L = 180mm ±0.02, Đường kính danh nghĩa Ø112.00mm dung sai lắp ghép H7/g6",
                "Bộ 6 xylanh: Ø112mm × L = 180mm, Chốt piston Ø37mm, Xéc-măng NPR Nhật Bản",
                28.2,
                "Kho TP.HCM (Bến xe Miền Đông mới) & Kho Hải Phòng",
                "Bộ hơi đại tu tiêu chuẩn Euro 3/Euro 4 dành cho xe tải nặng Hino 500 (15 tấn - 3 chân FL/FG). Từng sơ mi và quả piston được phân nhóm kích thước A/B/C bằng dưỡng đo Panme điện tử.",
                "PISTON"
        ));

        // 6. Bàn ép lá côn 430mm Hyundai HD320 D6CA
        products.add(new Product(
                6,
                "Bàn ép lá côn 430mm Hyundai HD320 D6CA",
                "41100-8D000",
                "Hyundai",
                "XE-TAI-NANG",
                "Xe Tải Nặng & Đầu Kéo",
                "Hộp số & Hệ thống ly hợp",
                "Hyundai Trago HD320 / HD270 / Đầu kéo HD700 (Máy D6CA / D6CC)",
                7800000L,
                20,
                "Hàn Quốc (Valeo PyeongHwa / Hyundai Mobis)",
                "Mâm ép gang cầu FCD600 tản nhiệt hướng tâm, lò xo đĩa thép đàn hồi 51CrV4 tôi cao tần, bố côn sợi Kevlar đồng đan",
                "Tâm lỗ định vị bánh đà L = 180mm ±0.02, Đường kính đĩa ma sát Ø430mm, Then hoa 10 răng Ø2 inch H7",
                "Đường kính ngoài Ø430mm × Tâm bu lông lắp ghép × Lỗ trục cơ sở H7",
                34.0,
                "Kho TP.HCM (Cầu Đồng Nai) & Kho Hải Phòng",
                "Bàn ép ly hợp kiểu kéo (Pull-type) 430mm chịu mô-men xoắn tới 1.850 N.m cho xe tải 4 chân Hyundai HD320 và đầu kéo máy điện D6CA 380PS/410PS.",
                "CLUTCH"
        ));

        // 7. Bầu phanh lốc kê 2 tầng Howo Sinotruk 371
        products.add(new Product(
                7,
                "Bầu phanh lốc kê 2 tầng Howo Sinotruk 371",
                "WG9000360100",
                "Howo",
                "XE-TAI-NANG",
                "Xe Tải Nặng & Đầu Kéo",
                "Hệ thống phanh khí nén & Gầm",
                "Sinotruk Howo 371 / Howo 380 / Đầu kéo A7 / Ben 3 chân - 4 chân",
                1650000L,
                45,
                "Trung Quốc (WABCO / CNHTC Sinotruk Chính hãng)",
                "Vỏ thép dập nguội mạ kẽm cromat vàng, lò xo tích năng thép hợp kim Si-Mn sơn tĩnh điện, màng cao su EPDM bố vải 3 lớp",
                "Hành trình ty đẩy tiêu chuẩn L = 180mm ±0.02, Cổ lắp giá đỡ cầu Ø16mm dung sai H7",
                "Cỡ bầu T30/30 × Hành trình ty L = 180mm × Cổng ren khí nén M16×1.5",
                9.2,
                "Kho Hải Phòng (Cảng Chùa Vẽ) & Kho TP.HCM",
                "Bầu phanh hơi lốc kê 2 tầng T30/30 dùng cho cầu trung và cầu sau xe ben, đầu kéo Howo 371. Áp suất làm việc tối đa 10.5 bar, lực phanh dừng khẩn cấp đạt 8.200N.",
                "BRAKE"
        ));

        // 8. Kim phun điện tử Common Rail Denso Hino J08E
        products.add(new Product(
                8,
                "Kim phun điện tử Common Rail Denso Hino J08E",
                "095000-6593",
                "Denso",
                "XE-TAI-NANG",
                "Xe Tải Nặng & Đầu Kéo",
                "Hệ thống nhiên liệu & Turbo",
                "Hino 500 J08E / J05E / Máy công trình Kobelco SK330-8",
                5400000L,
                28,
                "Nhật Bản (Denso Corporation Genuine)",
                "Thân kim thép gió hợp kim Cr-Mo-V thấm Nitơ, van điều khiển từ tính Solenoid đáp ứng 0.15ms, đầu béc 7 lỗ tia",
                "Chiều dài thân chuẩn L = 180mm ±0.02, Cổ lắp ống lót đồng mặt máy Ø19mm dung sai H7",
                "L = 180mm × Đường kính thân Ø19mm (H7) × Áp suất phun 1.800 bar",
                0.85,
                "Kho TP.HCM (Bến xe Miền Đông mới) & Kho Hải Phòng",
                "Kim phun dầu điện tử Common Rail Denso mã 095000-6593 (23670-E0010) mới 100% nguyên hộp có mã QR Code hiệu chuẩn lưu lượng ECU cho động cơ Hino J08E.",
                "INJECTOR"
        ));

        // 9. Bộ bạc biên & bạc balie máy thủy Mitsubishi S6R2
        products.add(new Product(
                9,
                "Bộ bạc biên & bạc balie máy thủy Mitsubishi S6R2",
                "32520-02110",
                "Mitsubishi",
                "MAY-THUY",
                "Máy Thủy & Tàu Xà Lan",
                "Bộ hơi & Cơ cấu trục khuỷu",
                "Mitsubishi Heavy Marine S6R / S6R2-MPTK / S12R",
                16200000L,
                11,
                "Nhật Bản (MHI Mitsubishi Marine Genuine)",
                "Kết cấu hợp kim 3 lớp (Tri-Metal): lưng thép cacbon, lớp đồng-chì CuPb24Sn4 chịu tải va đập và lớp phủ Babbit chống xước",
                "Đường kính ổ trục chính L = 180mm ±0.02, Dung sai độ dày thành bạc ±0.004mm (Cấp lắp ghép H7/c6)",
                "Cổ trục chính (Balie) Ø180mm × Cổ biên Ø135mm (Đủ cốt STD, 0.25, 0.50)",
                12.6,
                "Kho Hải Phòng (Cảng Chùa Vẽ) & Kho TP.HCM",
                "Trọn bộ bạc biên (Connecting Rod Bearing) và bạc balie (Main Crankshaft Bearing) kèm căn dọc trục cơ cho máy thủy công suất lớn Mitsubishi S6R2 (650HP - 940HP).",
                "BEARING"
        ));

        // 10. Bộ vành chậu cùi dứa vi sai cầu sau Hino 700 7:41
        products.add(new Product(
                10,
                "Bộ vành chậu cùi dứa vi sai cầu sau Hino 700 7:41",
                "41204-3980",
                "Hino",
                "XE-TAI-NANG",
                "Xe Tải Nặng & Đầu Kéo",
                "Truyền động & Cầu vi sai",
                "Đầu kéo Hino 700 Series SS1EK / SH1EE (Động cơ E13C)",
                19500000L,
                9,
                "Nhật Bản (Hino Motors Heavy Axle)",
                "Thép hợp kim rèn khuôn 20CrMnTiH thấm cacbon sâu 1.8mm, tôi chân không HRC 60-62, mài răng Hypoid bằng máy Oerlikon",
                "Chiều dài trục quả dứa L = 180mm ±0.02, Cổ bi côn dung sai H7, Khe hở ăn khớp răng (Backlash) 0.25 - 0.33mm",
                "Tỷ số truyền 7:41 (Cùi dứa 7 răng / Vành chậu 41 răng Ø440mm × L_pinion = 180mm)",
                46.5,
                "Kho TP.HCM (Cầu Đồng Nai) & Kho Hải Phòng",
                "Bộ bánh răng truyền lực chính (Vành chậu - Cùi dứa) tỷ số truyền 7:41 chuyên trị tải nặng, leo đèo cho đầu kéo Hino 700. Đã rà vết tiếp xúc răng chuẩn 85% diện tích tại nhà máy.",
                "GEAR"
        ));

        // 11. Bạc cao su đỡ trục chân vịt vỏ đồng thau Ø90x120x360
        products.add(new Product(
                11,
                "Bạc cao su đỡ trục chân vịt vỏ đồng thau Ø90x120x360",
                "MSB-90120",
                "Advance",
                "MAY-THUY",
                "Máy Thủy & Tàu Xà Lan",
                "Hệ trục chân vịt & Bánh lái",
                "Hệ trục tàu cá, tàu kéo, sà lan tự hành đường kính cổ trục Ø90mm",
                4200000L,
                26,
                "Nhật Bản / Đài Loan (Chuẩn đăng kiểm VR & NK)",
                "Vỏ ống đồng thau hàng hải C36000 tiện CNC, lõi cao su Nitrile NBR-80 lưu hóa bám dính cao có 10 rãnh dẫn nước bôi trơn",
                "Đoạn chuẩn lắp ống bao trục L = 180mm × 2 (±0.02), Đường kính lưng ngoài Ø120mm dung sai H7",
                "Trục trong Ø90mm × Lưng ngoài Ø120mm (H7) × Tổng chiều dài 360mm (2×180mm)",
                8.9,
                "Kho Hải Phòng (Cảng Chùa Vẽ) & Kho TP.HCM",
                "Bạc đạn nước (Cutless Bearing) vỏ đồng thau đỡ trục chân vịt tàu thủy. Thiết kế rãnh nước thủy động học giúp triệt tiêu rung động hệ trục và chống mài mòn cát phù sa.",
                "BEARING"
        ));

        // 12. Turbo tăng áp Holset HX40W Cummins 6CTA8.3
        products.add(new Product(
                12,
                "Turbo tăng áp Holset HX40W Cummins 6CTA8.3",
                "4043980",
                "Holset",
                "MAY-THUY",
                "Máy Thủy & Tàu Xà Lan",
                "Hệ thống nhiên liệu & Turbo",
                "Cummins 6CTA 8.3L-M / Máy thủy & Xe tải nặng Dongfeng L375",
                11200000L,
                16,
                "Anh Quốc / Liên doanh Cummins Turbo Technologies",
                "Buồng sên xả gang cầu chịu nhiệt Si-Mo 850°C, cánh tuabin siêu hợp kim Inconel 713C, cánh nén nhôm Billet phay CNC 5 trục",
                "Khoảng cách tâm bích xả - nạp L = 180mm ±0.02, Bạc đồng trục רוtor dung sai H7, cân bằng động VSR 120.000 vòng/phút",
                "Khoảng tâm L = 180mm × Họng nạp Ø76mm × Mặt bích xả T4 tiêu chuẩn",
                15.4,
                "Kho Hải Phòng (Cảng Chùa Vẽ) & Kho TP.HCM",
                "Cụm Turbo tăng áp Holset HX40W có van xả áp (Wastegate) chính hãng cho động cơ Cummins 6CTA 8.3L. Đi kèm biên bản test cân bằng động tốc độ cao và bộ gioăng đường dầu inox.",
                "TURBO"
        ));
    }

    private void initSampleOrders() {
        List<CartItem> order1Items = new ArrayList<>();
        order1Items.add(new CartItem(getProductById(1), 1));
        order1Items.add(new CartItem(getProductById(3), 2));
        orders.add(new Order(
                "ORD-2026-1039",
                "Thuyền trưởng Nguyễn Văn Hùng",
                "0918452310",
                "Tàu cá QNg-98452-TS (Máy Yanmar 6CH)",
                "Nhà xe Phương Trang (Tuyến TP.HCM - cảng Sa Kỳ Quảng Ngãi)",
                "Kho TP.HCM (Bến xe Miền Đông mới)",
                "Cảng cá Sa Kỳ, Bình Châu, Bình Sơn, Quảng Ngãi",
                "Đóng thùng gỗ chống ẩm, kèm biên bản đo Panme cổ trục H7 và hóa đơn VAT.",
                order1Items,
                26900000L,
                "Đã giao chành xe",
                "18/11/2026 14:20"
        ));

        List<CartItem> order2Items = new ArrayList<>();
        order2Items.add(new CartItem(getProductById(5), 1));
        order2Items.add(new CartItem(getProductById(8), 4));
        orders.add(new Order(
                "ORD-2026-1040",
                "Chủ xe Trần Quốc Bảo (Đội xe Vận tải Bảo Long)",
                "0903881294",
                "Xe tải Hino 500 BKS: 51D-684.29",
                "Chành xe Tô Châu (Trạm Lê Hồng Phong - Đi Cần Thơ)",
                "Kho TP.HCM (Bến xe Miền Đông mới)",
                "Bến xe Trung tâm TP. Cần Thơ, Quốc lộ 1A, Cái Răng",
                "Gửi chuyến xe đêm 22h00 để gara kịp ráp máy sáng sớm mai.",
                order2Items,
                42600000L,
                "Đang đóng thùng",
                "18/11/2026 19:45"
        ));

        List<CartItem> order3Items = new ArrayList<>();
        order3Items.add(new CartItem(getProductById(4), 1));
        order3Items.add(new CartItem(getProductById(12), 1));
        orders.add(new Order(
                "ORD-2026-1041",
                "Kỹ sư máy trưởng Phạm Đình Tuấn",
                "0982771509",
                "Sà lan tự hành HP-4829 (Cummins 6BT 5.9L)",
                "Nhận trực tiếp tại Trạm Chành xe Cảng Chùa Vẽ - Hải Phòng",
                "Kho Hải Phòng (Cảng Chùa Vẽ)",
                "Bến cảng Chùa Vẽ, Quận Hải An, TP. Hải Phòng",
                "Kiểm tra đồng bộ mã QR Turbo Holset và khe hở miệng xéc-măng.",
                order3Items,
                29700000L,
                "Chờ xác nhận",
                "19/11/2026 00:15"
        ));
    }

    private static String toSvgDataUri(String svgXml) {
        String base64 = Base64.getEncoder().encodeToString(svgXml.getBytes(StandardCharsets.UTF_8));
        return "data:image/svg+xml;base64," + base64;
    }

    private void initBannerSlides() {
        // Slide 1: DENSO Common Rail (Tông Xanh Nước Biển hài hòa chuẩn mẫu BinhMinhJSC)
        bannerSlides.add(new BannerSlide(
                1,
                "DENSO Common rail",
                "Hệ thống phun dầu điện tử áp suất cao 1.800 Bar chính hãng Nhật Bản cho Hino J08E & Máy thủy",
                "KIM PHUN ĐIỆN TỬ COMMON RAIL|BƠM CAO ÁP SCV ĐỒNG BỘ|ĐẦU KIM BÉC PHUN 7 LỖ TIA|BỘ KIT ĐẠI TU SỬA CHỮA KIM PHUN",
                toSvgDataUri("<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 520 340'>"
                        + "<rect width='520' height='340' fill='#0369A1'/>"
                        + "<rect x='16' y='16' width='234' height='146' fill='#FFFFFF' stroke='#075985' stroke-width='4'/>"
                        + "<rect x='270' y='16' width='234' height='146' fill='#FFFFFF' stroke='#075985' stroke-width='4'/>"
                        + "<rect x='16' y='178' width='234' height='146' fill='#FFFFFF' stroke='#075985' stroke-width='4'/>"
                        + "<rect x='270' y='178' width='234' height='146' fill='#FFFFFF' stroke='#075985' stroke-width='4'/>"
                        + "<rect x='36' y='28' width='90' height='70' fill='#E0F2FE' stroke='#0284C7'/>"
                        + "<circle cx='155' cy='96' r='34' fill='#94A3B8' stroke='#0C4A6E' stroke-width='3'/>"
                        + "<rect x='135' y='52' width='40' height='18' fill='#F59E0B' stroke='#0C4A6E' stroke-width='2'/>"
                        + "<text x='36' y='148' font-family='Arial' font-size='12' font-weight='bold' fill='#0C4A6E'>BƠM CAO ÁP DENSO HP3/HP4</text>"
                        + "<g stroke='#0C4A6E' stroke-width='4'><line x1='300' y1='115' x2='340' y2='45'/><line x1='345' y1='115' x2='375' y2='45'/><line x1='395' y1='115' x2='415' y2='45'/><line x1='445' y1='115' x2='465' y2='45'/></g>"
                        + "<text x='295' y='148' font-family='Arial' font-size='12' font-weight='bold' fill='#0C4A6E'>BỘ 4 KIM PHUN 095000-6593</text>"
                        + "<rect x='34' y='230' width='115' height='58' fill='#0284C7' rx='4'/>"
                        + "<text x='52' y='264' font-family='Arial' font-size='14' font-weight='bold' fill='#FFFFFF'>DENSO</text>"
                        + "<rect x='165' y='205' width='18' height='84' fill='#64748B'/><rect x='192' y='225' width='14' height='64' fill='#94A3B8'/>"
                        + "<text x='36' y='312' font-family='Arial' font-size='12' font-weight='bold' fill='#0C4A6E'>ĐẦU KIM &amp; ỐNG LÓT ĐỒNG H7</text>"
                        + "<rect x='290' y='198' width='194' height='92' rx='6' fill='#F0F9FF' stroke='#7DD3FC' stroke-width='2'/>"
                        + "<rect x='308' y='215' width='26' height='58' fill='#075985'/><circle cx='385' cy='252' r='16' fill='none' stroke='#0C4A6E' stroke-width='3'/><rect x='435' y='218' width='18' height='54' fill='#0284C7'/>"
                        + "<text x='296' y='312' font-family='Arial' font-size='12' font-weight='bold' fill='#0C4A6E'>BỘ KIT ĐẠI TU KIM PHUN</text>"
                        + "</svg>"),
                "/san-pham?brand=Denso",
                "#0369A1",
                false
        ));

        // Slide 2: Tổng kho Đại tu Máy Thủy Yanmar, Cummins, Mitsubishi & Hộp số Advance
        bannerSlides.add(new BannerSlide(
                2,
                "YANMAR & CUMMINS MARINE",
                "Phụ tùng cơ khí đại tu máy thủy tàu biển, xà lan chuẩn dung sai Panme cấp H7",
                "BƠM NƯỚC BIỂN THÂN ĐỒNG YANMAR 6CH|RUỘT SINH HÀN ĐỒNG CUNI CUMMINS 6BT|LÁ CÔN ĐỒNG HỘP SỐ THỦY ADVANCE 135A|BẠC BIÊN BALIE MITSUBISHI S6R2",
                toSvgDataUri("<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 520 340'>"
                        + "<rect width='520' height='340' fill='#075985'/>"
                        + "<rect x='16' y='16' width='234' height='146' fill='#082F49' stroke='#38BDF8' stroke-width='3'/>"
                        + "<rect x='270' y='16' width='234' height='146' fill='#082F49' stroke='#38BDF8' stroke-width='3'/>"
                        + "<rect x='16' y='178' width='234' height='146' fill='#082F49' stroke='#38BDF8' stroke-width='3'/>"
                        + "<rect x='270' y='178' width='234' height='146' fill='#082F49' stroke='#38BDF8' stroke-width='3'/>"
                        + "<circle cx='133' cy='78' r='36' fill='none' stroke='#F59E0B' stroke-width='4'/><circle cx='133' cy='78' r='14' fill='#0284C7'/>"
                        + "<text x='32' y='146' font-family='Consolas, monospace' font-size='12' font-weight='bold' fill='#38BDF8'>BƠM NƯỚC BIỂN 119574-42502</text>"
                        + "<rect x='305' y='52' width='164' height='52' rx='8' fill='#0369A1' stroke='#38BDF8' stroke-width='2'/>"
                        + "<text x='290' y='146' font-family='Consolas, monospace' font-size='12' font-weight='bold' fill='#38BDF8'>SINH HÀN CUMMINS 3918292</text>"
                        + "<circle cx='133' cy='240' r='36' fill='none' stroke='#38BDF8' stroke-width='5' stroke-dasharray='12 4'/>"
                        + "<text x='32' y='308' font-family='Consolas, monospace' font-size='12' font-weight='bold' fill='#38BDF8'>CÔN ĐỒNG ADVANCE 135A</text>"
                        + "<rect x='320' y='204' width='134' height='68' fill='none' stroke='#F59E0B' stroke-width='3'/>"
                        + "<text x='290' y='308' font-family='Consolas, monospace' font-size='12' font-weight='bold' fill='#38BDF8'>BỘ HƠI CUMMINS 6BT 3802747</text>"
                        + "</svg>"),
                "/san-pham?category=MAY-THUY",
                "#075985",
                false
        ));

        // Slide 3: Phụ tùng Xe Tải Nặng Hino 500/700, Hyundai HD320, Sinotruk Howo 371
        bannerSlides.add(new BannerSlide(
                3,
                "HINO 500/700 & HOWO 371",
                "Tổng kho phụ tùng đại tu gầm máy xe tải nặng & đầu kéo trực gửi Chành xe 24/7",
                "BỘ HƠI ĐẠI TU HINO 500 ĐỘNG CƠ J08E|BÀN ÉP LÁ CÔN 430MM HYUNDAI HD320|VÀNH CHẬU CÙI DỨA VI SAI HINO 700 7:41|BẦU PHANH LỐC KÊ 2 TẦNG HOWO 371",
                toSvgDataUri("<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 520 340'>"
                        + "<rect width='520' height='340' fill='#0284C7'/>"
                        + "<rect x='16' y='16' width='234' height='146' fill='#FFFFFF' stroke='#075985' stroke-width='3'/>"
                        + "<rect x='270' y='16' width='234' height='146' fill='#FFFFFF' stroke='#075985' stroke-width='3'/>"
                        + "<rect x='16' y='178' width='234' height='146' fill='#FFFFFF' stroke='#075985' stroke-width='3'/>"
                        + "<rect x='270' y='178' width='234' height='146' fill='#FFFFFF' stroke='#075985' stroke-width='3'/>"
                        + "<rect x='95' y='36' width='76' height='80' fill='#0369A1' stroke='#0C4A6E' stroke-width='3'/>"
                        + "<text x='32' y='146' font-family='Arial' font-size='12' font-weight='bold' fill='#0C4A6E'>BỘ HƠI HINO J08E S1140-71541</text>"
                        + "<circle cx='387' cy='78' r='40' fill='#E0F2FE' stroke='#0369A1' stroke-width='4'/><circle cx='387' cy='78' r='16' fill='#075985'/>"
                        + "<text x='290' y='146' font-family='Arial' font-size='12' font-weight='bold' fill='#0C4A6E'>BÀN ÉP 430MM HD320 41100-8D000</text>"
                        + "<circle cx='133' cy='240' r='38' fill='none' stroke='#0284C7' stroke-width='6' stroke-dasharray='10 5'/>"
                        + "<text x='32' y='308' font-family='Arial' font-size='12' font-weight='bold' fill='#0C4A6E'>VÀNH CHẬU HINO 700 41204-3980</text>"
                        + "<rect x='345' y='204' width='84' height='72' rx='12' fill='#075985' stroke='#0C4A6E' stroke-width='3'/>"
                        + "<text x='288' y='308' font-family='Arial' font-size='12' font-weight='bold' fill='#0C4A6E'>LỐC KÊ HOWO 371 WG9000360100</text>"
                        + "</svg>"),
                "/san-pham?category=XE-TAI-NANG",
                "#0284C7",
                false
        ));
    }

    private void initBrandPartners() {
        // 1. Cummins (Logo chữ C đen chuẩn mẫu ảnh 1)
        brandPartners.add(new BrandPartner(1, "Cummins", "USA Marine & Diesel",
                toSvgDataUri("<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 180 84'><rect width='180' height='84' fill='#ffffff'/><path d='M115 24 H84 A24 24 0 0 0 84 64 H115 V49 H86 A9 9 0 0 1 86 39 H115 Z' fill='#111827'/><text x='56' y='47' font-family='Arial Black, sans-serif' font-size='13' fill='#1D2C7B'>CUMMINS</text></svg>")));

        // 2. ZF Friedrichshafen (Vòng tròn xanh ZF chuẩn mẫu ảnh 1)
        brandPartners.add(new BrandPartner(2, "ZF Marine", "Germany Gearbox",
                toSvgDataUri("<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 180 84'><rect width='180' height='84' fill='#ffffff'/><circle cx='90' cy='42' r='28' fill='none' stroke='#00549F' stroke-width='4'/><text x='67' y='52' font-family='Arial Black, sans-serif' font-size='26' font-weight='900' fill='#00549F'>ZF</text></svg>")));

        // 3. Delphi Technologies (Chữ xanh đậm chuẩn mẫu ảnh 1)
        brandPartners.add(new BrandPartner(3, "Delphi", "Fuel Injection Systems",
                toSvgDataUri("<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 180 84'><rect width='180' height='84' fill='#ffffff'/><text x='28' y='52' font-family='Arial Black, sans-serif' font-size='28' font-weight='900' fill='#0000FF'>Delphi</text></svg>")));

        // 4. Garrett Advancing Motion (Chữ đỏ chuẩn mẫu ảnh 1)
        brandPartners.add(new BrandPartner(4, "Garrett", "Turbocharger OEM",
                toSvgDataUri("<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 180 84'><rect width='180' height='84' fill='#ffffff'/><text x='24' y='52' font-family='Impact, Arial Black, sans-serif' font-size='31' fill='#EF233C'>Garrett</text></svg>")));

        // 5. Showa (Chữ xanh chuẩn mẫu ảnh 1)
        brandPartners.add(new BrandPartner(5, "Showa", "Japan Hydraulics",
                toSvgDataUri("<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 180 84'><rect width='180' height='84' fill='#ffffff'/><text x='32' y='50' font-family='Segoe UI, Arial, sans-serif' font-size='24' font-weight='700' fill='#3B5998'>SHOWA</text></svg>")));

        // 6. Baldwin Filters (Khối đỏ nghiêng chuẩn mẫu ảnh 1)
        brandPartners.add(new BrandPartner(6, "Baldwin", "Heavy Duty Filters",
                toSvgDataUri("<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 180 84'><rect width='180' height='84' fill='#ffffff'/><polygon points='30,16 142,16 130,48 18,48' fill='#D90429'/><polygon points='54,48 158,48 148,70 44,70' fill='#ffffff' stroke='#111827' stroke-width='1.5'/><text x='34' y='38' font-family='Arial Black, sans-serif' font-size='15' font-style='italic' fill='#ffffff'>BALDWIN</text><text x='62' y='64' font-family='Arial Black, sans-serif' font-size='13' font-style='italic' fill='#111827'>FILTERS</text></svg>")));

        // 7. Donaldson Filtration Solutions (Chuẩn mẫu ảnh 1)
        brandPartners.add(new BrandPartner(7, "Donaldson", "Filtration Solutions",
                toSvgDataUri("<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 180 84'><rect width='180' height='84' fill='#ffffff'/><circle cx='34' cy='42' r='12' fill='none' stroke='#1D63B8' stroke-width='4'/><text x='54' y='46' font-family='Georgia, serif' font-size='21' font-weight='bold' fill='#1D63B8'>Donaldson</text><text x='54' y='58' font-family='Arial, sans-serif' font-size='8' fill='#1D63B8'>FILTRATION SOLUTIONS</text></svg>")));

        // 8. Denso Japan
        brandPartners.add(new BrandPartner(8, "Denso", "Common Rail Japan",
                toSvgDataUri("<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 180 84'><rect width='180' height='84' fill='#ffffff'/><text x='28' y='52' font-family='Arial Black, sans-serif' font-size='27' font-style='italic' fill='#D90429'>DENSO</text></svg>")));

        // 9. Yanmar Marine
        brandPartners.add(new BrandPartner(9, "Yanmar", "Marine Diesel Japan",
                toSvgDataUri("<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 180 84'><rect width='180' height='84' fill='#ffffff'/><text x='22' y='52' font-family='Arial Black, sans-serif' font-size='25' font-style='italic' fill='#E11D48'>YANMAR</text></svg>")));

        // 10. Hino Motors
        brandPartners.add(new BrandPartner(10, "Hino", "Hino 500 / 700 Series",
                toSvgDataUri("<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 180 84'><rect width='180' height='84' fill='#ffffff'/><text x='42' y='52' font-family='Arial Black, sans-serif' font-size='28' fill='#DC2626'>HINO</text></svg>")));

        // 11. Advance Gearbox
        brandPartners.add(new BrandPartner(11, "Advance", "Marine Gearbox 135A",
                toSvgDataUri("<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 180 84'><rect width='180' height='84' fill='#ffffff'/><text x='18' y='50' font-family='Arial Black, sans-serif' font-size='23' fill='#1D2C7B'>ADVANCE</text></svg>")));

        // 12. Holset Turbochargers
        brandPartners.add(new BrandPartner(12, "Holset", "Cummins Turbo Tech",
                toSvgDataUri("<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 180 84'><rect width='180' height='84' fill='#ffffff'/><text x='26' y='51' font-family='Arial Black, sans-serif' font-size='25' fill='#B91C1C'>HOLSET</text></svg>")));
    }

    public List<BannerSlide> getBannerSlides() {
        return new ArrayList<>(bannerSlides);
    }

    public synchronized BannerSlide addBannerSlide(String title, String subtitle, String bulletPoints,
                                                   String imageUrl, String targetLink,
                                                   String accentColor, boolean customUploadedImage) {
        int id = bannerIdGen.incrementAndGet();
        BannerSlide slide = new BannerSlide(
                id,
                (title != null && !title.isBlank()) ? title.trim() : "TỔNG KHO PHỤ TÙNG CƠ KHÍ THOẠI HẰNG",
                (subtitle != null && !subtitle.isBlank()) ? subtitle.trim() : "Phân phối chính hãng phụ tùng đại tu máy thủy & xe tải nặng",
                (bulletPoints != null && !bulletPoints.isBlank()) ? bulletPoints.trim()
                        : "CHUẨN XÁC MÃ OEM|KIỂM ĐỊNH PANME DUNG SAI H7|GỬI CHÀNH XE 24/7|HÓA ĐƠN VAT & CO/CQ",
                imageUrl,
                (targetLink != null && !targetLink.isBlank()) ? targetLink.trim() : "/san-pham",
                (accentColor != null && !accentColor.isBlank()) ? accentColor.trim() : "#1D2C7B",
                customUploadedImage
        );
        bannerSlides.add(0, slide);
        return slide;
    }

    public synchronized boolean deleteBannerSlide(int id) {
        if (bannerSlides.size() <= 1) {
            return false; // Giữ tối thiểu 1 slide trên trang chủ
        }
        return bannerSlides.removeIf(s -> s.getId() == id);
    }

    public List<BrandPartner> getBrandPartners() {
        return new ArrayList<>(brandPartners);
    }

    public synchronized BrandPartner addBrandPartner(String name, String subtitle, String logoUrl) {
        int id = brandIdGen.incrementAndGet();
        String cleanName = (name != null && !name.isBlank()) ? name.trim() : "OEM Partner";
        String finalLogo = logoUrl;
        if (finalLogo == null || finalLogo.isBlank()) {
            finalLogo = toSvgDataUri("<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 180 84'>"
                    + "<rect width='180' height='84' fill='#ffffff'/>"
                    + "<text x='20' y='50' font-family='Arial Black, sans-serif' font-size='22' fill='#1D2C7B'>"
                    + cleanName.replaceAll("[<>&\"']", "")
                    + "</text></svg>");
        }
        BrandPartner bp = new BrandPartner(
                id,
                cleanName,
                (subtitle != null && !subtitle.isBlank()) ? subtitle.trim() : "Official Partner",
                finalLogo
        );
        brandPartners.add(0, bp);
        return bp;
    }

    public synchronized boolean deleteBrandPartner(int id) {
        if (brandPartners.size() <= 1) {
            return false;
        }
        return brandPartners.removeIf(b -> b.getId() == id);
    }

    public List<Category> getCategories() {
        return new ArrayList<>(categories);
    }

    public Category getCategoryById(String id) {
        if (id == null) {
            return null;
        }
        for (Category c : categories) {
            if (c.getId().equalsIgnoreCase(id.trim())) {
                return c;
            }
        }
        return null;
    }

    public synchronized Category addCategory(String id, String name, String groupType, String description,
                                             String technicalCode, String targetUrl, String iconType) {
        if (id == null || id.isBlank()) {
            id = "CAT-" + System.currentTimeMillis();
        }
        id = id.trim();
        Category existing = getCategoryById(id);
        if (existing != null) {
            updateCategory(id, name, groupType, description, technicalCode, targetUrl, iconType);
            return existing;
        }
        Category c = new Category(
                id,
                (name != null) ? name.trim() : "",
                (groupType != null && !groupType.isBlank()) ? groupType.trim() : "MARINE",
                (description != null) ? description.trim() : "",
                (technicalCode != null) ? technicalCode.trim() : "",
                (targetUrl != null && !targetUrl.isBlank()) ? targetUrl.trim() : "/san-pham",
                (iconType != null && !iconType.isBlank()) ? iconType.trim().toLowerCase() : "engine"
        );
        categories.add(c);
        return c;
    }

    public synchronized boolean updateCategory(String id, String name, String groupType, String description,
                                               String technicalCode, String targetUrl, String iconType) {
        if (id == null || id.isBlank()) {
            return false;
        }
        for (Category c : categories) {
            if (c.getId().equalsIgnoreCase(id.trim())) {
                if (name != null && !name.isBlank()) {
                    c.setName(name.trim());
                }
                if (groupType != null && !groupType.isBlank()) {
                    c.setGroupType(groupType.trim());
                }
                if (description != null) {
                    c.setDescription(description.trim());
                }
                if (technicalCode != null) {
                    c.setTechnicalCode(technicalCode.trim());
                }
                if (targetUrl != null && !targetUrl.isBlank()) {
                    c.setTargetUrl(targetUrl.trim());
                }
                if (iconType != null && !iconType.isBlank()) {
                    c.setIconType(iconType.trim().toLowerCase());
                }
                return true;
            }
        }
        return false;
    }

    public synchronized boolean deleteCategory(String id) {
        if (id == null || id.isBlank()) {
            return false;
        }
        return categories.removeIf(c -> c.getId().equalsIgnoreCase(id.trim()));
    }

    public List<Product> getAllProducts() {
        return new ArrayList<>(products);
    }

    public Product getProductById(int id) {
        for (Product p : products) {
            if (p.getId() == id) {
                return p;
            }
        }
        return null;
    }

    public Product getProductByOem(String oemCode) {
        if (oemCode == null || oemCode.trim().isEmpty()) {
            return null;
        }
        String target = oemCode.trim().toLowerCase(Locale.ROOT);
        for (Product p : products) {
            if (p.getOemCode().toLowerCase(Locale.ROOT).equals(target)) {
                return p;
            }
        }
        return null;
    }

    public List<Product> getProductsByCategory(String category) {
        if (category == null || category.trim().isEmpty() || "ALL".equalsIgnoreCase(category)) {
            return getAllProducts();
        }
        List<Product> result = new ArrayList<>();
        for (Product p : products) {
            if (p.getCategory().equalsIgnoreCase(category.trim())) {
                result.add(p);
            }
        }
        return result;
    }

    public List<Product> searchProducts(String keyword, String category, String brand, String sortBy) {
        List<Product> result = new ArrayList<>();
        String kw = (keyword != null) ? keyword.trim().toLowerCase(Locale.ROOT) : "";
        String cat = (category != null) ? category.trim() : "";
        String br = (brand != null) ? brand.trim() : "";

        for (Product p : products) {
            boolean matchKeyword = kw.isEmpty()
                    || p.getName().toLowerCase(Locale.ROOT).contains(kw)
                    || p.getOemCode().toLowerCase(Locale.ROOT).contains(kw)
                    || p.getBrand().toLowerCase(Locale.ROOT).contains(kw)
                    || p.getEngineModel().toLowerCase(Locale.ROOT).contains(kw)
                    || p.getSubSystem().toLowerCase(Locale.ROOT).contains(kw);

            boolean matchCategory = cat.isEmpty() || "ALL".equalsIgnoreCase(cat)
                    || p.getCategory().equalsIgnoreCase(cat);

            boolean matchBrand = br.isEmpty() || "ALL".equalsIgnoreCase(br)
                    || p.getBrand().equalsIgnoreCase(br);

            if (matchKeyword && matchCategory && matchBrand) {
                result.add(p);
            }
        }

        if ("price-asc".equalsIgnoreCase(sortBy)) {
            result.sort(Comparator.comparingLong(Product::getPrice));
        } else if ("price-desc".equalsIgnoreCase(sortBy)) {
            result.sort(Comparator.comparingLong(Product::getPrice).reversed());
        } else if ("name-asc".equalsIgnoreCase(sortBy)) {
            result.sort(Comparator.comparing(Product::getName));
        }

        return result;
    }

    public List<Product> getRelatedProducts(int currentId, String category, int limit) {
        List<Product> result = new ArrayList<>();
        for (Product p : products) {
            if (p.getId() != currentId && p.getCategory().equalsIgnoreCase(category)) {
                result.add(p);
                if (result.size() >= limit) {
                    break;
                }
            }
        }
        return result;
    }

    public synchronized Product addProduct(String name, String oemCode, String brand, String category,
                                           String subSystem, String engineModel, long price, int stock,
                                           String origin, String materialSpec, String toleranceSpec,
                                           String dimensions, double weightKg, String description,
                                           String imageUrl) {
        int newId = idGenerator.incrementAndGet();
        String categoryLabel = "XE-TAI-NANG".equalsIgnoreCase(category)
                ? "Xe Tải Nặng & Đầu Kéo"
                : "Máy Thủy & Tàu Xà Lan";
        String warehouse = "Kho Hải Phòng (Cảng Chùa Vẽ) & Kho TP.HCM";
        String cadType = "XE-TAI-NANG".equalsIgnoreCase(category) ? "GEAR" : "PUMP";
        String cleanImg = (imageUrl != null && !imageUrl.isBlank()) ? imageUrl.trim() : null;

        Product newProduct = new Product(
                newId,
                name,
                oemCode,
                brand,
                category,
                categoryLabel,
                (subSystem != null && !subSystem.isBlank()) ? subSystem : "Cụm chi tiết đại tu tiêu chuẩn",
                (engineModel != null && !engineModel.isBlank()) ? engineModel : brand + " Heavy Duty Series",
                price,
                stock,
                (origin != null && !origin.isBlank()) ? origin : "Chính hãng OEM (Có CO/CQ)",
                (materialSpec != null && !materialSpec.isBlank()) ? materialSpec : "Thép hợp kim & Đồng kỹ thuật gia công CNC",
                (toleranceSpec != null && !toleranceSpec.isBlank()) ? toleranceSpec : "L = 180mm ±0.02, Dung sai lắp ghép cấp H7",
                (dimensions != null && !dimensions.isBlank()) ? dimensions : "L = 180mm ±0.02 (Cấp chính xác H7)",
                weightKg > 0 ? weightKg : 8.5,
                warehouse,
                (description != null && !description.isBlank()) ? description
                        : "Phụ tùng chính hãng lưu kho Thoại Hằng, đã kiểm định dung sai Panme H7 trước khi đóng kiện gửi chành xe.",
                cadType,
                cleanImg
        );
        products.add(0, newProduct);
        return newProduct;
    }

    public synchronized boolean updateProductImage(int productId, String imageUrl) {
        Product p = getProductById(productId);
        if (p != null) {
            String cleanImg = (imageUrl != null && !imageUrl.isBlank()) ? imageUrl.trim() : null;
            p.setImageUrl(cleanImg);
            return true;
        }
        return false;
    }

    public synchronized boolean updateProductStock(int productId, int newStock) {
        Product p = getProductById(productId);
        if (p != null && newStock >= 0) {
            p.setStock(newStock);
            return true;
        }
        return false;
    }

    public synchronized Order createOrder(String customerName, String phone, String vesselOrPlateNumber,
                                          String shippingCarrier, String dispatchWarehouse,
                                          String deliveryAddress, String technicalNotes,
                                          List<CartItem> cartItems) {
        int seq = orderSeq.incrementAndGet();
        String orderCode = "ORD-2026-" + seq;
        long total = 0L;
        List<CartItem> snapshot = new ArrayList<>();
        if (cartItems != null) {
            for (CartItem item : cartItems) {
                total += item.getSubTotal();
                snapshot.add(new CartItem(item.getProduct(), item.getQuantity()));
                // Trừ tồn kho thực tế
                Product p = getProductById(item.getProduct().getId());
                if (p != null && p.getStock() >= item.getQuantity()) {
                    p.setStock(p.getStock() - item.getQuantity());
                }
            }
        }
        String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
        Order order = new Order(
                orderCode,
                customerName,
                phone,
                vesselOrPlateNumber,
                shippingCarrier,
                dispatchWarehouse,
                deliveryAddress,
                technicalNotes,
                snapshot,
                total,
                "Chờ xác nhận",
                now
        );
        orders.add(0, order);
        return order;
    }

    public List<Order> getAllOrders() {
        return new ArrayList<>(orders);
    }

    public Order getOrderByCode(String orderCode) {
        if (orderCode == null) {
            return null;
        }
        for (Order o : orders) {
            if (o.getOrderCode().equalsIgnoreCase(orderCode.trim())) {
                return o;
            }
        }
        return null;
    }

    public synchronized boolean updateOrderStatus(String orderCode, String newStatus) {
        Order order = getOrderByCode(orderCode);
        if (order != null && newStatus != null && !newStatus.isBlank()) {
            order.setStatus(newStatus.trim());
            return true;
        }
        return false;
    }

    public int getTotalInventoryUnits() {
        int sum = 0;
        for (Product p : products) {
            sum += p.getStock();
        }
        return sum;
    }

    public String getFormattedTotalInventoryValue() {
        long val = 0L;
        for (Product p : products) {
            val += (p.getPrice() * p.getStock());
        }
        return formatVnd(val);
    }

    public String getFormattedTotalOrdersRevenue() {
        long val = 0L;
        for (Order o : orders) {
            if (!"Đã hủy".equalsIgnoreCase(o.getStatus())) {
                val += o.getTotalAmount();
            }
        }
        return formatVnd(val);
    }

    public static String formatVnd(long amount) {
        DecimalFormatSymbols symbols = new DecimalFormatSymbols(Locale.forLanguageTag("vi-VN"));
        symbols.setGroupingSeparator('.');
        DecimalFormat df = new DecimalFormat("#,###", symbols);
        return df.format(amount) + " đ";
    }
}
