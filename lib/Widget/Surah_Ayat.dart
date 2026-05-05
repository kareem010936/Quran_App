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
    final cleaned = text.trim();

    const variants = [
      'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
      'بسم الله الرحمن الرحيم',
      'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
      'بسم الله الرحمٰن الرحيم',
    ];

    for (final v in variants) {
      if (cleaned.startsWith(v)) {
        return cleaned.substring(v.length).trim();
      }
    }

    return cleaned;
  }

  List<AyahModel> _preparedAyahs() {
    if (ayahs.isEmpty) return [];

    if (!_showBasmala) {
      return ayahs;
    }

    final List<AyahModel> result = [];

    for (int i = 0; i < ayahs.length; i++) {
      final ayah = ayahs[i];

      final text = i == 0 ? _removeBasmala(ayah.text) : ayah.text.trim();

      if (text.isEmpty) continue;

      result.add(
        AyahModel(
          numberInSurah: ayah.numberInSurah,
          text: text,
        ),
      );
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
            colors: [
              Color(0xFFFCFBF7),
              Color(0xFFF7F1E3),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color(0xFFE2D5B5),
            width: 1.2,
          ),
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
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1.2,
                        color: const Color(0xFFBFAE86),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        _basmala,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.amiri(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF6E5630),
                          height: 1.8,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1.2,
                        color: const Color(0xFFBFAE86),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
              ],
              RichText(
                textAlign: TextAlign.justify,
                textDirection: TextDirection.rtl,
                text: TextSpan(
                  style: GoogleFonts.amiri(
                    fontSize: 30,
                    height: 2.0,
                    color: const Color(0xFF1A1A1A),
                    fontWeight: FontWeight.w500,
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
      spans.add(
        TextSpan(
          text: "${ayah.text} ",
        ),
      );

      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF0e6058),
                width: 1.2,
              ),
            ),
            child: Center(
              child: Text(
                "${ayah.numberInSurah}",
                style: GoogleFonts.amiri(
                  fontSize: 12,
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
