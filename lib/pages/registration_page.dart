import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kurumbar/backend/providers/app_locale_provider.dart';
import 'package:kurumbar/backend/providers/auth_provider.dart';
import 'package:kurumbar/utils/design_system.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  int _step = 0; // 0 = Personal, 1 = Roots, 2 = Contact
  final _nameTaCtrl = TextEditingController(text: 'சு. புவனேசன்');
  final _nameEnCtrl = TextEditingController(text: 'S. Bhuvanesan');
  final _phoneCtrl = TextEditingController(text: '9443212345');
  final _addressCtrl = TextEditingController(text: '24, பாரதி தெரு, அந்தியூர்');
  String _selectedDistrict = 'ஈரோடு (Erode)';
  String _selectedKulam = 'செல்ல குலம் (Chella Kulam)';
  String _selectedBlood = 'O+';

  final List<String> _districts = [
    'ஈரோடு (Erode)',
    'சேலம் (Salem)',
    'நாமக்கல் (Namakkal)',
    'கோயம்புத்தூர் (Coimbatore)',
    'திருப்பூர் (Tiruppur)',
    'தருமபுரி (Dharmapuri)',
    'கிருஷ்ணகிரி (Krishnagiri)',
    'திண்டுக்கல் (Dindigul)',
    'மதுரை (Madurai)',
    'திருச்சி (Tiruchirappalli)',
    'சென்னை (Chennai)',
    'வேலூர் (Vellore)',
  ];

  final List<String> _kulams = [
    'செல்ல குலம் (Chella Kulam)',
    'மன்னாடியார் குலம் (Mannadiyar)',
    'காடை குலம் (Kaadai Kulam)',
    'பெரியான குலம் (Periyana Kulam)',
    'கோனார்குலம் (Konar Kulam)',
    'மல்லிகுலம் (Malli Kulam)',
    'பூசாரிகுலம் (Poosari Kulam)',
    'காவல்குலம் (Kaaval Kulam)',
    'ஆரியகுலம் (Aariya Kulam)',
  ];

  @override
  void dispose() {
    _nameTaCtrl.dispose();
    _nameEnCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  void _finishRegistration(bool isTa) {
    context.read<AuthProvider>().registerMember({
      'nameTa': _nameTaCtrl.text.trim(),
      'nameEn': _nameEnCtrl.text.trim(),
      'phone': '+91 ${_phoneCtrl.text.trim()}',
      'district': _selectedDistrict,
      'kulam': _selectedKulam,
      'bloodGroup': _selectedBlood,
      'address': _addressCtrl.text.trim(),
      'id': 'KB-2026-${1000 + DateTime.now().millisecond}',
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isTa
              ? 'உறுப்பினர் பதிவு வெற்றிகரமாக முடிந்தது! டிஜிட்டல் அட்டை உருவாக்கப்பட்டது.'
              : 'Registration completed! Digital ID Card generated.',
        ),
        backgroundColor: KurumbarDesignSystem.primaryGreen,
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isTa = context.watch<AppLocaleProvider>().locale.languageCode == 'ta';

    return Scaffold(
      backgroundColor: KurumbarDesignSystem.background,
      appBar: AppBar(
        title: Text(
          isTa ? 'உறுப்பினர் புதிய பதிவு' : 'New Member Registration',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: KurumbarDesignSystem.primaryDark,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Indicator
            Row(
              children: [
                _stepPill('1', isTa ? 'தனிநபர்' : 'Personal', 0),
                _stepDivider(),
                _stepPill('2', isTa ? 'சமூகம்' : 'Roots', 1),
                _stepDivider(),
                _stepPill('3', isTa ? 'முகவரி' : 'Contact', 2),
              ],
            ),
            const SizedBox(height: 24),

            // Form Content based on Step
            if (_step == 0) ...[
              _buildField('பெயர் (தமிழ்)', _nameTaCtrl, 'எ.கா: சு. புவனேசன்'),
              _buildField('Name (English)', _nameEnCtrl, 'e.g: S. Bhuvanesan'),
              _buildField(
                'தொலைபேசி எண்',
                _phoneCtrl,
                '9443212345',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              const Text(
                'இரத்த வகை (Blood Group)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: KurumbarDesignSystem.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                initialValue: _selectedBlood,
                decoration: _inputDecor(),
                items: ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']
                    .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedBlood = val!),
              ),
            ] else if (_step == 1) ...[
              const Text(
                'குலம் (Kulam / Clan)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: KurumbarDesignSystem.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                initialValue: _selectedKulam,
                decoration: _inputDecor(),
                items: _kulams
                    .map(
                      (k) => DropdownMenuItem(
                        value: k,
                        child: Text(k, style: const TextStyle(fontSize: 13)),
                      ),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _selectedKulam = val!),
              ),
              const SizedBox(height: 16),
              const Text(
                'சொந்த மாவட்டம் (Native District)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: KurumbarDesignSystem.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                initialValue: _selectedDistrict,
                decoration: _inputDecor(),
                items: _districts
                    .map(
                      (d) => DropdownMenuItem(
                        value: d,
                        child: Text(d, style: const TextStyle(fontSize: 13)),
                      ),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _selectedDistrict = val!),
              ),
            ] else ...[
              _buildField(
                'முழு முகவரி (Residential Address)',
                _addressCtrl,
                'கதவு எண், தெரு, கிராமம், வட்டம், அஞ்சல் குறியீடு',
                maxLines: 3,
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: KurumbarDesignSystem.primaryGreenLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: KurumbarDesignSystem.primaryGreen.withValues(
                      alpha: 0.3,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: KurumbarDesignSystem.primaryGreen,
                      size: 24,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        isTa
                            ? 'அனைத்து விவரங்களும் தமிழ்நாடு குறும்பர் சங்க விதிமுறைகளின்படி சரிபார்க்கப்படும்.'
                            : 'Details verified per TN Kurumbar Community bylaws.',
                        style: const TextStyle(
                          fontSize: 12,
                          color: KurumbarDesignSystem.primaryDark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 32),

            // Stepper Navigation
            Row(
              children: [
                if (_step > 0)
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => setState(() => _step--),
                      child: Text(isTa ? 'முந்தைய படி' : 'Previous'),
                    ),
                  ),
                if (_step > 0) const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: KurumbarDesignSystem.primaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_step < 2) {
                        setState(() => _step++);
                      } else {
                        _finishRegistration(isTa);
                      }
                    },
                    child: Text(
                      _step == 2
                          ? (isTa ? 'பதிவை முடிக்க' : 'Complete & Generate ID')
                          : (isTa ? 'அடுத்த படி' : 'Next Step'),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _stepPill(String num, String title, int s) {
    final active = _step == s;
    final done = _step > s;
    return Row(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: done
              ? KurumbarDesignSystem.primaryGreen
              : (active
                    ? KurumbarDesignSystem.accentYellow
                    : Colors.grey.shade300),
          child: Text(
            done ? '✓' : num,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: done ? Colors.white : KurumbarDesignSystem.primaryDark,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            fontWeight: active ? FontWeight.bold : FontWeight.w500,
            color: KurumbarDesignSystem.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _stepDivider() {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        color: Colors.grey.shade300,
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController ctrl,
    String hint, {
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: KurumbarDesignSystem.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: ctrl,
            keyboardType: keyboardType,
            maxLines: maxLines,
            decoration: _inputDecor(hint: hint),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecor({String? hint}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: KurumbarDesignSystem.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: KurumbarDesignSystem.primaryGreen,
          width: 2,
        ),
      ),
    );
  }
}
