import 'package:flutter/material.dart';

const Color ink = Color(0xFF090D12);
const Color panel = Color(0xFF111820);
const Color panel2 = Color(0xFF17212B);
const Color gold = Color(0xFFFFCC35);
const Color muted = Color(0xFFABB5C1);

// Ubah _section menjadi section (publik)
Widget section({Color? background, required Widget child}) {
  return Container(
    color: background ?? ink,
    width: double.infinity,
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1180),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: child,
        ),
      ),
    ),
  );
}

// Ubah _card menjadi card (publik)
Widget card(Widget child) {
  return Container(
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      color: panel2,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: gold.withValues(alpha: 0.15)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: child,
  );
}

class SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const SectionTitle({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: gold.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: gold.withValues(alpha: 0.3)),
          ),
          child: Icon(icon, color: gold, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class MiniTag extends StatelessWidget {
  final String text;

  const MiniTag({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: gold.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: gold.withValues(alpha: 0.2)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: gold,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}