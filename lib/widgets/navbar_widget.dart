import 'package:flutter/material.dart';
import '../theme.dart';

class NavbarWidget extends StatelessWidget {
  final Function(GlobalKey) onNavigate;
  final Map<String, GlobalKey> keysMap;

  const NavbarWidget({
    super.key,
    required this.onNavigate,
    required this.keysMap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: palette.bg,
        border: Border(bottom: BorderSide(color: palette.borderColor)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: LayoutBuilder(
            builder: (context, c) {
              final compact = c.maxWidth < 860;

              return Row(
                children: [
                  Expanded(
                    child: Text(
                      'Rahmad Rinaldi Abbas',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: palette.textPrimary,
                      ),
                    ),
                  ),
                  if (!compact) ...[
                    _navButton('Home', () => onNavigate(keysMap['Home']!), palette),
                    _navButton('About', () => onNavigate(keysMap['About']!), palette),
                    _navButton('Skills', () => onNavigate(keysMap['Skills']!), palette),
                    _navButton('Projects', () => onNavigate(keysMap['Projects']!), palette),
                    _navButton(
                      'Experience',
                      () => onNavigate(keysMap['Experience']!),
                      palette,
                    ),
                    _navButton(
                      'Sertifikat',
                      () => onNavigate(keysMap['Sertifikat']!),
                      palette,
                    ),
                    _navButton(
                      'Contact',
                      () => onNavigate(keysMap['Contact']!),
                      palette,
                    ),
                    const SizedBox(width: 10),
                    const ThemeToggleButton(),
                  ] else ...[
                    const ThemeToggleButton(),
                    const SizedBox(width: 6),
                    PopupMenuButton<String>(
                      icon: Icon(
                        Icons.menu_rounded,
                        color: palette.textPrimary,
                      ),
                      color: palette.cardBg,
                      onSelected: (v) {
                        final key = keysMap[v];
                        if (key != null) onNavigate(key);
                      },
                      itemBuilder: (_) => keysMap.keys
                          .map(
                            (s) => PopupMenuItem<String>(
                              value: s,
                              child: Text(
                                s,
                                style: TextStyle(color: palette.textPrimary),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _navButton(String label, VoidCallback onTap, AppColors palette) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: palette.textSecondary,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: palette.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}