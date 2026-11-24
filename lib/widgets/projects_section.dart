import 'package:flutter/material.dart';
import '../theme.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);

    return section(
      context: context,
      background: palette.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Proyek Pilihan',
          ),
          const SizedBox(height: 8),
          Text(
            'Beberapa proyek yang pernah saya kerjakan',
            style: TextStyle(color: palette.textSecondary),
          ),
          const SizedBox(height: 22),
          LayoutBuilder(
            builder: (context, c) {
              final count = c.maxWidth > 900
                  ? 3
                  : c.maxWidth > 600
                      ? 2
                      : 1;

              final projects = [
                (
                  'Fitpedia',
                  'Aplikasi kesehatan dan kebugaran dengan Flutter, fitur AI, tracking, dan personalisasi.',
                  'assets/projects/fitpedia.jpg',
                  ['Flutter', 'Dart', 'SQLite'],
                ),
                (
                  'Sistem Kepegawaian',
                  'Aplikasi web untuk pengelolaan data pegawai dan administrasi.',
                  'assets/projects/kepegawaian.jpeg',
                  ['Laravel', 'MySQL', 'Bootstrap'],
                ),
                (
                  'Absensi App',
                  'Aplikasi untuk mencatat kehadiran dengan dukungan face recognition.',
                  'assets/projects/absensi.jpeg',
                  ['Flutter', 'Dart', 'Firebase'],
                ),
              ];

              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: projects
                    .map(
                      (p) => SizedBox(
                        width: (c.maxWidth - (count - 1) * 16) / count,
                        child: card(
                          context: context,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: AspectRatio(
                                  aspectRatio: 16 / 10,
                                  child: Image.asset(
                                    p.$3,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        Container(
                                      color: palette.cardBg,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.broken_image_outlined,
                                              color: palette.textSecondary,
                                              size: 36,
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Gambar belum tersedia',
                                              style: TextStyle(
                                                color: palette.textSecondary,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                p.$1,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: palette.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                p.$2,
                                style: TextStyle(
                                  color: palette.textSecondary,
                                  height: 1.6,
                                ),
                              ),
                              const SizedBox(height: 14),
                              // Tag teknologi dengan background transparan & garis tepi (frame) warna Gold
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: p.$4.map((s) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: gold.withValues(alpha: 0.45),
                                      ),
                                    ),
                                    child: Text(
                                      s,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: palette.textPrimary,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}