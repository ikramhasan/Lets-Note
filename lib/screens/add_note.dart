import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note_app/blocs/note_bloc.dart';
import 'package:note_app/models/models.dart';
import 'package:note_app/widgets/widgets.dart';

class AddNote extends StatelessWidget {
  final Note note;

  AddNote({this.note});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //final Color selectedColor;
    final random = Random();
    final colorList = [
      Color(0xFFFEAA93),
      Color(0xFFFECB86),
      Color(0xFFE6EDA1),
      Color(0xFF82DEE9),
      Color(0xFFCE95D6),
      Color(0xFFF38FB0),
    ];
    final noteBloc = Get.put(NoteBloc());
    if (note != null) {
      _titleController.text = note.title;
      _descriptionController.text = note.description;
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppbar(
              onTap: () {
                Note note = Note(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    date: DateTime.now(),
                    color: colorList[random.nextInt(colorList.length)]);
                noteBloc.addNote(note);
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 25),
            //ColorPicker(colorList: colorList),
            TextField(
              controller: _titleController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(fontSize: 35),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
                hintStyle: TextStyle(fontSize: 35),
              ),
            ),
            SizedBox(height: 20),
            note != null
                ? Text(
                    DateFormat.yMMMMd('en_US').format(note.date),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  )
                : Container(),
            note != null ? SizedBox(height: 20) : Container(),
            TextField(
              controller: _descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(fontSize: 22),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Type Something...',
                hintStyle: TextStyle(fontSize: 22),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: note != null
          ? FloatingActionButton(
              onPressed: () {
                noteBloc.deleteNote(note);
                Navigator.pop(context);
              },
              backgroundColor: Colors.red[400],
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            )
          : Container(),
    );
  }
}
