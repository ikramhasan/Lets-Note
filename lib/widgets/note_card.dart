import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:note_app/data/note_database.dart';
import 'package:note_app/screens/add_note.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({this.note});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(note.colorValue),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: GoogleFonts.ubuntu(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            Text(
              note.description,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.ubuntu(
                fontSize: 14,
                color: Colors.grey[800],
              ),
            ),
            Text(
              DateFormat.yMMMMd('en_US').format(note.createdAt),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNote(note: note),
            ));
      },
    );
  }
}
