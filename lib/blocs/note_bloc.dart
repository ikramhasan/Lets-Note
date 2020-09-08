import 'package:flutter/material.dart';
import 'package:note_app/data/note_database.dart';

class NoteBloc {
  final database = AppDatabase();

  createNote(Note note) {
    database.insertNote(note);
  }

  deleteNote(Note note) {
    database.deleteNote(note);
  }

  updateNote(Note note) {
    database.updateNote(note);
  }

  streamAllNotes() {
    database.watchAllNotes();
  }

  getAllNotes() {
    database.getAllNotes();
  }
}
