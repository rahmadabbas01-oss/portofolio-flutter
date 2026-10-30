import 'package:flutter/material.dart';
import '../theme.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = card(
      const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(icon: Icons.person_outline, title: 'Tentang Saya'),
          SizedBox(height: 14),
          Text(
            'Saya senang mempelajari teknologi baru, memecahkan masalah, dan mengubah ide menjadi produk digital. '
            'Saya percaya aplikasi yang baik harus fungsional, nyaman digunakan, dan memberi dampak nyata.',
            style: TextStyle(color: muted, height: 1.8),
          ),
          SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _Feature(icon: Icons.lightbulb_outline, title: 'Problem Solver'),
              _Feature(icon: Icons.groups_outlined, title: 'Team Player'),
              _Feature(icon: Icons.school_outlined, title: 'Continuous Learner'),
            ],
          ),
        ],
      ),
    );

    return section(
      background: panel,
      child: profile,
    );
  }
}

class _Feature extends StatelessWidget {
  final IconData icon;
  final String title;
  const _Feature({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: panel2,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: gold.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: gold, size: 16),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white70)),
        ],
      ),
    );
  }
}