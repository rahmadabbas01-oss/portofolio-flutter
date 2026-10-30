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
    return Container(
      decoration: const BoxDecoration(
        color: ink,
        border: Border(bottom: BorderSide(color: Color(0xFF202A34))),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: LayoutBuilder(
            builder: (context, c) {
              final compact = c.maxWidth < 760;

              return Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Rahmad Rinaldi Abbas',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                  ),
                  if (!compact) ...[
                    _navButton('Home', () => onNavigate(keysMap['Home']!)),
                    _navButton('About', () => onNavigate(keysMap['About']!)),
                    _navButton('Skills', () => onNavigate(keysMap['Skills']!)),
                    _navButton('Projects', () => onNavigate(keysMap['Projects']!)),
                    _navButton('Experience', () => onNavigate(keysMap['Experience']!)),
                    _navButton('Sertifikat', () => onNavigate(keysMap['Sertifikat']!)),
                    _navButton('Contact', () => onNavigate(keysMap['Contact']!)),
                  ] else
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.menu_rounded),
                      color: panel2,
                      onSelected: (v) {
                        final key = keysMap[v];
                        if (key != null) onNavigate(key);
                      },
                      itemBuilder: (_) => keysMap.keys
                          .map((s) => PopupMenuItem(value: s, child: Text(s)))
                          .toList(),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _navButton(String label, VoidCallback onTap) => TextButton(
        onPressed: onTap,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
}