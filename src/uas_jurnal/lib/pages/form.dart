import 'package:flutter/material.dart';

class AddJournalPage extends StatelessWidget {
  final Function(String, String) addJournal;

  AddJournalPage({required this.addJournal});

  @override
  Widget build(BuildContext context) {
    String title = '';
    String body = '';

    void _showAlertDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Harap isi semua kolom sebelum menyimpan.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Jurnal'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/view.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Judul Jurnal',
                  labelStyle: TextStyle(
                    color: Colors.white, // Setel warna teks label menjadi putih
                  ),
                ),
                style: TextStyle(
                  color: Colors.white, // Setel warna teks isi menjadi putih
                ),
                onChanged: (value) {
                  title = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Isi Jurnal',
                  labelStyle: TextStyle(
                    color: Colors.white, // Setel warna teks label menjadi putih
                  ),
                ),
                style: TextStyle(
                  color: Colors.white, // Setel warna teks isi menjadi putih
                ),
                maxLines: null, // Ubah menjadi null untuk membuat textarea
                onChanged: (value) {
                  body = value;
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (title.isEmpty || body.isEmpty) {
                  _showAlertDialog(context);
                } else {
                  addJournal(title, body);
                  Navigator.pop(context);
                }
              },
              icon: Icon(Icons.save),
              label: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
