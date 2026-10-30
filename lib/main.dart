import 'package:flutter/material.dart';
import 'widgets/ai_chat_button.dart'; // Widget Tanya AI yang sudah dibuat
import 'package:url_launcher/url_launcher.dart';
import 'theme.dart';

// Impor widget bagian (sections) yang telah dipisah
import 'widgets/navbar_widget.dart';
import 'widgets/hero_section.dart';
import 'widgets/about_section.dart';
import 'widgets/skills_section.dart';
import 'widgets/projects_section.dart';
import 'widgets/experience_section.dart';
import 'widgets/certificates_section.dart';
import 'widgets/contact_section.dart';
import 'widgets/footer_widget.dart';

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rahmad Rinaldi Abbas | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: ink,
        colorScheme: ColorScheme.fromSeed(
          seedColor: gold,
          brightness: Brightness.dark,
        ),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome>
    with SingleTickerProviderStateMixin {
  late final AnimationController goldRotationController;
  final ScrollController _scroll = ScrollController();

  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey certificatesKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    goldRotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  Future<void> launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Tidak dapat membuka $urlString');
    }
  }

  void scrollToSection(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeInOut,
        alignment: 0,
      );
    }
  }

  @override
  void dispose() {
    goldRotationController.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(top: 76),
                child: CustomScrollView(
                  controller: _scroll,
                  slivers: [
                    SliverToBoxAdapter(key: homeKey, child: HeroSection(onNavigate: scrollToSection, projectsKey: projectsKey, contactKey: contactKey, rotationController: goldRotationController)),
                    SliverToBoxAdapter(key: aboutKey, child: const AboutSection()),
                    SliverToBoxAdapter(key: skillsKey, child: const SkillsSection()),
                    SliverToBoxAdapter(key: projectsKey, child: const ProjectsSection()),
                    SliverToBoxAdapter(key: experienceKey, child: const ExperienceSection()),
                    SliverToBoxAdapter(key: certificatesKey, child: const CertificatesSection()),
                    SliverToBoxAdapter(key: contactKey, child: const ContactSection()),
                    const SliverToBoxAdapter(child: FooterWidget()),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Material(
                color: ink,
                elevation: 5,
                child: SafeArea(
                  bottom: false,
                  child: NavbarWidget(onNavigate: scrollToSection, keysMap: {
                    'Home': homeKey,
                    'About': aboutKey,
                    'Skills': skillsKey,
                    'Projects': projectsKey,
                    'Experience': experienceKey,
                    'Sertifikat': certificatesKey,
                    'Contact': contactKey,
                  }),
                ),
              ),
            ),
            
            // Gabungan Tombol Panah ke Atas & Tombol Tanya AI secara Vertikal di Pojok Kanan Bawah
            Positioned(
              bottom: 16,
              right: 16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FloatingActionButton.small(
                    backgroundColor: gold,
                    foregroundColor: ink,
                    onPressed: () => scrollToSection(homeKey),
                    child: const Icon(Icons.arrow_upward_rounded),
                  ),
                  const SizedBox(height: 10),
                  const AiChatButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}