import 'package:flutter/material.dart';

class HalamanRiwayat extends StatelessWidget {
  const HalamanRiwayat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Laporan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(
            child: ListTile(
              leading: Icon(Icons.report),
              title: Text('Lampu Jalan Rusak'),
              subtitle: Text('Status: Diproses'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.delete),
              title: Text('Sampah Menumpuk'),
              subtitle: Text('Status: Selesai'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.water),
              title: Text('Saluran Air Tersumbat'),
              subtitle: Text('Status: Diproses'),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Membuat laporan baru'),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.filter_list),
            ),
            const SizedBox(width: 40),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.sort),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }
}