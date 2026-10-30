import 'package:flutter/material.dart';
import '../theme.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
      decoration: const BoxDecoration(
        color: panel,
        border: Border(top: BorderSide(color: Color(0xFF202A34))),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: const Column(
            children: [
              Text(
                '© 2026 Rahmad Rinaldi Abbas. Hak cipta dilindungi.',
                style: TextStyle(color: muted, fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}