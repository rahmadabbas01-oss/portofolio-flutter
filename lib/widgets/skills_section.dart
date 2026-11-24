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
                  [
                    ('Flutter', 'assets/icons/flutter.png'),
                    ('Dart', 'assets/icons/dart.png'),
                    ('SQLite', 'assets/icons/sqlite.png'),
                  ]
                ),
                (
                  'Web Development',
                  [
                    ('Laravel', 'assets/icons/laravel.png'),
                    ('PHP', 'assets/icons/php.png'),
                    ('MySQL', 'assets/icons/mysql.png'),
                    ('Bootstrap', 'assets/icons/bootstrap.png'),
                  ]
                ),
                (
                  'Tools & Others',
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
                          skills: g.$2,
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
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: skills.map((skill) {
              return Container(
                width: 82,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: gold.withValues(alpha: 0.22)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      skill.$2,
                      width: 44,
                      height: 44,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.code, size: 32, color: gold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      skill.$1,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        height: 1.25,
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