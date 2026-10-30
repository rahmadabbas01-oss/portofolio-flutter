import 'package:flutter/material.dart';
import '../theme.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            icon: Icons.code_rounded,
            title: 'Skills & Teknologi',
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, c) {
              final count = c.maxWidth > 900
                  ? 3
                  : c.maxWidth > 580
                      ? 2
                      : 1;

              final groups = [
                (
                  'Mobile Development',
                  Icons.smartphone_rounded,
                  [
                    ('Flutter', 'assets/icons/flutter.png'),
                    ('Dart', 'assets/icons/dart.png'),
                    ('SQLite', 'assets/icons/sqlite.png'),
                  ]
                ),
                (
                  'Web Development',
                  Icons.web_rounded,
                  [
                    ('Laravel', 'assets/icons/laravel.png'),
                    ('PHP', 'assets/icons/php.png'),
                    ('MySQL', 'assets/icons/mysql.png'),
                    ('Bootstrap', 'assets/icons/bootstrap.png'),
                  ]
                ),
                (
                  'Tools & Others',
                  Icons.terminal_rounded,
                  [
                    ('Git', 'assets/icons/git.png'),
                    ('Github', 'assets/icons/github.png'),
                    ('Android Studio', 'assets/icons/android_studio.png'),
                    ('VS Code', 'assets/icons/vscode.png'),
                    
                  ]
                ),
              ];

              return Wrap(
                spacing: 14,
                runSpacing: 14,
                children: groups
                    .map(
                      (g) => SizedBox(
                        width: (c.maxWidth - (count - 1) * 14) / count,
                        child: _skillCard(
                          title: g.$1,
                          icon: g.$2,
                          skills: g.$3,
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

  Widget _skillCard({
    required String title,
    required IconData icon,
    required List<(String, String)> skills,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: panel2,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: gold.withValues(alpha: 0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: gold.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: gold.withValues(alpha: 0.3)),
                ),
                child: Icon(icon, color: gold, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((skill) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.transparent, // Background dibuat transparan
                  borderRadius: BorderRadius.circular(10),
                  // Dilingkari border berwarna gold dengan transparan tipis mirip gaya Team Player
                  border: Border.all(color: gold.withValues(alpha: 0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      skill.$2,
                      width: 16,
                      height: 16,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.code, size: 16, color: gold),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      skill.$1,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white, // Nama aplikasi tetap putih bersih
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}