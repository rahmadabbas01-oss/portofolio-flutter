import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const PortfolioApp());

const Color ink = Color(0xFF090D12);
const Color panel = Color(0xFF111820);
const Color panel2 = Color(0xFF17212B);
const Color gold = Color(0xFFFFCC35);
const Color muted = Color(0xFFABB5C1);

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
  late final AnimationController _goldRotationController;
  final ScrollController _scroll = ScrollController();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _certificatesKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _goldRotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  // Fungsi untuk membuka URL (Email, WhatsApp, GitHub, Instagram)
  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Tidak dapat membuka $urlString');
    }
  }

  void _go(GlobalKey key) {
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
    _goldRotationController.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: Stack(
          children: [
            // Konten digulir di bawah navbar yang tetap.
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(top: 76),
                child: CustomScrollView(
                  controller: _scroll,
                  slivers: [
                    SliverToBoxAdapter(key: _homeKey, child: _hero()),
                    SliverToBoxAdapter(key: _aboutKey, child: _about()),
                    SliverToBoxAdapter(key: _skillsKey, child: _skills()),
                    SliverToBoxAdapter(key: _projectsKey, child: _projects()),
                    SliverToBoxAdapter(
                      key: _experienceKey,
                      child: _experience(),
                    ),
                    SliverToBoxAdapter(
                      key: _certificatesKey,
                      child: _certificates(),
                    ),
                    SliverToBoxAdapter(key: _contactKey, child: _contact()),
                    SliverToBoxAdapter(child: _footer()),
                  ],
                ),
              ),
            ),

            // Navbar dipisahkan dari CustomScrollView agar selalu terlihat.
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Material(
                color: ink,
                elevation: 5,
                child: SafeArea(bottom: false, child: _nav()),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: gold,
        foregroundColor: ink,
        onPressed: () => _go(_homeKey),
        child: const Icon(Icons.arrow_upward_rounded),
      ),
    );
  }

  // ============================================================
  // NAVIGASI
  // ============================================================

  Widget _nav() => Container(
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
                      _navButton('Home', () => _go(_homeKey)),
                      _navButton('About', () => _go(_aboutKey)),
                      _navButton('Skills', () => _go(_skillsKey)),
                      _navButton('Projects', () => _go(_projectsKey)),
                      _navButton('Experience', () => _go(_experienceKey)),
                      _navButton('Sertifikat', () => _go(_certificatesKey)),
                      _navButton('Contact', () => _go(_contactKey)),
                    ] else
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.menu_rounded),
                        color: panel2,
                        onSelected: (v) {
                          final map = {
                            'Home': _homeKey,
                            'About': _aboutKey,
                            'Skills': _skillsKey,
                            'Projects': _projectsKey,
                            'Experience': _experienceKey,
                            'Sertifikat': _certificatesKey,
                            'Contact': _contactKey,
                          };

                          final key = map[v];
                          if (key != null) _go(key);
                        },
                        itemBuilder: (_) => [
                          'Home',
                          'About',
                          'Skills',
                          'Projects',
                          'Experience',
                          'Sertifikat',
                          'Contact',
                        ]
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

  // ============================================================
  // HOME / HERO (Foto Profil)
  // ============================================================

  Widget _hero() => _section(
        child: LayoutBuilder(
          builder: (context, c) {
            final narrow = c.maxWidth < 760;

            final intro = Column(
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
                      TextSpan(
                        text: 'Abbas',
                        style: TextStyle(color: gold),
                      ),
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
                  'Saya seorang pengembang aplikasi yang tertarik '
                  'membangun solusi digital yang modern, bermanfaat, dan '
                  'mudah digunakan. Saya berfokus pada aplikasi mobile '
                  'dengan Flutter serta pengembangan web.',
                  style: TextStyle(color: muted, height: 1.7, fontSize: 15),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 12,
                  runSpacing: 10,
                  children: [
                    FilledButton.icon(
                      onPressed: () => _go(_projectsKey),
                      icon: const Icon(Icons.work_outline),
                      label: const Text('Lihat Proyek'),
                      style: FilledButton.styleFrom(
                        backgroundColor: gold,
                        foregroundColor: ink,
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _go(_contactKey),
                      icon: const Icon(Icons.mail_outline),
                      label: const Text('Hubungi Saya'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: gold,),
                      ),
                    ),
                    // ==========================================
                    // TOMBOL CV BARU
                    // ==========================================
                    FilledButton.icon(
  onPressed: () => _launchURL('https://raw.githubusercontent.com/rahmadabbas01-oss/portofolio-flutter/main/assets/doc/cv-rahmad-abbas.pdf'),
  icon: const Icon(Icons.description_outlined),
  label: const Text('Lihat CV'),
  style: FilledButton.styleFrom(
    backgroundColor: gold,
    foregroundColor: ink,
  ),
),
                  ],
                ),
                const SizedBox(height: 24),
                const Wrap(
                  spacing: 9,
                  runSpacing: 9,
                  children: [
                    _MiniTag(text: 'Flutter'),
                    _MiniTag(text: 'Dart'),
                    _MiniTag(text: 'Laravel'),
                    _MiniTag(text: 'MySQL'),
                  ],
                ),
              ],
            );

            // Bingkai foto profil dari assets/foto/profile.jpg
            final portrait = Center(
              child: AnimatedBuilder(
                animation: _goldRotationController,
                builder: (context, child) {
                  final angle = _goldRotationController.value * 2 * math.pi;

                  return Container(
                    width: 280,
                    height: 320,
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
                        BoxShadow(
                          color: gold.withValues(alpha: 0.15),
                          blurRadius: 38,
                          spreadRadius: 4,
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
                        fit: BoxFit.cover,
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
                  );
                },
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
      );

  // ============================================================
  // ABOUT / TENTANG SAYA
  // ============================================================

  Widget _about() => _section(
        background: panel,
        child: LayoutBuilder(
          builder: (context, c) {
            final narrow = c.maxWidth < 760;

            final profile = _card(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionTitle(
                    icon: Icons.person_outline,
                    title: 'Tentang Saya',
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Saya senang mempelajari teknologi baru, memecahkan '
                    'masalah, dan mengubah ide menjadi produk digital. '
                    'Saya percaya aplikasi yang baik harus fungsional, '
                    'nyaman digunakan, dan memberi dampak nyata.',
                    style: TextStyle(color: muted, height: 1.8),
                  ),
                  const SizedBox(height: 20),
                  const Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _Feature(
                        icon: Icons.lightbulb_outline,
                        title: 'Problem Solver',
                      ),
                      _Feature(icon: Icons.groups_outlined, title: 'Team Player'),
                      _Feature(
                        icon: Icons.school_outlined,
                        title: 'Continuous Learner',
                      ),
                    ],
                  ),
                ],
              ),
            );

            final details = _card(
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoRow(
                    icon: Icons.badge_outlined,
                    label: 'Nama',
                    value: 'Rahmad Rinaldi Abbas',
                  ),
                  _InfoRow(
                    icon: Icons.alternate_email,
                    label: 'Email',
                    value: 'rahmadrinaldiabbas@gmail.com',
                  ),
                  _InfoRow(
                    icon: Icons.location_on_outlined,
                    label: 'Lokasi',
                    value: 'Indonesia',
                  ),
                  _InfoRow(
                    icon: Icons.work_outline,
                    label: 'Status',
                    value: 'Freelancer',
                  ),
                ],
              ),
            );

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: narrow
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [profile, const SizedBox(height: 16), details],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 6, child: profile),
                        const SizedBox(width: 18),
                        Expanded(flex: 4, child: details),
                      ],
                    ),
            );
          },
        ),
      );

  // ============================================================
  // SKILLS
  // ============================================================

  Widget _skills() => _section(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionTitle(
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
                  ('Mobile Development', ['Flutter', 'Dart', 'SQLite']),
                  ('Web Development', ['Laravel', 'PHP', 'MySQL', 'Bootstrap']),
                  ('Tools & Others', ['Git', 'Github', 'Android Studio', 'VS Code', 'REST API']),
                ];

                return Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: groups
                      .map(
                        (g) => SizedBox(
                          width: (c.maxWidth - (count - 1) * 14) / count,
                          child: _card(
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  g.$1,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: gold,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: g.$2
                                      .map((s) => _MiniTag(text: s))
                                      .toList(),
                                ),
                              ],
                            ),
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

  // ============================================================
  // PROJECTS (Landscape / Mendatar 16:10)
  // ============================================================

  Widget _projects() => _section(
        background: panel,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionTitle(
              icon: Icons.folder_open_rounded,
              title: 'Proyek Pilihan',
            ),
            const SizedBox(height: 8),
            const Text(
              'Beberapa proyek yang pernah saya kerjakan',
              style: TextStyle(color: muted),
            ),
            const SizedBox(height: 22),
            LayoutBuilder(
              builder: (context, c) {
                final count = c.maxWidth > 900
                    ? 3
                    : c.maxWidth > 600
                    ? 2
                    : 1;

                final projects = [
                  (
                    'Fitpedia',
                    'Aplikasi kesehatan dan kebugaran dengan Flutter, '
                        'fitur AI, tracking, dan personalisasi.',
                    'assets/projects/fitpedia.jpeg',
                    ['Flutter', 'Dart', 'SQLite'],
                  ),
                  (
                    'Sistem Kepegawaian',
                    'Aplikasi web untuk pengelolaan data pegawai '
                        'dan administrasi.',
                    'assets/projects/kepegawaian.jpeg',
                    ['Laravel', 'MySQL', 'Bootstrap'],
                  ),
                  (
                    'Absensi App',
                    'Aplikasi untuk mencatat kehadiran dengan '
                        'dukungan face recognition.',
                    'assets/projects/absensi.jpeg',
                    ['Flutter', 'Dart', 'Firebase'],
                  ),
                ];

                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: projects
                      .map(
                        (p) => SizedBox(
                          width: (c.maxWidth - (count - 1) * 16) / count,
                          child: _card(
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: AspectRatio(
                                    aspectRatio: 16 / 10,
                                    child: Image.asset(
                                      p.$3,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        color: panel2,
                                        child: const Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.broken_image_outlined, color: muted, size: 36),
                                              SizedBox(height: 8),
                                              Text('Gambar belum tersedia', style: TextStyle(color: muted, fontSize: 12)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  p.$1,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  p.$2,
                                  style: const TextStyle(color: muted, height: 1.6),
                                ),
                                const SizedBox(height: 14),
                                Wrap(
                                  spacing: 6,
                                  runSpacing: 6,
                                  children: p.$4
                                      .map((s) => _MiniTag(text: s))
                                      .toList(),
                                ),
                              ],
                            ),
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

  // ============================================================
  // EXPERIENCE & EDUCATION (Tanpa Tahun)
  // ============================================================

  Widget _experience() => _section(
        child: LayoutBuilder(
          builder: (context, c) {
            final narrow = c.maxWidth < 760;

            final exp = _card(
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle(icon: Icons.work_outline, title: 'Pengalaman'),
                  SizedBox(height: 18),
                  _TimelineItem(
                    title: 'Freelancer',
                    detail:
                        'Mengerjakan proyek pengembangan aplikasi mobile '
                        'dan web untuk klien.',
                  ),
                  SizedBox(height: 16),
                  _TimelineItem(
                    title: 'Pengembang Proyek',
                    detail:
                        'Mengerjakan proyek aplikasi mobile dan web '
                        'sebagai latihan serta portofolio.',
                  ),
                ],
              ),
            );

            final edu = _card(
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle(icon: Icons.school_outlined, title: 'Pendidikan'),
                  SizedBox(height: 18),
                  _TimelineItem(
                    title: 'S1 Sistem Informasi',
                    detail:
                        'STIMIK MATUARI MANADO\n'
                        
                  ),
                ],
              ),
            );

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: narrow
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [exp, const SizedBox(height: 16), edu],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: exp),
                        const SizedBox(width: 16),
                        Expanded(child: edu),
                      ],
                    ),
            );
          },
        ),
      );

  // ============================================================
  // SERTIFIKAT
  // ============================================================

  Widget _certificates() => _section(
        background: panel,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionTitle(
              icon: Icons.workspace_premium_outlined,
              title: 'Sertifikat',
            ),
            const SizedBox(height: 8),
            const Text(
              'Sertifikat pelatihan dan pengembangan kemampuan saya.',
              style: TextStyle(color: muted, height: 1.6),
            ),
            const SizedBox(height: 22),
            LayoutBuilder(
              builder: (context, c) {
                final count = c.maxWidth > 800 ? 2 : 1;

                final certificates = [
                  (
                    'Mobile Programming',
                    '20JP',
                    'assets/sertifikat/mobile_programming.jpg',
                  ),
                  (
                    'Web Programming',
                    '28JP',
                    'assets/sertifikat/web_programming.jpg',
                  ),
                ];

                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: certificates.map((certificate) {
                    return SizedBox(
                      width: (c.maxWidth - (count - 1) * 16) / count,
                      child: _card(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: AspectRatio(
                                aspectRatio: 16 / 10,
                                child: Image.asset(
                                  certificate.$3,
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    color: panel2,
                                    child: const Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.broken_image_outlined, color: muted, size: 36),
                                          SizedBox(height: 8),
                                          Text('Sertifikat belum tersedia', style: TextStyle(color: muted, fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              certificate.$1,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              certificate.$2,
                              style: const TextStyle(color: gold, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      );

  // ============================================================
  // CONTACT / HUBUNGI SAYA (Interaktif)
  // ============================================================

  Widget _contact() => _section(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionTitle(
              icon: Icons.mail_outline,
              title: 'Hubungi Saya',
            ),
            const SizedBox(height: 8),
            const Text(
              'Silakan hubungi saya melalui email atau sosial media di bawah ini.',
              style: TextStyle(color: muted, height: 1.6),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _interactiveCard(
                  icon: Icons.email_outlined,
                  title: 'Email',
                  subtitle: 'rahmad.abbas01@gmail.com',
                  onTap: () => _launchURL('mailto:rahmad.abbas01@gmail.com'),
                ),
                _interactiveCard(
                  icon: Icons.phone_outlined,
                  title: 'Telepon / WhatsApp',
                  subtitle: '+62 853-4091-8541',
                  onTap: () => _launchURL('https://wa.me/6285340918541'),
                ),
                _interactiveCard(
                  icon: Icons.code_rounded,
                  title: 'GitHub',
                  subtitle: 'github.com/rahmadabbas01-oss',
                  onTap: () => _launchURL('https://github.com/rahmadabbas01-oss'),
                ),
                _interactiveCard(
                  icon: Icons.camera_alt_outlined,
                  title: 'Instagram',
                  subtitle: '@rahmadrabbas',
                  onTap: () => _launchURL('https://instagram.com/rahmadrabbas'),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _interactiveCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: panel2,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF202A34)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: gold, size: 24),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: muted, fontSize: 12)),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // FOOTER
  // ============================================================

  Widget _footer() => Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        decoration: const BoxDecoration(
          color: panel,
          border: Border(top: BorderSide(color: Color(0xFF202A34))),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: const Text(
              '© 2026 Rahmad Rinaldi Abbas. All rights reserved.',
              style: TextStyle(color: muted, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );

  // ============================================================
  // HELPER WIDGETS
  // ============================================================

  Widget _section({Color? background, required Widget child}) => Container(
        color: background ?? ink,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: child,
          ),
        ),
      );

  Widget _card(Widget child) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: panel2,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF202A34)),
        ),
        child: child,
      );
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionTitle({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: gold, size: 24),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _MiniTag extends StatelessWidget {
  final String text;

  const _MiniTag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, color: Color(0xFFE2E8F0), fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _Feature extends StatelessWidget {
  final IconData icon;
  final String title;

  const _Feature({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: gold, size: 18),
        const SizedBox(width: 6),
        Text(title, style: const TextStyle(fontSize: 13, color: muted)),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: gold, size: 20),
          const SizedBox(width: 12),
          Text('$label: ', style: const TextStyle(color: muted)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String title;
  final String detail;

  const _TimelineItem({
    required this.title,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          detail,
          style: const TextStyle(color: muted, height: 1.5, fontSize: 13),
        ),
      ],
    );
  }
}