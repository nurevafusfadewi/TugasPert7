import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pertemuan_tujuh/data/hive_database.dart';
import 'package:pertemuan_tujuh/data/shared_pref.dart';
import 'package:pertemuan_tujuh/model/Note.dart';
import 'package:pertemuan_tujuh/view/login_page.dart';
import 'package:pertemuan_tujuh/view/note_form_page.dart';
import 'package:pertemuan_tujuh/view/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HiveDatabase _hd = HiveDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NoteFormPage()));
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ValueListenableBuilder(
          valueListenable: _hd.localDBBox.listenable(),
          builder: (BuildContext context, Box<dynamic> value, Widget? child) {
            if (value.isEmpty) {
              return Text("Data Kosong");
            } else {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return _cardItemList(index);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _cardItemList(int index) {
    Note? note = _hd.getNoteAt(index);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return NoteFormPage(
                note: note,
                index: index,
              );
            }));
          },
          child: Container(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        Text(
                          "${note?.title}",
                        ),
                        Text("${note?.text}"),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _hd.deleteAt(index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
