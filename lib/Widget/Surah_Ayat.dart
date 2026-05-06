import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/Model%20Azqar/Model_Ayat.dart';

class SurahAyatWidget extends StatelessWidget {
  final List<AyahModel> ayahs;
  final int surahNumber;

  const SurahAyatWidget({
    super.key,
    required this.ayahs,
    required this.surahNumber,
  });

  static const String _basmala = 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ';

  bool get _showBasmala => surahNumber != 9;

  String _removeBasmala(String text) {
    String cleaned = text.trim();
    if (cleaned.isEmpty) return cleaned;

    final List<String> basmalaVariants = [
      'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
      'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
      'بِسْمِ اللهِ الرَّحْمَٰنِ الرَّحِيمِ',
      'بِسْمِ اللهِ الرَّحْمَنِ الرَّحِيمِ',
      'بسم الله الرحمن الرحيم',
      'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
      'بِسْمِ ٱللَّهِ ٱلرَّحْمَنِ ٱلرَّحِيمِ',
    ];

    for (final variant in basmalaVariants) {
      if (cleaned.startsWith(variant)) {
        return cleaned.substring(variant.length).trim();
      }
    }
    return cleaned;
  }

  List<AyahModel> _preparedAyahs() {
    if (ayahs.isEmpty) return [];
    if (surahNumber == 9) return ayahs;

    final List<AyahModel> result = [];
    for (int i = 0; i < ayahs.length; i++) {
      final ayah = ayahs[i];
      String text = ayah.text.trim();
      if (i == 0) text = _removeBasmala(text);
      if (text.trim().isEmpty) continue;
      result
          .add(AyahModel(numberInSurah: ayah.numberInSurah, text: text.trim()));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final preparedAyahs = _preparedAyahs();

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(18, 22, 18, 24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFCFBF7), Color(0xFFF7F1E3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE2D5B5), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_showBasmala) ...[
                Center(
                  child: Text(
                    _basmala,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.amiri(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF6E5630),
                      height: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
              ],
              RichText(
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                text: TextSpan(
                  style: GoogleFonts.amiri(
                    fontSize: 32,
                    height: 1.9,
                    color: const Color(0xFF1A1A1A),
                  ),
                  children: _buildAyahSpans(preparedAyahs),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<InlineSpan> _buildAyahSpans(List<AyahModel> list) {
    final List<InlineSpan> spans = [];

    for (final ayah in list) {
      spans.add(TextSpan(text: "${ayah.text} "));

      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 1),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF0e6058), width: 1),
            ),
            child: Center(
              child: Text(
                "${ayah.numberInSurah}",
                style: GoogleFonts.amiri(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0e6058),
                ),
              ),
            ),
          ),
        ),
      );

      spans.add(const TextSpan(text: " "));
    }

    return spans;
  }
}
