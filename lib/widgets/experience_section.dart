import 'package:flutter/material.dart';
import '../theme.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);

    return section(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: card(
          context: context,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(title: 'Pengalaman & Proyek'),
              const SizedBox(height: 18),
              _TimelineItem(
                title: 'Admin — PT. Farzana Berkat Mandiri',
                detail:
                    'Menangani administrasi perkantoran, entri data, pengarsipan dokumen, serta pelaporan operasional '
                    'menggunakan Microsoft Office (Excel, Word, PowerPoint) dengan ketelitian tinggi dan proses kerja yang terstruktur.',
                palette: palette,
              ),
              const SizedBox(height: 16),
              _TimelineItem(
                title: 'Flutter Mobile Developer',
                detail:
                    'Mengembangkan aplikasi mobile lintas platform menggunakan Flutter & Dart, '
                    'termasuk aplikasi absensi organisasi rumah sakit (absensi_app) dan aplikasi fitness (fitpedia_flutter) '
                    'dengan state management yang handal.',
                palette: palette,
              ),
              const SizedBox(height: 16),
              _TimelineItem(
                title: 'Web & Backend Developer (Laravel)',
                detail:
                    'Membangun aplikasi manajemen berbasis web menggunakan PHP dan framework Laravel, '
                    'seperti Sistem Kepegawaian yang mencakup modul registrasi karyawan, struktur divisi, '
                    'dan pelacakan pelatihan (training tracking).',
                palette: palette,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String title;
  final String detail;
  final AppColors palette;

  const _TimelineItem({
    required this.title,
    required this.detail,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: palette.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          detail,
          style: TextStyle(
            color: palette.textSecondary,
            fontSize: 13,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}