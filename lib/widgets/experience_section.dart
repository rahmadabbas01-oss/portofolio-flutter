import 'package:flutter/material.dart';
import '../theme.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return section(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: card(
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(icon: Icons.work_outline, title: 'Pengalaman & Proyek'),
              SizedBox(height: 18),
              _TimelineItem(
                title: 'Flutter Mobile Developer',
                detail:
                    'Mengembangkan aplikasi mobile lintas platform menggunakan Flutter & Dart, '
                    'termasuk aplikasi absensi organisasi rumah sakit (absensi_app) dan aplikasi fitness (fitpedia_flutter) '
                    'dengan state management yang handal.',
              ),
              SizedBox(height: 16),
              _TimelineItem(
                title: 'Web & Backend Developer (Laravel)',
                detail:
                    'Membangun aplikasi manajemen berbasis web menggunakan PHP dan framework Laravel, '
                    'seperti Sistem Kepegawaian yang mencakup modul registrasi karyawan, struktur divisi, '
                    'dan pelacakan pelatihan (training tracking).',
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

  const _TimelineItem({required this.title, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          detail,
          style: const TextStyle(
            color: muted,
            fontSize: 13,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}