import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); //Pada halaman Login dan Register, saya menggunakan 
                                                                  //TextField untuk menerima input dari pengguna (email dan password). 
                                                                  //Setelah pengguna login atau melakukan registrasi, aplikasi menyimpan 
                                                                  //status login menggunakan SharedPreferences agar saat aplikasi dibuka kembali, 
                                                                  //pengguna tidak perlu login ulang.
  prefs.setBool('isLoggedIn', true);  // Simpan status login
}

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Aplikasi Pengelola Koleksi Buku',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logika untuk login
                String email = emailController.text;
                String password = passwordController.text;

                if (email == "user@gmail.com" && password == "123") {
                  // Jika login berhasil
                  Navigator.pushReplacementNamed(context, '/home'); //Untuk mengarahkan pengguna ke halaman lain, 
                                                                    //saya menggunakan Navigator.pushNamed.
                                                                    //Ini akan mengganti halaman yang sedang aktif dengan halaman Home.
                } else {
                  // Jika login gagal
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Login Gagal'),
                      content: Text('Email atau password salah!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Belum punya akun? Daftar di sini'),
            ),
          ],
        ),
      ),
    );
  }
}
