import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HomePage extends StatefulWidget {
  final Function onLogout;

  HomePage({required this.onLogout, required List<Map<String, dynamic>> books, required Future<void> Function(dynamic id) onDelete});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _books = [];

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<Database> _openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'books_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS books(id INTEGER PRIMARY KEY, title TEXT, author TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> _fetchBooks() async {
    final db = await _openDB();
    final List<Map<String, dynamic>> books = await db.query('books');
    setState(() {
      _books = books;
    });
  }

  Future<void> _deleteBook(int id) async {
    final db = await _openDB();
    await db.delete('books', where: 'id = ?', whereArgs: [id]);
    _fetchBooks(); // Refresh daftar buku setelah dihapus
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Koleksi Buku'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await widget.onLogout();
            },
          ),
        ],
      ),
      body: _books.isEmpty
          ? Center(child: Text('Belum ada koleksi buku.'))
          : ListView.builder(
              itemCount: _books.length,
              itemBuilder: (context, index) {
                final book = _books[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      book['title'] ?? 'Tidak ada judul',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Penulis: ${book['author'] ?? 'Tidak ada penulis'}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _deleteBook(book['id']);
                      },
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/detail',
                        arguments: book,
                      ).then((_) => _fetchBooks()); // Refresh saat kembali dari detail
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add').then((_) => _fetchBooks()); // Refresh saat kembali dari tambah buku
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
