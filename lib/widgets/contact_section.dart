import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSubmitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Tidak dapat membuka $urlString');
    }
  }

  void _sendEmail() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final subject = _subjectController.text.trim();
    final message = _messageController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap isi Nama, Email, dan Pesan terlebih dahulu.'),
        ),
      );
      return;
    }

    setState(() {
      _isSubmitted = true;
    });

    // Email tujuan utama Anda
    const String recipientEmail = 'rahmadrinaldiabbas@gmail.com';

    // Format isi email otomatis
    final String emailSubject = Uri.encodeComponent(
      subject.isNotEmpty ? subject : 'Pesan dari Portofolio - $name',
    );
    final String emailBody = Uri.encodeComponent(
      'Nama: $name\nEmail Pengirim: $email\n\nPesan:\n$message',
    );

    final emailUrl =
        'mailto:$recipientEmail?subject=$emailSubject&body=$emailBody';
    _launchURL(emailUrl);
  }

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);

    return section(
      context: context,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 900;

          // Bagian Kiri: Info & Sosial Media
          final leftContent = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hubungi saya',
                style: TextStyle(
                  color: palette.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Mari bekerja sama!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: palette.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Punya proyek, ide, atau sekadar ingin menyapa? Kirim pesan dan saya akan membalas secepatnya.',
                style: TextStyle(
                  color: palette.textSecondary,
                  height: 1.6,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 28),
              _contactInfoCard(
                palette: palette,
                title: 'Email',
                subtitle: 'rahmadrinaldiabbas@gmail.com',
                onTap: () => _launchURL('mailto:rahmadrinaldiabbas@gmail.com'),
              ),
              const SizedBox(height: 12),
              _contactInfoCard(
                palette: palette,
                title: 'WhatsApp / Telepon',
                subtitle: '+62 853-4091-8541',
                onTap: () => _launchURL('https://wa.me/6285340918541'),
              ),
              const SizedBox(height: 12),
              _contactInfoCard(
                palette: palette,
                title: 'GitHub',
                subtitle: 'rahmadabbas01-oss',
                onTap: () => _launchURL('https://github.com/rahmadabbas01-oss'),
              ),
            ],
          );

          // Bagian Kanan: Form Kirim Pesan
          final rightContent = card(
            context: context,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kirim pesan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: palette.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),

                // Notifikasi Sukses Terkirim
                if (_isSubmitted) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(
                        alpha: palette.isDark ? 0.15 : 0.12,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.green.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.check, color: Colors.green, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Terima kasih! Pesanmu telah terkirim. Saya akan segera membalas.',
                            style: TextStyle(
                              color: palette.isDark
                                  ? Colors.greenAccent
                                  : Colors.green.shade800,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Baris 1: Nama & Email
                if (isWide)
                  Row(
                    children: [
                      Expanded(
                        child: _buildField(
                          palette: palette,
                          label: 'Nama',
                          hint: 'Rahmad Rinaldi Abbas',
                          controller: _nameController,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _buildField(
                          palette: palette,
                          label: 'Email',
                          hint: 'rahmadrinaldiabbas@gmail.com',
                          controller: _emailController,
                        ),
                      ),
                    ],
                  )
                else ...[
                  _buildField(
                    palette: palette,
                    label: 'Nama',
                    hint: 'Rahmad Rinaldi Abbas',
                    controller: _nameController,
                  ),
                  const SizedBox(height: 14),
                  _buildField(
                    palette: palette,
                    label: 'Email',
                    hint: 'rahmadrinaldiabbas@gmail.com',
                    controller: _emailController,
                  ),
                ],
                const SizedBox(height: 14),

                // Baris 2: Subjek
                _buildField(
                  palette: palette,
                  label: 'Subjek',
                  hint: 'Proyek website',
                  controller: _subjectController,
                ),
                const SizedBox(height: 14),

                // Baris 3: Pesan
                _buildField(
                  palette: palette,
                  label: 'Pesan',
                  hint: 'Ceritakan tentang proyekmu...',
                  controller: _messageController,
                  maxLines: 4,
                ),
                const SizedBox(height: 20),

                // Tombol Kirim Pesan via Email
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _sendEmail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: gold,
                      foregroundColor: ink,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.send_rounded, size: 16),
                    label: const Text(
                      'Kirim pesan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );

          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: leftContent),
                const SizedBox(width: 40),
                Expanded(flex: 6, child: rightContent),
              ],
            );
          } else {
            return Column(
              children: [
                leftContent,
                const SizedBox(height: 36),
                rightContent,
              ],
            );
          }
        },
      ),
    );
  }

  Widget _contactInfoCard({
    required AppColors palette,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        hoverColor: gold.withValues(alpha: 0.08),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: palette.cardBg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: palette.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: palette.textSecondary, fontSize: 11),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: TextStyle(
                  color: palette.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required AppColors palette,
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: palette.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: TextStyle(color: palette.textPrimary, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: palette.textSecondary, fontSize: 14),
            filled: true,
            fillColor: palette.isDark ? palette.cardBg : palette.surface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: palette.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: palette.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: palette.accent, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}