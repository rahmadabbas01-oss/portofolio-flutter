import 'package:flutter/material.dart';
import '../theme.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);

    return section(
      context: context,
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
                          palette: palette,
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
    required AppColors palette,
    required String title,
    required List<(String, String)> skills,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: palette.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: palette.borderColor,
        ),
        boxShadow: [
          BoxShadow(
            color: palette.shadowColor,
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: palette.textPrimary,
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
                  border: Border.all(color: gold.withValues(alpha: 0.25)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      skill.$2,
                      width: 44,
                      height: 44,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.code,
                        size: 32,
                        color: palette.accent,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      skill.$1,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: palette.textPrimary,
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