import 'package:flutter/material.dart';

class DetailBookPage extends StatefulWidget {
  final Function(int, String, String, String) onEdit;
  final Function(int) onDelete;

  DetailBookPage({required this.onEdit, required this.onDelete});

  @override
  _DetailBookPageState createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  late Map<String, String> book;
  late int index;

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    index = arguments['index'];
    book = {
      'title': arguments['title'],
      'author': arguments['author'],
      'description': arguments['description'],
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(book['title'] ?? 'Detail Buku'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book['title'] ?? '',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Penulis: ${book['author']}'),
            SizedBox(height: 10),
            Text('Deskripsi: ${book['description']}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final updatedBook = await Navigator.pushNamed(
                  context,
                  '/edit',
                  arguments: {
                    'index': index,
                    'title': book['title'],
                    'author': book['author'],
                    'description': book['description'],
                  },
                );

                // Jika data diperbarui, setState untuk memperbarui UI
                if (updatedBook != null) {
                  setState(() {
                    book = updatedBook as Map<String, String>;
                  });
                }
              },
              child: Text('Edit Buku'),
            ),
          ],
        ),
      ),
    );
  }
}
