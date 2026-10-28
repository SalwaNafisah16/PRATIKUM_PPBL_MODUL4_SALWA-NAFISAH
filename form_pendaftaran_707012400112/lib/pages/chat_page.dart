import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _pesanController = TextEditingController();

  final List<String> _pesan = [
    'Halo, selamat datang di layanan informasi kegiatan kampus!',
  ];

  void _kirimPesan() {
    final teks = _pesanController.text.trim();

    if (teks.isEmpty) return;

    setState(() {
      _pesan.add(teks);
      _pesanController.clear();
    });
  }

  @override
  void dispose() {
    _pesanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat Panitia')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _pesan.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: index == 0
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    constraints: const BoxConstraints(maxWidth: 280),
                    decoration: BoxDecoration(
                      color: index == 0
                          ? Colors.grey.shade200
                          : Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(_pesan[index]),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _pesanController,
                    decoration: const InputDecoration(
                      hintText: 'Tulis pesan...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _kirimPesan(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _kirimPesan,
                  icon: const Icon(Icons.send),
                  tooltip: 'Kirim pesan',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
