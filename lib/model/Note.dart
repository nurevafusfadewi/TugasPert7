import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

part 'Note.g.dart';

@HiveType(typeId: 1)
class Note extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String text;

  Note({required this.title, required this.text});
}
