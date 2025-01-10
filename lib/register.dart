import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Daftar Akun Baru',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
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
                // Simpan data akun (sementara hanya di print)
                String name = nameController.text;
                String email = emailController.text;
                String password = passwordController.text;

                if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
                  // Simulasi data berhasil disimpan
                  print('Akun berhasil didaftarkan: $email');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Registrasi Berhasil! Silakan Login.'),
                    ),
                  );
                  Navigator.pop(context); // Kembali ke halaman login
                } else {
                  // Jika data tidak lengkap
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Harap isi semua data!'),
                    ),
                  );
                }
              },
              child: Text('Daftar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Kembali ke halaman login
              },
              child: Text('Sudah punya akun? Login di sini'),
            ),
          ],
        ),
      ),
    );
  }
}
