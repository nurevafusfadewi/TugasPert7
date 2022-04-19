import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pertemuan_tujuh/data/hive_database.dart';
import 'package:pertemuan_tujuh/model/Note.dart';

class NoteFormPage extends StatefulWidget {
  final Note? note;
  final int? index;

  const NoteFormPage({Key? key, this.note, this.index}) : super(key: key);

  @override
  State<NoteFormPage> createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  HiveDatabase _hd = HiveDatabase();

  var title_controller = TextEditingController();
  var text_controller = TextEditingController();

  bool isUpdate = false;
  int index = 0;

  void initVariable() {
    String title = "";
    String text = "";
    if (widget.note != null && widget.index != null) {
      title = widget.note!.title;
      text = widget.note!.text;
      isUpdate = true;
      index = widget.index ?? 0;
    }
    title_controller.text = title;
    text_controller.text = text;
  }

  @override
  void initState() {
    super.initState();
    initVariable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input Note"),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            _formSection(title_controller, "title"),
            SizedBox(height: 16),
            _formSection(text_controller, "text"),
            SizedBox(height: 16),
            _buttonSubmit(),
          ],
        ),
      ),
    );
  }

  Widget _formSection(dynamic text_controller, String label) {
    return TextFormField(
      controller: text_controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
      ),
    );
  }

  Widget _buttonSubmit() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () {
          _submitProcess();
        },
        child: Text("Submit"),
      ),
    );
  }

  void _submitProcess() {
    String title = title_controller.text;
    String text = text_controller.text;

    Note note = Note(title: title, text: text);
    if (isUpdate)
      _hd.putNoteAt(index, note);
    else
      _hd.addData(note);
    Navigator.pop(context);
  }
}
