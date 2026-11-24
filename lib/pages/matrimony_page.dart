import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kurumbar/backend/providers/app_locale_provider.dart';
import 'package:kurumbar/utils/design_system.dart';

class MatrimonyPage extends StatefulWidget {
  const MatrimonyPage({super.key});

  @override
  State<MatrimonyPage> createState() => _MatrimonyPageState();
}

class _MatrimonyPageState extends State<MatrimonyPage> {
  int _selectedTab = 0; // 0 = Grooms, 1 = Brides

  final List<Map<String, dynamic>> _grooms = [
    {
      'id': 'KM-M-101',
      'name': 'கே. கார்த்திகேயன் (K. Karthikeyan)',
      'age': 28,
      'height': "5'9\"",
      'education': 'B.E (Computer Science)',
      'profession': 'Senior Software Engineer, Chennai',
      'kulam': 'செல்ல குலம் (Chella Kulam)',
      'district': 'ஈரோடு (Erode)',
      'salary': '₹18 LPA',
      'image': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&q=80&w=400',
    },
    {
      'id': 'KM-M-102',
      'name': 'எஸ். பிரவீன் குமார் (S. Praveen Kumar)',
      'age': 30,
      'height': "5'11\"",
      'education': 'M.B.A (Finance)',
      'profession': 'Branch Manager, SBI Coimbatore',
      'kulam': 'மன்னாடியார் குலம் (Mannadiyar)',
      'district': 'கோயம்புத்தூர் (Coimbatore)',
      'salary': '₹14 LPA',
      'image': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&q=80&w=400',
    },
  ];

  final List<Map<String, dynamic>> _brides = [
    {
      'id': 'KM-F-201',
      'name': 'ஆர். பிரியதர்ஷினி (R. Priyadharshini)',
      'age': 25,
      'height': "5'4\"",
      'education': 'M.Sc., B.Ed (Mathematics)',
      'profession': 'Govt High School Teacher, Salem',
      'kulam': 'காடை குலம் (Kaadai Kulam)',
      'district': 'சேலம் (Salem)',
      'salary': 'Govt Scale',
      'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=400',
    },
    {
      'id': 'KM-F-202',
      'name': 'எம். சௌந்தர்யா (M. Soundarya)',
      'age': 26,
      'height': "5'5\"",
      'education': 'B.Tech (IT)',
      'profession': 'Data Analyst, Bengaluru',
      'kulam': 'பெரியான குலம் (Periyana Kulam)',
      'district': 'தருமபுரி (Dharmapuri)',
      'salary': '₹12 LPA',
      'image': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&q=80&w=400',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isTa = context.watch<AppLocaleProvider>().locale.languageCode == 'ta';
    final currentList = _selectedTab == 0 ? _grooms : _brides;

    return Scaffold(
      backgroundColor: KurumbarDesignSystem.background,
      appBar: AppBar(
        title: Text(
          isTa ? 'குரும்பர் வரன் தேடல்' : 'Kurumbar Matrimony',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: KurumbarDesignSystem.primaryDark,
          ),
        ),
      ),
      body: Column(
        children: [
          // Segmented Tab
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
                            isTa ? '👨 மணமகன் (Grooms)' : '👨 Grooms',
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
                            isTa ? '👩 மணமகள் (Brides)' : '👩 Brides',
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

          // Profiles List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: currentList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, idx) {
                final p = currentList[idx];
                return Container(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 80,
                            height: 95,
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        p['name'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color:
                                              KurumbarDesignSystem.primaryDark,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade50,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Text(
                                        'சரிபார்க்கப்பட்டது',
                                        style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${p['age']} வயது • ${p['height']}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: KurumbarDesignSystem.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  p['education'],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: KurumbarDesignSystem.textPrimary,
                                  ),
                                ),
                                Text(
                                  p['profession'],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: KurumbarDesignSystem.primaryGreen,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'குலம்: ${p['kulam']}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: KurumbarDesignSystem.textPrimary,
                                ),
                              ),
                              Text(
                                'மாவட்டம்: ${p['district']}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: KurumbarDesignSystem.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  KurumbarDesignSystem.primaryGreen,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    isTa
                                        ? 'வரன் விபரம் அனுப்பப்பட்டது'
                                        : 'Interest expressed successfully',
                                  ),
                                  backgroundColor:
                                      KurumbarDesignSystem.primaryGreen,
                                ),
                              );
                            },
                            child: Text(
                              isTa ? 'தொடர்பு கொள்ள' : 'Contact Profile',
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
            ),
          ),
        ],
      ),
    );
  }
}
