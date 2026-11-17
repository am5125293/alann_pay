import 'package:flutter/material.dart';

// ============================================================
// Alann_pay - Redesign Homepage E-Wallet (satu file main.dart)
// Konsep: StatelessWidget, StatefulWidget + setState, Scaffold,
// Container, Row, Column, Padding, SizedBox, Expanded, Stack,
// Positioned, GridView, SingleChildScrollView, Icon, Text.
// ============================================================

void main() {
  runApp(const AlannPayApp());
}

// ---------------- Palet Warna ----------------
const Color primaryPurple = Color(0xFF5425C9);
const Color darkPurple = Color(0xFF4520A5);
const Color lavender = Color(0xFFDCD5F4);
const Color lightLavender = Color(0xFFF1EDFF);
const Color blueColor = Color(0xFF5279E8);
const Color backgroundColor = Color(0xFFF7F7FA);
const Color textDark = Color(0xFF171526);
const Color textGrey = Color(0xFF85858D);
const Color headerBottom = Color(0xFFEAE5FA);

// ---------------- Data Menu (simulasi) ----------------
class MenuItem {
  final String name;
  final IconData icon;
  final Color color;

  const MenuItem(this.name, this.icon, this.color);
}

const List<String> categories = ['Pilihan', 'Tagihan', 'Asuransi'];

const List<List<MenuItem>> services = [
  // Pilihan
  [
    MenuItem('Pulsa', Icons.smartphone, Color(0xFF2F6BFF)),
    MenuItem('Paket Data', Icons.public, Color(0xFF1FA463)),
    MenuItem('PLN', Icons.bolt, Color(0xFFFF9F1C)),
    MenuItem('Pajak PBB', Icons.receipt_long, Color(0xFF14A38B)),
    MenuItem('Internet & TV Kabel', Icons.tv, Color(0xFFFF6B4A)),
    MenuItem('Proteksi', Icons.beach_access, Color(0xFF6B3FD4)),
    MenuItem('Invest', Icons.show_chart, Color(0xFF2BB5B0)),
    MenuItem('Deals', Icons.local_offer, Color(0xFFE5365B)),
  ],
  // Tagihan
  [
    MenuItem('PLN', Icons.bolt, Color(0xFFFF9F1C)),
    MenuItem('Pajak PBB', Icons.receipt_long, Color(0xFF14A38B)),
    MenuItem('Internet', Icons.wifi, Color(0xFF2F6BFF)),
    MenuItem('Air', Icons.water_drop, Color(0xFF2BB5B0)),
    MenuItem('BPJS', Icons.health_and_safety, Color(0xFF1FA463)),
  ],
  // Asuransi
  [
    MenuItem('Proteksi', Icons.beach_access, Color(0xFF6B3FD4)),
    MenuItem('Asuransi Kesehatan', Icons.favorite, Color(0xFFE5365B)),
    MenuItem('Asuransi Kendaraan', Icons.directions_car, Color(0xFF2F6BFF)),
    MenuItem('Asuransi Jiwa', Icons.family_restroom, Color(0xFFFF9F1C)),
  ],
];

// ---------------- Aplikasi ----------------
class AlannPayApp extends StatelessWidget {
  const AlannPayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alann_pay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryPurple),
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: const HomePage(),
    );
  }
}

// ---------------- Halaman Utama ----------------
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _hideBalance = false;
  int _selectedCategory = 0;
  int _navIndex = 0;

  // Respons sederhana berupa SnackBar
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        backgroundColor: darkPurple,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 110),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // Seluruh halaman dapat di-scroll
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(),
                  Container(
                    color: headerBottom,
                    child: _buildWhiteBody(),
                  ),
                  Container(height: 8, color: backgroundColor),
                  _buildBannerSection(),
                ],
              ),
            ),
          ),
          // Bottom navigation tetap di bawah layar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomNav(),
          ),
        ],
      ),
    );
  }

  // ============ A. HEADER ============
  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [lavender, headerBottom],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Column(
            children: [
              _buildTopBar(),
              const SizedBox(height: 16),
              _buildBalanceCard(),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Logo teks Alann_pay
        Row(
          children:  [
            SizedBox(
              height: 50,
              width : 50,
              child: Image.asset("assets/images/ovo.png")),
              SizedBox(
                width: 18,
              ),
            Text(
              'ovo',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w400,
                color: blueColor,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        // Tombol Promo + badge merah
        GestureDetector(
          onTap: () => _showMessage('Promo spesial untukmu segera hadir!'),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0x99FFFFFF),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.percent, color: primaryPurple, size: 22),
                    SizedBox(width: 8),
                    Text(
                      'Promo',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: primaryPurple,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 2,
                top: -2,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============ B. KARTU SALDO ============
  Widget _buildBalanceCard() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryPurple, Color(0xFF4F46D8), blueColor],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Dekorasi lingkaran transparan
          Positioned(
            right: -40,
            top: -50,
            child: Container(
              width: 160,
              height: 160,
              decoration: const BoxDecoration(
                color: Color(0x1AFFFFFF),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: -30,
            bottom: -60,
            child: Container(
              width: 140,
              height: 140,
              decoration: const BoxDecoration(
                color: Color(0x14FFFFFF),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 60,
            bottom: -30,
            child: Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                color: Color(0x14FFFFFF),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Isi kartu
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Alann_pay Cash',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Total Saldo',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(width: 6),
                    // Tombol mata
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _hideBalance = !_hideBalance;
                        });
                      },
                      child: Icon(
                        _hideBalance
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Rp ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          _hideBalance ? '••••••••' : '10.000.000',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    // Tombol Points
                    GestureDetector(
                      onTap: () =>
                          _showMessage('Kamu punya 1.834.700 Points'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: const [
                            CircleAvatar(
                              radius: 9,
                              backgroundColor: primaryPurple,
                              child: Text(
                                'P',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              '1.834.700 Points',
                              style: TextStyle(
                                color: primaryPurple,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(Icons.chevron_right,
                                color: textGrey, size: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Empat shortcut
                Row(
                  children: [
                    _buildShortcut(Icons.add, 'Top Up',
                        'Top Up: pilih nominal saldo (simulasi)'),
                    _buildShortcut(Icons.arrow_upward, 'Transfer',
                        'Transfer: pilih tujuan transfer (simulasi)'),
                    _buildShortcut(Icons.atm, 'Tarik Tunai',
                        'Tarik Tunai: pilih ATM terdekat (simulasi)'),
                    _buildShortcut(Icons.receipt_long, 'History',
                        'History: riwayat transaksi (simulasi)'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShortcut(IconData icon, String label, String message) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _showMessage(message),
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0x33FFFFFF),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============ BODY PUTIH ============
  Widget _buildWhiteBody() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUpgradeCard(),
            const SizedBox(height: 24),
            _buildCategories(),
            const SizedBox(height: 16),
            _buildServiceGrid(),
          ],
        ),
      ),
    );
  }

  // ============ C. KARTU UPGRADE ============
  Widget _buildUpgradeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 14,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Ilustrasi medali: lingkaran kuning + ikon ungu
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFC93C),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Icon(Icons.workspace_premium,
                      color: primaryPurple, size: 38),
                ],
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Yuk, upgrade ke Alann_pay Premier!\nNikmati akses dan benefit lengkap dari Alann_pay',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textDark,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => _showMessage('Upgrade ke Alann_pay Premier'),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                decoration: BoxDecoration(
                  color: primaryPurple,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'Upgrade',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============ D. KATEGORI ============
  Widget _buildCategories() {
    List<Widget> chips = [];
    for (int i = 0; i < categories.length; i++) {
      bool active = i == _selectedCategory;
      chips.add(
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedCategory = i;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: active ? lightLavender : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              categories[i],
              style: TextStyle(
                fontSize: 14,
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                color: active ? primaryPurple : textGrey,
              ),
            ),
          ),
        ),
      );
    }
    return Row(children: chips);
  }

  // ============ E. GRID LAYANAN ============
  Widget _buildServiceGrid() {
    List<MenuItem> items = services[_selectedCategory];

    // Hitung rasio agar tinggi tiap sel tetap 104 (tanpa overflow)
    double screenWidth = MediaQuery.of(context).size.width;
    double cellWidth = (screenWidth - 32) / 4;
    double ratio = cellWidth / 104;

    List<Widget> cells = [];
    for (int i = 0; i < items.length; i++) {
      cells.add(_buildServiceItem(items[i]));
    }

    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: ratio,
      children: cells,
    );
  }

  Widget _buildServiceItem(MenuItem item) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _showMessage('Layanan ${item.name} (simulasi)'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: item.color.withAlpha(35),
              shape: BoxShape.circle,
            ),
            child: Icon(item.icon, color: item.color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            item.name,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              height: 1.2,
              fontWeight: FontWeight.w500,
              color: textDark,
            ),
          ),
        ],
      ),
    );
  }

  // ============ F. BANNER PROMOSI ============
  Widget _buildBannerSection() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 130),
      child: Container(
        height: 140,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2BB5B0), blueColor, primaryPurple],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -30,
              top: -40,
              child: Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  color: Color(0x22FFFFFF),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              right: 50,
              bottom: -50,
              child: Container(
                width: 110,
                height: 110,
                decoration: const BoxDecoration(
                  color: Color(0x18FFFFFF),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const Positioned(
              right: 18,
              bottom: 14,
              child: Icon(Icons.card_giftcard, size: 76, color: Colors.white70),
            ),
            const Positioned(
              right: 90,
              top: 14,
              child: Icon(Icons.star, size: 22, color: Color(0xFFFFD84D)),
            ),
            const Positioned(
              left: 18,
              top: 16,
              bottom: 16,
              right: 110,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SERBA PROMO',
                    style: TextStyle(
                      color: Color(0xFFFFD84D),
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Saatnya Nikmati Promo Spesial Alann_pay',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============ G. BOTTOM NAVIGATION ============
  Widget _buildBottomNav() {
    double bottomInset = MediaQuery.of(context).padding.bottom;

    return SizedBox(
      height: 92 + bottomInset,
      child: Stack(
        children: [
          // Bar putih
          Positioned(
            left: 0,
            right: 0,
            top: 28,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(bottom: bottomInset),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1F000000),
                    blurRadius: 12,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  _buildNavItem(0, Icons.home_rounded, 'Home'),
                  _buildNavItem(
                      1, Icons.account_balance_wallet_outlined, 'Finance'),
                  // Slot tengah untuk label Pay
                  const Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Pay',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: primaryPurple,
                          ),
                        ),
                      ),
                    ),
                  ),
                  _buildNavItem(3, Icons.notifications_none_rounded, 'Inbox'),
                  _buildNavItem(4, Icons.person_outline_rounded, 'Profile'),
                ],
              ),
            ),
          ),
          // Tombol Pay (QRIS) menonjol ke atas
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Center(
              child: GestureDetector(
                onTap: () => _showMessage('Scan QRIS Alann_pay (simulasi)'),
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [blueColor, primaryPurple],
                    ),
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x4D5425C9),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.qr_code_2,
                      color: Colors.white, size: 32),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool active = _navIndex == index;
    Color color = active ? primaryPurple : textGrey;

    Widget iconWidget = Icon(icon, color: color, size: 26);

    // Badge angka 8 pada menu Inbox
    if (index == 3) {
      iconWidget = Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(icon, color: color, size: 26),
          Positioned(
            right: -6,
            top: -4,
            child: Container(
              width: 16,
              height: 16,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Text(
                '8',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            _navIndex = index;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Indikator menu aktif
            Container(
              width: 24,
              height: 3,
              decoration: BoxDecoration(
                color: active ? primaryPurple : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 6),
            iconWidget,
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
