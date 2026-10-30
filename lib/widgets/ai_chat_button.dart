import 'package:flutter/material.dart';
import '../theme.dart';

class AiChatButton extends StatelessWidget {
  const AiChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, right: 8),
      child: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const AiChatModalContent(),
          );
        },
        backgroundColor: panel2,
        foregroundColor: gold,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: gold.withValues(alpha: 0.3)),
        ),
        icon: const Icon(Icons.chat_bubble_outline_rounded, size: 18, color: gold),
        label: const Text(
          'Tanya AI',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class AiChatModalContent extends StatefulWidget {
  const AiChatModalContent({super.key});

  @override
  State<AiChatModalContent> createState() => _AiChatModalContentState();
}

class _AiChatModalContentState extends State<AiChatModalContent> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, String>> _messages = [
    {
      'sender': 'ai',
      'text': 'Halo! Saya asisten AI di website ini. Tanyakan apa saja tentang skill, layanan, atau project Rahmad. Kalau ingin kerjasama, pesanmu bisa saya teruskan.'
    }
  ];

  bool _isTyping = false;

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': text.trim()});
      _isTyping = true;
    });

    _controller.clear();
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!mounted) return;
      setState(() {
        _isTyping = false;
        _messages.add({
          'sender': 'ai',
          'text': 'Terima kasih atas pertanyaannya! Pesan seputar "${text.trim()}" telah dicatat. Anda juga dapat menghubungi Rahmad secara langsung melalui menu kontak.'
        });
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: panel,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: gold.withValues(alpha: 0.25), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          // Header Modal AI
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: panel2.withValues(alpha: 0.8),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              border: Border(
                bottom: BorderSide(color: gold.withValues(alpha: 0.15)),
              ),
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: gold, width: 1.5),
                  ),
                  child: const CircleAvatar(
                    radius: 18,
                    backgroundColor: panel,
                    child: Icon(Icons.smart_toy_rounded, color: gold, size: 20),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Rahmad Rinaldi Abbas',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.greenAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'Asisten AI · biasanya membalas dalam hitungan detik',
                            style: TextStyle(color: muted, fontSize: 11),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh_rounded, color: muted, size: 20),
                  onPressed: () {
                    setState(() {
                      if (_messages.length > 1) {
                        _messages.removeRange(1, _messages.length);
                      }
                    });
                  },
                  tooltip: 'Reset Chat',
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: Colors.white, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          // Area Tampilan Pesan
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isTyping) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2, color: gold),
                        ),
                        SizedBox(width: 10),
                        Text('AI sedang mengetik...', style: TextStyle(color: muted, fontSize: 12)),
                      ],
                    ),
                  );
                }

                final msg = _messages[index];
                final isUser = msg['sender'] == 'user';

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: isUser ? gold.withValues(alpha: 0.2) : panel2,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isUser ? gold.withValues(alpha: 0.4) : gold.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Text(
                      msg['text']!,
                      style: const TextStyle(color: Colors.white70, fontSize: 13.5, height: 1.5),
                    ),
                  ),
                );
              },
            ),
          ),

          // Pertanyaan Cepat (Chips)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildQuickChip('Bisa bikin apa aja?'),
                  const SizedBox(width: 8),
                  _buildQuickChip('Lihat project-nya'),
                  const SizedBox(width: 8),
                  _buildQuickChip('Saya mau kerjasama'),
                ],
              ),
            ),
          ),

          // Input Pesan
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: panel2.withValues(alpha: 0.8),
              border: Border(
                top: BorderSide(color: gold.withValues(alpha: 0.15)),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onSubmitted: (value) => _sendMessage(value),
                        style: const TextStyle(color: Colors.white, fontSize: 13.5),
                        decoration: InputDecoration(
                          hintText: 'Tulis pesan...',
                          hintStyle: const TextStyle(color: muted, fontSize: 13.5),
                          filled: true,
                          fillColor: ink,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide(color: gold.withValues(alpha: 0.2)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide(color: gold.withValues(alpha: 0.2)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: const BorderSide(color: gold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: gold,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: gold.withValues(alpha: 0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_upward_rounded, color: ink, size: 20),
                        onPressed: () => _sendMessage(_controller.text),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Jawaban AI bisa saja kurang tepat. Pertanyaan serius akan diteruskan ke pemilik.',
                  style: TextStyle(color: muted, fontSize: 10.5),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickChip(String text) {
    return ActionChip(
      backgroundColor: Colors.transparent,
      side: BorderSide(color: gold.withValues(alpha: 0.25)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      label: Text(
        text,
        style: const TextStyle(color: Colors.white70, fontSize: 12),
      ),
      onPressed: () => _sendMessage(text),
    );
  }
}