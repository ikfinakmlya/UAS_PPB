import 'package:flutter/material.dart';

class AddEditBookPage extends StatelessWidget {
  final Function(int, String, String, String)? onEdit;
  final Function(String, String, String)? onSave;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  AddEditBookPage({this.onEdit, this.onSave});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map?;
    final int? index = arguments?['index'];
    final String? initialTitle = arguments?['title'];
    final String? initialAuthor = arguments?['author'];
    final String? initialDescription = arguments?['description'];

    titleController.text = initialTitle ?? '';
    authorController.text = initialAuthor ?? '';
    descriptionController.text = initialDescription ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(index == null ? 'Tambah Buku' : 'Edit Buku'), // Judul berubah sesuai kondisi
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Judul Buku',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: authorController,
              decoration: InputDecoration(
                labelText: 'Penulis Buku',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Deskripsi Buku',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String title = titleController.text;
                String author = authorController.text;
                String description = descriptionController.text;

                if (title.isNotEmpty && author.isNotEmpty && description.isNotEmpty) {
                  if (index == null) {
                    // Menambahkan buku baru
                    onSave?.call(title, author, description);
                  } else {
                    // Memperbarui buku yang ada
                    onEdit?.call(index, title, author, description);
                  }

                  // Kembali ke halaman sebelumnya dengan data yang diperbarui
                  Navigator.pop(context, {
                    'title': title,
                    'author': author,
                    'description': description,
                  });
                } else {
                  // Tampilkan pesan jika ada field yang kosong
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Harap isi semua data!'),
                    ),
                  );
                }
              },
              child: Text(index == null ? 'Tambah Buku' : 'Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}
