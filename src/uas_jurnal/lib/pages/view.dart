import 'package:flutter/material.dart';
import 'package:uas_jurnal/login/first_screen.dart';
import 'package:uas_jurnal/pages/edit.dart';
import 'package:uas_jurnal/pages/form.dart';

import '../helpers/DBhelper.dart';
import '../login/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Map<String, dynamic>> _journals = [];
  late List<Map<String, dynamic>> _filteredJournals = [];

  @override
  void initState() {
    super.initState();
    refreshJournalList();
  }

  Future<void> refreshJournalList() async {
    final List<Map<String, dynamic>> journals = await DBHelper.getJournals();
    setState(() {
      _journals = journals;
      _filteredJournals = journals;
    });
  }

  Future<void> addJournal(String title, String body) async {
    await DBHelper.addJournal(title, body);
    refreshJournalList();
  }

  Future<void> updateJournal(int id, String title, String body) async {
    await DBHelper.updateJournal(id, title, body);
    refreshJournalList();
  }

  Future<void> deleteJournal(int id) async {
    await DBHelper.deleteJournal(id);
    refreshJournalList();
  }

  void searchJournals(String keyword) {
    setState(() {
      _filteredJournals = _journals
          .where((journal) =>
              journal['title'].toLowerCase().contains(keyword.toLowerCase()) ||
              journal['body'].toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }

  @override
  int _selectedIndex = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Journal'),
        automaticallyImplyLeading: false,
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
                decoration: InputDecoration(
                  labelText: 'Cari Jurnal',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Color.fromARGB(255, 206, 195, 195),
                ),
                onChanged: (value) {
                  searchJournals(value);
                },
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: ListView.separated(
                  itemCount: _filteredJournals.length,
                  separatorBuilder: (context, index) => Divider(
                    color: Color.fromARGB(255, 68, 58, 58),
                  ),
                  itemBuilder: (context, index) {
                    final journal = _filteredJournals[index];
                    return ListTile(
                      title: Text(
                        journal['title'],
                        style: TextStyle(
                          color: Colors.white, // Setel warna teks menjadi putih
                        ),
                      ),
                      subtitle: Text(
                        journal['body'],
                        style: TextStyle(
                          color: Colors.white, // Setel warna teks menjadi putih
                        ),
                      ),
                      trailing: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 224, 61, 61),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            deleteJournal(journal['id']);
                          },
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditJournalPage(
                              journal: journal,
                              updateJournal: updateJournal,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddJournalPage(addJournal: addJournal),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FirstScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
