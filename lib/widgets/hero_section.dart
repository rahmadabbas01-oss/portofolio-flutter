import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';

class HeroSection extends StatefulWidget {
  final Function(GlobalKey) onNavigate;
  final GlobalKey projectsKey;
  final GlobalKey contactKey;
  final AnimationController rotationController;

  const HeroSection({
    super.key,
    required this.onNavigate,
    required this.projectsKey,
    required this.contactKey,
    required this.rotationController,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _introController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Controller untuk animasi masuk teks perkenalan (Fade & Slide Up)
    _introController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _introController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _introController,
      curve: Curves.easeOutCubic,
    ));

    _introController.forward();

    // Controller untuk animasi denyut tombol utama
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _introController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Tidak dapat membuka $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ink,
      width: double.infinity,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: LayoutBuilder(
            builder: (context, c) {
              final narrow = c.maxWidth < 760;

              // Bagian Teks Perkenalan dengan Animasi Masuk
              final intro = FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "HELLO, I'M",
                        style: TextStyle(
                          color: gold,
                          letterSpacing: 3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: narrow ? 42 : 62,
                            height: 1.05,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                          children: const [
                            TextSpan(text: 'Rahmad Rinaldi\n'),
                            TextSpan(text: 'Abbas', style: TextStyle(color: gold)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Flutter Developer & Web Developer',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFDCE4ED),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Saya seorang pengembang aplikasi yang tertarik membangun solusi digital yang modern, bermanfaat, dan mudah digunakan. Saya berfokus pada aplikasi mobile dengan Flutter serta pengembangan web.',
                        style: TextStyle(color: muted, height: 1.7, fontSize: 15),
                      ),
                      const SizedBox(height: 24),
                      Wrap(
                        spacing: 12,
                        runSpacing: 10,
                        children: [
                          // Tombol utama dengan efek animasi denyut (pulsing)
                          ScaleTransition(
                            scale: _scaleAnimation,
                            child: FilledButton.icon(
                              onPressed: () => widget.onNavigate(widget.projectsKey),
                              icon: const Icon(Icons.work_outline),
                              label: const Text('Lihat Proyek'),
                              style: FilledButton.styleFrom(
                                backgroundColor: gold,
                                foregroundColor: ink,
                              ),
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: () => widget.onNavigate(widget.contactKey),
                            icon: const Icon(Icons.mail_outline),
                            label: const Text('Hubungi Saya'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: gold),
                            ),
                          ),
                          FilledButton.icon(
                            onPressed: () => _launchURL(
                              'https://docs.google.com/gview?embedded=true&url=https://raw.githubusercontent.com/rahmadabbas01-oss/portofolio-flutter/main/assets/doc/cv-rahmad-abbas.pdf',
                            ),
                            icon: const Icon(Icons.description_outlined),
                            label: const Text('Lihat CV'),
                            style: FilledButton.styleFrom(
                              backgroundColor: gold,
                              foregroundColor: ink,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );

              final portrait = Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background layer (bingkai bergeser)
                    Transform.translate(
                      offset: const Offset(12, 12),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 280),
                        child: AspectRatio(
                          aspectRatio: 3 / 4,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: gold.withValues(alpha: 0.04),
                              border: Border.all(
                                color: gold.withValues(alpha: 0.25),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Foreground Layer (Rotating border & photo)
                    AnimatedBuilder(
                      animation: widget.rotationController,
                      builder: (context, child) {
                        final angle = widget.rotationController.value * 2 * math.pi;
                        return ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 280),
                          child: AspectRatio(
                            aspectRatio: 3 / 4,
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: SweepGradient(
                                  transform: GradientRotation(angle),
                                  colors: const [
                                    Color(0xFFFFD700),
                                    Color(0xFF8A5A00),
                                    Color(0xFFFFF4B0),
                                    Color(0xFFFFB700),
                                    Colors.white,
                                    Color(0xFFB8860B),
                                    Color(0xFFFFD700),
                                  ],
                                  stops: const [0.0, 0.18, 0.32, 0.48, 0.55, 0.78, 1.0],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: gold.withValues(alpha: 0.35),
                                    blurRadius: 22,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ink,
                                  borderRadius: BorderRadius.circular(27),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Image.asset(
                                  'assets/foto/profile.jpeg',
                                  fit: BoxFit.fitWidth,
                                  alignment: Alignment.bottomCenter,
                                  width: double.infinity,
                                  height: double.infinity,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    color: panel2,
                                    child: const Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.broken_image_outlined, color: muted, size: 36),
                                          SizedBox(height: 8),
                                          Text('Foto belum tersedia', style: TextStyle(color: muted, fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );

              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 58,
                  horizontal: narrow ? 22 : 12,
                ),
                child: narrow
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          intro,
                          const SizedBox(height: 36),
                          SizedBox(height: 330, child: portrait),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(flex: 6, child: intro),
                          const SizedBox(width: 56),
                          Expanded(
                            flex: 5,
                            child: SizedBox(height: 410, child: portrait),
                          ),
                        ],
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}