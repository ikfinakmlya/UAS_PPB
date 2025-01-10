import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'register.dart';
import 'home.dart';
import 'detail_book.dart';
import 'add_edit_book.dart';
import 'database_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> books = [];

  @override
  void initState() {
    super.initState();
    loadBooks(); // Ambil data saat aplikasi dimulai
  }

  Future<void> loadBooks() async {
    final data = await DatabaseHelper().getBooks();
    setState(() {
      books = data;
    });
  }

  Future<void> addBook(String title, String author, String description) async {
    await DatabaseHelper().insertBook(title, author, description);
    loadBooks(); // Perbarui tampilan
  }

  Future<void> editBook(int id, String title, String author, String description) async {
    await DatabaseHelper().updateBook(id, title, author, description);
    loadBooks(); // Perbarui tampilan
  }

  Future<void> deleteBook(int id) async {
    await DatabaseHelper().deleteBook(id);
    loadBooks(); // Perbarui tampilan
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn'); // Hapus status login

    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(
              books: books,
              onDelete: (id) => deleteBook(id), // GANTI index → id
              onLogout: logout,
            ),
        '/detail': (context) => DetailBookPage(
              onEdit: (id, title, author, description) {
                editBook(id, title, author, description);
              },
              onDelete: (id) {
                deleteBook(id);
              },
            ),
        '/add': (context) => AddEditBookPage(
              onSave: (title, author, description) {
                addBook(title, author, description);
              },
            ),
        '/edit': (context) => AddEditBookPage(
              onSave: (title, author, description) {
                final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
                final int bookId = arguments['id'];
                editBook(bookId, title, author, description);
              },
            ),
      },
    );
  }
}
