import 'package:hive_flutter/hive_flutter.dart';
import 'package:pertemuan_tujuh/model/Note.dart';

class HiveDatabase {
  Box<Note> localDBBox = Hive.box<Note>("notedb");

  void addData(Note note) {
    localDBBox.add(note);
  }

  Note? getNoteAt(int position) {
    return localDBBox.getAt(position);
  }

  void deleteAt(int position) {
    localDBBox.deleteAt(position);
  }

  void putNoteAt(int position, Note value) {
    localDBBox.putAt(position, value);
  }

  int getLength() {
    return localDBBox.length;
  }
}
