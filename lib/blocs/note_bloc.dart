import 'package:get/get.dart';
import 'package:note_app/models/models.dart';

class NoteBloc extends GetxController {
  final noteList = [];

  addNote(Note note) {
    noteList.add(note);
    update();
  }

  deleteNote(Note note) {
    noteList.remove(note);
    update();
  }
}
