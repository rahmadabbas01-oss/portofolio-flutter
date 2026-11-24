import 'package:flutter/material.dart';
import '../theme.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);

    final profile = card(
      context: context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Tentang Saya'),
          const SizedBox(height: 14),
          Text(
            'Lulusan S1 Sistem Informasi dengan pengalaman 5 tahun sebagai Admin. '
            'Menguasai administrasi perkantoran, entri data, pengarsipan, serta Microsoft Office (Excel, Word, PowerPoint), '
            'didukung keahlian teknis dalam pengembangan web (PHP/Laravel) dan aplikasi mobile (Flutter). '
            'Pribadi yang komunikatif dan teliti, antusias berkolaborasi menghadirkan solusi digital yang fungsional dan berdampak.',
            style: TextStyle(
              color: palette.textSecondary,
              height: 1.8,
            ),
          ),
          const SizedBox(height: 20),
          const Wrap(
            spacing: 10,
            runSpacing: 10,
          ),
        ],
      ),
    );

    return section(
      context: context,
      background: palette.surface,
      child: profile,
    );
  }
}

// ignore: unused_element
class _Feature extends StatelessWidget {
  final IconData icon;
  final String title;
  const _Feature({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: palette.cardBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: palette.borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: palette.accent, size: 16),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: palette.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}