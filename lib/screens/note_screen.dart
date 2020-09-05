import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/data/note_database.dart';
import 'package:note_app/screens/add_note.dart';
import 'package:note_app/screens/screens.dart';
import 'package:note_app/widgets/note_card.dart';
import 'package:note_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class NoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notes',
                  style: TextStyle(fontSize: 35),
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.search),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder(
                stream: database.watchAllNotes(),
                builder: (context, snapshot) {
                  final notes = snapshot.data ?? List();
                  return GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: List.generate(
                      notes.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(
                            right: index.isEven ? 10 : 0, bottom: 10),
                        child: NoteCard(note: notes[index], database: database),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddNote()));
        },
        backgroundColor: Colors.grey[800],
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
