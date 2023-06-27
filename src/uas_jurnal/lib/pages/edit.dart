import 'package:flutter/material.dart';

class EditJournalPage extends StatefulWidget {
  final Map<String, dynamic> journal;
  final Function(int, String, String) updateJournal;

  EditJournalPage({required this.journal, required this.updateJournal});

  @override
  _EditJournalPageState createState() => _EditJournalPageState();
}

class _EditJournalPageState extends State<EditJournalPage> {
  late TextEditingController _titleController;
  late TextEditingController _bodyController;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.journal['title']);
    _bodyController = TextEditingController(text: widget.journal['body']);
  }

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

  void _saveJournal() {
    String title = _titleController.text;
    String body = _bodyController.text;

    if (title.isEmpty || body.isEmpty) {
      _showAlertDialog(context);
    } else {
      setState(() {
        isSaving = true;
      });

      widget.updateJournal(widget.journal['id'], title, body);

      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Jurnal'),
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
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Judul Jurnal',
                  labelStyle: TextStyle(
                    color: Colors.white, // Setel warna teks label menjadi putih
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white, // Setel warna teks isi menjadi putih
                ),
                controller: _titleController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Isi Jurnal',
                  labelStyle: TextStyle(
                    color: Colors.white, // Setel warna teks label menjadi putih
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white, // Setel warna teks isi menjadi putih
                ),
                maxLines: null,
                controller: _bodyController,
              ),
            ),
            AnimatedOpacity(
              opacity: isSaving ? 0.0 : 1.0,
              duration: Duration(milliseconds: 500),
              child: ElevatedButton.icon(
                onPressed: _saveJournal,
                icon: Icon(Icons.save),
                label: Text('Simpan'),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: isSaving ? 50.0 : 0.0,
              curve: Curves.easeInOut,
              child: isSaving
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 8.0),
                        Text('Menyimpan...'),
                      ],
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
