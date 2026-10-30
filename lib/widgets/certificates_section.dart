import 'package:flutter/material.dart';
import '../theme.dart';

class CertificatesSection extends StatelessWidget {
  const CertificatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return section(
      background: panel,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            icon: Icons.workspace_premium_outlined,
            title: 'Sertifikat',
          ),
          const SizedBox(height: 8),
          const Text(
            'Sertifikat pelatihan dan pengembangan kemampuan saya.',
            style: TextStyle(color: muted, height: 1.6),
          ),
          const SizedBox(height: 22),
          LayoutBuilder(
            builder: (context, c) {
              final count = c.maxWidth > 800 ? 2 : 1;

              final certificates = [
                (
                  'Mobile Programming',
                  'SCREENESIA',
                  '12 September – 11 Oktober 2026',
                  'assets/sertifikat/mobile_programming.jpg',
                ),
                (
                  'Web Programming',
                  'SCREENESIA',
                  '25 Juli – 6 September 2026',
                  'assets/sertifikat/web_programming.jpeg',
                ),
              ];

              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: certificates.map((certificate) {
                  final itemWidth = c.maxWidth > 0
                      ? (c.maxWidth - (count - 1) * 16) / count
                      : c.maxWidth;

                  return SizedBox(
                    width: itemWidth,
                    child: card(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: AspectRatio(
                              aspectRatio: 16 / 10,
                              child: Image.asset(
                                certificate.$4,
                                width: double.infinity,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: panel2,
                                  child: const Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.broken_image_outlined, color: muted, size: 36),
                                        SizedBox(height: 8),
                                        Text('Sertifikat belum tersedia', style: TextStyle(color: muted, fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            certificate.$1,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            certificate.$2,
                            style: const TextStyle(
                              color: gold,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            certificate.$3,
                            style: const TextStyle(
                              color: muted,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}