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
        const SnackBar(content: Text('Harap isi Nama, Email, dan Pesan terlebih dahulu.')),
      );
      return;
    }

    setState(() {
      _isSubmitted = true;
    });

    // Email tujuan utama Anda
    final String recipientEmail = 'rahmadrinaldiabbas@gmail.com';
    
    // Format isi email otomatis
    final String emailSubject = Uri.encodeComponent(subject.isNotEmpty ? subject : 'Pesan dari Portofolio - $name');
    final String emailBody = Uri.encodeComponent(
      'Nama: $name\nEmail Pengirim: $email\n\nPesan:\n$message',
    );

    final emailUrl = 'mailto:$recipientEmail?subject=$emailSubject&body=$emailBody';
    _launchURL(emailUrl);
  }

  @override
  Widget build(BuildContext context) {
    return section(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 900;

          // Bagian Kiri: Info & Sosial Media
          final leftContent = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hubungi saya',
                style: TextStyle(color: muted, fontSize: 13, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              const Text(
                'Mari bekerja sama!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Punya proyek, ide, atau sekadar ingin menyapa? Kirim pesan dan saya akan membalas secepatnya.',
                style: TextStyle(color: muted, height: 1.6, fontSize: 14),
              ),
              const SizedBox(height: 28),
              _contactInfoCard(
                icon: Icons.email_outlined,
                title: 'Email',
                subtitle: 'rahmadrinaldiabbas@gmail.com',
                onTap: () => _launchURL('mailto:rahmadrinaldiabbas@gmail.com'),
              ),
              const SizedBox(height: 12),
              _contactInfoCard(
                icon: Icons.phone_outlined,
                title: 'WhatsApp / Telepon',
                subtitle: '+62 853-4091-8541',
                onTap: () => _launchURL('https://wa.me/6285340918541'),
              ),
              const SizedBox(height: 12),
              _contactInfoCard(
                icon: Icons.code_rounded,
                title: 'GitHub',
                subtitle: 'rahmadabbas01-oss',
                onTap: () => _launchURL('https://github.com/rahmadabbas01-oss'),
              ),
              const SizedBox(height: 12),
              _contactInfoCard(
                icon: Icons.camera_alt_outlined,
                title: 'Instagram',
                subtitle: '@rahmadrabbas',
                onTap: () => _launchURL('https://instagram.com/rahmadrabbas'),
              ),
            ],
          );

          // Bagian Kanan: Form Kirim Pesan
          final rightContent = card(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kirim pesan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 16),
                
                // Notifikasi Sukses Terkirim
                if (_isSubmitted) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.green.withValues(alpha: 0.4)),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.check, color: Colors.green, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Terima kasih! Pesanmu telah terkirim. Saya akan segera membalas.',
                            style: TextStyle(color: Colors.greenAccent, fontSize: 13),
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
                      Expanded(child: _buildField(label: 'Nama', hint: 'Rahmad', controller: _nameController)),
                      const SizedBox(width: 14),
                      Expanded(child: _buildField(label: 'Email', hint: 'you@email.com', controller: _emailController)),
                    ],
                  )
                else ...[
                  _buildField(label: 'Nama', hint: 'Rahmad', controller: _nameController),
                  const SizedBox(height: 14),
                  _buildField(label: 'Email', hint: 'you@email.com', controller: _emailController),
                ],
                const SizedBox(height: 14),

                // Baris 2: Subjek
                _buildField(label: 'Subjek', hint: 'Proyek website', controller: _subjectController),
                const SizedBox(height: 14),

                // Baris 3: Pesan
                _buildField(
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
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
    required IconData icon,
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
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: panel2,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: gold.withValues(alpha: 0.12)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: gold.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: gold, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: muted, fontSize: 11)),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: muted, fontSize: 14),
            filled: true,
            fillColor: panel2,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: gold.withValues(alpha: 0.15)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: gold.withValues(alpha: 0.15)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF6C5CE7)),
            ),
          ),
        ),
      ],
    );
  }
}