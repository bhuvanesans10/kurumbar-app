import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kurumbar/backend/providers/app_locale_provider.dart';
import 'package:kurumbar/utils/design_system.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  int _selectedTab = 0; // 0 = Santhai, 1 = Jobs

  final List<Map<String, dynamic>> _products = [
    {
      'title': 'பாரம்பரிய கைத்தறி கம்பளி (Pure Wool Kambli)',
      'seller': 'எஸ். ராமர் (S. Ramar), சேலம்',
      'price': '₹2,800',
      'category': 'கைத்தறி (Handloom)',
      'rating': '4.9 ★',
      'image': 'https://images.unsplash.com/photo-1584100936595-c0654b55a2e2?auto=format&fit=crop&q=80&w=400',
    },
    {
      'title': 'நாட்டு செம்மறி ஆடுகள் (Semmari Breeding Pair)',
      'seller': 'கே. முத்தையன் (K. Muthaiah), திண்டுக்கல்',
      'price': '₹18,500',
      'category': 'கால்நடை (Livestock)',
      'rating': '5.0 ★',
      'image': 'https://images.unsplash.com/photo-1484557052118-f32bd25b45b5?auto=format&fit=crop&q=80&w=400',
    },
    {
      'title': 'ஆட்டு உரம் - இயற்கை உரம் (50kg)',
      'seller': 'எம். சண்முகம், தருமபுரி',
      'price': '₹450',
      'category': 'இயற்கை உரம் (Organic)',
      'rating': '4.8 ★',
      'image': 'https://images.unsplash.com/photo-1585314062340-f1a5a7c9328d?auto=format&fit=crop&q=80&w=400',
    },
  ];

  final List<Map<String, dynamic>> _jobs = [
    {
      'title': 'Accounts Executive & Tally',
      'company': 'Kurumbar Wool Cooperative Society',
      'location': 'சேலம் (Salem)',
      'salary': '₹20,000 - ₹25,000/மாதம்',
      'type': 'முழு நேரம் (Full-time)',
    },
    {
      'title': 'Handloom Weaving Supervisor',
      'company': 'Tamil Nadu Handloom Weaver Trust',
      'location': 'ஈரோடு (Erode)',
      'salary': '₹25,000 - ₹32,000/மாதம்',
      'type': 'முழு நேரம் (Full-time)',
    },
    {
      'title': 'Junior Mobile App Developer (Flutter)',
      'company': 'Tech Eesan Solutions',
      'location': 'Work From Home / Remote',
      'salary': '₹30,000 - ₹45,000/மாதம்',
      'type': 'ரிமோட் (Remote)',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isTa = context.watch<AppLocaleProvider>().locale.languageCode == 'ta';

    return Scaffold(
      backgroundColor: KurumbarDesignSystem.background,
      appBar: AppBar(
        title: Text(
          isTa ? 'குரும்பர் சந்தை & வேலைவாய்ப்பு' : 'Marketplace & Jobs',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: KurumbarDesignSystem.primaryDark,
          ),
        ),
      ),
      body: Column(
        children: [
          // Segmented Tabs
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Container(
              decoration: BoxDecoration(
                color: KurumbarDesignSystem.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: KurumbarDesignSystem.border),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _selectedTab == 0
                              ? KurumbarDesignSystem.primaryGreen
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            isTa ? '🛍️ சமுதாய சந்தை' : '🛍️ Marketplace',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: _selectedTab == 0
                                  ? Colors.white
                                  : KurumbarDesignSystem.textPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _selectedTab == 1
                              ? KurumbarDesignSystem.primaryGreen
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            isTa ? '💼 வேலைவாய்ப்பு' : '💼 Jobs Portal',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: _selectedTab == 1
                                  ? Colors.white
                                  : KurumbarDesignSystem.textPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          Expanded(
            child: _selectedTab == 0
                ? _buildMarketplaceList(isTa)
                : _buildJobsList(isTa),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketplaceList(bool isTa) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _products.length,
      separatorBuilder: (context, index) => const SizedBox(height: 14),
      itemBuilder: (context, idx) {
        final p = _products[idx];
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: KurumbarDesignSystem.border),
            boxShadow: KurumbarDesignSystem.cardShadow,
          ),
          child: Row(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(p['image']),
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
                      p['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                        color: KurumbarDesignSystem.primaryDark,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      p['seller'],
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: KurumbarDesignSystem.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          p['price'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: KurumbarDesignSystem.primaryGreen,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: KurumbarDesignSystem.accentYellow,
                            foregroundColor: KurumbarDesignSystem.primaryDark,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            minimumSize: const Size(40, 32),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isTa
                                      ? 'விற்பனையாளர் தொடர்பு எண்: +91 94432 12345'
                                      : 'Seller contact: +91 94432 12345',
                                ),
                                backgroundColor:
                                    KurumbarDesignSystem.primaryGreen,
                              ),
                            );
                          },
                          child: Text(
                            isTa ? 'வாங்க' : 'Buy Now',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildJobsList(bool isTa) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _jobs.length,
      separatorBuilder: (context, index) => const SizedBox(height: 14),
      itemBuilder: (context, idx) {
        final j = _jobs[idx];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
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
                    child: Text(
                      j['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: KurumbarDesignSystem.primaryDark,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: KurumbarDesignSystem.primaryGreenLight,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      j['type'],
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: KurumbarDesignSystem.primaryGreen,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                j['company'],
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: KurumbarDesignSystem.textPrimary,
                ),
              ),
              Text(
                'இடம்: ${j['location']}',
                style: const TextStyle(
                  fontSize: 12,
                  color: KurumbarDesignSystem.textSecondary,
                ),
              ),
              const Divider(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    j['salary'],
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: KurumbarDesignSystem.primaryGreen,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: KurumbarDesignSystem.primaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      minimumSize: const Size(40, 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isTa
                                ? 'விண்ணப்பம் பதிவு செய்யப்பட்டது'
                                : 'Application submitted',
                          ),
                          backgroundColor: KurumbarDesignSystem.primaryGreen,
                        ),
                      );
                    },
                    child: Text(
                      isTa ? 'விண்ணப்பிக்க' : 'Apply',
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
        );
      },
    );
  }
}
