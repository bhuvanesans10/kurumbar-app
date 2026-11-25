import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kurumbar/backend/providers/app_locale_provider.dart';
import 'package:kurumbar/backend/providers/auth_provider.dart';
import 'package:kurumbar/pages/digital_id_page.dart';
import 'package:kurumbar/pages/login_page.dart';
import 'package:kurumbar/pages/matrimony_page.dart';
import 'package:kurumbar/pages/marketplace_page.dart';
import 'package:kurumbar/pages/registration_page.dart';
import 'package:kurumbar/utils/design_system.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    // If unauthenticated, show the Login screen
    if (!auth.isAuthenticated) {
      return LoginPage(
        onRegisterTapped: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const RegistrationPage()));
        },
      );
    }

    final isTa = context.watch<AppLocaleProvider>().locale.languageCode == 'ta';

    final pages = [
      _buildHomeDashboard(context, isTa),
      const DigitalIdPage(),
      const MatrimonyPage(),
      const MarketplacePage(),
      _buildProfilePage(context, isTa),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: KurumbarDesignSystem.primaryGreen,
          unselectedItemColor: KurumbarDesignSystem.textSecondary,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 10.5,
          ),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: isTa ? 'முகப்பு' : 'Home',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.badge_outlined),
              activeIcon: const Icon(Icons.badge),
              label: isTa ? 'அட்டை' : 'ID Card',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.favorite_outline),
              activeIcon: const Icon(Icons.favorite),
              label: isTa ? 'திருமணம்' : 'Matrimony',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.storefront_outlined),
              activeIcon: const Icon(Icons.storefront),
              label: isTa ? 'சந்தை' : 'Market',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              activeIcon: const Icon(Icons.person),
              label: isTa ? 'சுயவிவரம்' : 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeDashboard(BuildContext context, bool isTa) {
    final member = context.watch<AuthProvider>().member;

    return Scaffold(
      backgroundColor: KurumbarDesignSystem.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isTa ? 'குறும்பர் சமுதாயம்' : 'Kurumbar Community',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: KurumbarDesignSystem.primaryDark,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text(
                    'www.kurumbar.org',
                    style: TextStyle(
                      fontSize: 11,
                      color: KurumbarDesignSystem.textSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ActionChip(
              avatar: const Icon(
                Icons.language,
                size: 14,
                color: KurumbarDesignSystem.primaryGreen,
              ),
              label: Text(
                isTa ? 'English' : 'தமிழ்',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: KurumbarDesignSystem.primaryDark,
                ),
              ),
              backgroundColor: KurumbarDesignSystem.primaryGreenLight,
              side: BorderSide(
                color: KurumbarDesignSystem.primaryGreen.withValues(alpha: 0.2),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () => context.read<AppLocaleProvider>().toggleLocale(),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: KurumbarDesignSystem.primaryDark,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isTa
                        ? 'புதிய அறிவிப்புகள் ஏதுமில்லை'
                        : 'No new notifications',
                  ),
                  backgroundColor: KurumbarDesignSystem.primaryGreen,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome & Digital ID Quick Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    KurumbarDesignSystem.primaryDark,
                    KurumbarDesignSystem.primaryGreen,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                boxShadow: KurumbarDesignSystem.floatingShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: KurumbarDesignSystem.accentYellow,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              isTa ? 'சரிபார்க்கப்பட்டது' : 'VERIFIED MEMBER',
                              style: const TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w900,
                                color: KurumbarDesignSystem.primaryDark,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            member['id'],
                            style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.verified,
                        color: KurumbarDesignSystem.accentYellow,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Container(
                        width: 56,
                        height: 64,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white, width: 2),
                          image: DecorationImage(
                            image: member['avatarUrl'].toString().startsWith('assets/')
                                ? AssetImage(member['avatarUrl']) as ImageProvider
                                : NetworkImage(member['avatarUrl']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isTa ? member['nameTa'] : member['nameEn'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'குலம்: ${member['kulam']}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'மாவட்டம்: ${member['district']}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                        child: Text(
                          'வாழ்நாள் உறுப்பினர் (Lifetime)',
                          style: TextStyle(
                            color: KurumbarDesignSystem.accentYellow,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: KurumbarDesignSystem.primaryDark,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          minimumSize: const Size(40, 32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => setState(
                          () => _currentIndex = 1,
                        ), // switch to Digital ID Tab
                        child: Text(
                          isTa ? 'முழு அட்டை' : 'View Full ID',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Community Impact Stats
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: KurumbarDesignSystem.border),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _statItem('38', isTa ? 'மாவட்டங்கள்' : 'Districts'),
                  _vertDivider(),
                  _statItem('12,450+', isTa ? 'உறுப்பினர்கள்' : 'Members'),
                  _vertDivider(),
                  _statItem('100%', isTa ? 'இலவச சேவை' : 'Free Service'),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // Quick Service Grid Section Title
            Text(
              isTa ? 'சமுதாய முக்கிய சேவைகள்' : 'Community Services',
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: KurumbarDesignSystem.textPrimary,
              ),
            ),
            const SizedBox(height: 12),

            // 8 Services Grid
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 14,
              childAspectRatio: 0.78,
              children: [
                _serviceTile(
                  icon: Icons.badge_outlined,
                  color: const Color(0xFF15803D),
                  label: isTa ? 'டிஜிட்டல்\nஅட்டை' : 'Digital\nID Card',
                  onTap: () => setState(() => _currentIndex = 1),
                ),
                _serviceTile(
                  icon: Icons.favorite_outline,
                  color: const Color(0xFFE11D48),
                  label: isTa ? 'குறும்பர்\nவரன்' : 'Kurumbar\nMatrimony',
                  onTap: () => setState(() => _currentIndex = 2),
                ),
                _serviceTile(
                  icon: Icons.storefront_outlined,
                  color: const Color(0xFFD97706),
                  label: isTa ? 'சமுதாய\nசந்தை' : 'Community\nMarket',
                  onTap: () => setState(() => _currentIndex = 3),
                ),
                _serviceTile(
                  icon: Icons.work_outline,
                  color: const Color(0xFF2563EB),
                  label: isTa ? 'வேலை\nவாய்ப்பு' : 'Jobs\nPortal',
                  onTap: () => setState(() => _currentIndex = 3),
                ),
                _serviceTile(
                  icon: Icons.how_to_reg_outlined,
                  color: const Color(0xFF0D9488),
                  label: isTa ? 'உறுப்பினர்\nபதிவு' : 'Member\nRegister',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const RegistrationPage(),
                      ),
                    );
                  },
                ),
                _serviceTile(
                  icon: Icons.qr_code_scanner,
                  color: const Color(0xFF7C3AED),
                  label: isTa ? 'அட்டை\nசரிபார்ப்பு' : 'Verify\nID Card',
                  onTap: () => _showVerifyDialog(context, isTa),
                ),
                _serviceTile(
                  icon: Icons.newspaper_outlined,
                  color: const Color(0xFF0284C7),
                  label: isTa ? 'செய்திகள்\nநிகழ்வுகள்' : 'News &\nEvents',
                  onTap: () => _showNewsDialog(context, isTa),
                ),
                _serviceTile(
                  icon: Icons.phone_in_talk_outlined,
                  color: const Color(0xFF16A34A),
                  label: isTa ? 'சங்க\nஉதவி' : 'Sangam\nHelpline',
                  onTap: () => _showContactDialog(context, isTa),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // Latest News Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: KurumbarDesignSystem.border),
                boxShadow: KurumbarDesignSystem.cardShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.campaign,
                              color: KurumbarDesignSystem.primaryGreen,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                isTa
                                    ? 'சமீபத்திய அறிவிப்புகள்'
                                    : 'Latest Announcements',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: KurumbarDesignSystem.primaryDark,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isTa ? 'அனைத்தும் பார்க்க' : 'View All',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: KurumbarDesignSystem.primaryGreen,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  _newsItem(
                    title: 'தமிழ்நாடு குறும்பர் சமுதாய மாநில மாநாடு - 2026',
                    date: '28 நவம்பர் 2026 • சேலம்',
                    tag: 'மாநாடு',
                  ),
                  const SizedBox(height: 10),
                  _newsItem(
                    title:
                        'பாரம்பரிய கைத்தறி கம்பளி நெசவாளர்களுக்கு அரசு மானியம்',
                    date: '22 நவம்பர் 2026 • தமிழ்நாடு அரசு',
                    tag: 'நலத்திட்டம்',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePage(BuildContext context, bool isTa) {
    final member = context.watch<AuthProvider>().member;

    return Scaffold(
      backgroundColor: KurumbarDesignSystem.background,
      appBar: AppBar(
        title: Text(
          isTa ? 'உறுப்பினர் சுயவிவரம்' : 'Member Profile',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: KurumbarDesignSystem.primaryDark,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 46,
                    backgroundImage: member['avatarUrl'].toString().startsWith('assets/')
                        ? AssetImage(member['avatarUrl']) as ImageProvider
                        : NetworkImage(member['avatarUrl']),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              isTa ? member['nameTa'] : member['nameEn'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: KurumbarDesignSystem.primaryDark,
              ),
            ),
            Text(
              member['id'],
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: KurumbarDesignSystem.primaryGreen,
              ),
            ),
            const SizedBox(height: 24),

            // Profile info cards
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: KurumbarDesignSystem.border),
              ),
              child: Column(
                children: [
                  _profileListTile(
                    Icons.phone_outlined,
                    isTa ? 'தொலைபேசி' : 'Phone',
                    member['phone'],
                  ),
                  const Divider(height: 1),
                  _profileListTile(
                    Icons.groups_outlined,
                    isTa ? 'குலம்' : 'Kulam',
                    member['kulam'],
                  ),
                  const Divider(height: 1),
                  _profileListTile(
                    Icons.location_on_outlined,
                    isTa ? 'மாவட்டம்' : 'District',
                    member['district'],
                  ),
                  const Divider(height: 1),
                  _profileListTile(
                    Icons.bloodtype_outlined,
                    isTa ? 'இரத்த வகை' : 'Blood Group',
                    member['bloodGroup'],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Sign Out Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.logout, color: Colors.red),
                label: Text(
                  isTa ? 'வெளியேறுக (Sign Out)' : 'Sign Out',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  context.read<AuthProvider>().logout();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _serviceTile({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withValues(alpha: 0.2)),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: KurumbarDesignSystem.textPrimary,
              height: 1.2,
            ),
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: KurumbarDesignSystem.primaryGreen,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: KurumbarDesignSystem.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _vertDivider() {
    return Container(width: 1, height: 28, color: Colors.grey.shade200);
  }

  Widget _newsItem({
    required String title,
    required String date,
    required String tag,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: KurumbarDesignSystem.primaryGreenLight,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            tag,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: KurumbarDesignSystem.primaryGreen,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: KurumbarDesignSystem.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 10.5,
                  color: KurumbarDesignSystem.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _profileListTile(IconData icon, String title, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: KurumbarDesignSystem.primaryGreen),
          const SizedBox(width: 14),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: KurumbarDesignSystem.textSecondary,
            ),
          ),
          const Spacer(),
          Text(
            val,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: KurumbarDesignSystem.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  void _showVerifyDialog(BuildContext context, bool isTa) {
    final ctrl = TextEditingController(text: 'KB-2026-8942');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          isTa ? 'அட்டை சரிபார்ப்பு' : 'Verify Member ID',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isTa
                  ? 'சரிபார்க்க வேண்டிய உறுப்பினர் எண்ணை உள்ளிடவும்:'
                  : 'Enter Member ID to verify:',
            ),
            const SizedBox(height: 12),
            TextField(
              controller: ctrl,
              decoration: InputDecoration(
                filled: true,
                fillColor: KurumbarDesignSystem.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(isTa ? 'மூடுக' : 'Close'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: KurumbarDesignSystem.primaryGreen,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isTa
                        ? 'உறுப்பினர் KB-2026-8942: அதிகாரப்பூர்வமாக சரிபார்க்கப்பட்டது!'
                        : 'Member KB-2026-8942: Officially Verified!',
                  ),
                  backgroundColor: KurumbarDesignSystem.primaryGreen,
                ),
              );
            },
            child: Text(
              isTa ? 'சரிபார்க்க' : 'Verify',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showNewsDialog(BuildContext context, bool isTa) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isTa
                  ? 'செய்திகள் & சமுதாய அறிவிப்புகள்'
                  : 'Community Announcements',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 20),
            _newsItem(
              title: 'மாநில மாநாடு 2026 - சேலம்',
              date: '28 நவம்பர் 2026',
              tag: 'மாநாடு',
            ),
            const SizedBox(height: 12),
            _newsItem(
              title: 'கைத்தறி கம்பளி நெசவாளர் நல நிதி',
              date: '22 நவம்பர் 2026',
              tag: 'நலத்திட்டம்',
            ),
            const SizedBox(height: 12),
            _newsItem(
              title: 'இளைஞர் கல்வி உதவித்தொகை விண்ணப்பம்',
              date: '15 நவம்பர் 2026',
              tag: 'கல்வி',
            ),
          ],
        ),
      ),
    );
  }

  void _showContactDialog(BuildContext context, bool isTa) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isTa
                  ? 'சங்க உதவி மையம் & தொடர்பு'
                  : 'Sangam Headquarters Helpline',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 20),
            ListTile(
              leading: const Icon(
                Icons.phone,
                color: KurumbarDesignSystem.primaryGreen,
              ),
              title: const Text('+91 94432 12345'),
              subtitle: Text(
                isTa ? 'மாநில தலைமை அலுவலகம்' : 'State Headquarters',
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.email,
                color: KurumbarDesignSystem.primaryGreen,
              ),
              title: const Text('support@kurumbar.org'),
              subtitle: const Text('www.kurumbar.org'),
            ),
          ],
        ),
      ),
    );
  }
}
