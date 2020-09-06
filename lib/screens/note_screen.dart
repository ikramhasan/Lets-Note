import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/data/note_database.dart';
import 'package:note_app/screens/add_note.dart';
import 'package:note_app/widgets/note_card.dart';
import 'package:provider/provider.dart';

class NoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    bool hasFound = false;
    final TextEditingController controller = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
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
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.grey[900],
                        //Theme.of(context).scaffoldBackgroundColor,
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: controller,
                              decoration: InputDecoration(
                                hintText: 'Search by title or description',
                              ),
                            ),
                            SizedBox(height: 10),
                            InkWell(
                              onTap: () {
                                database.getAllNotes().then((value) {
                                  for (final note in value) {
                                    if ((note.title.toLowerCase() ==
                                            controller.text.toLowerCase()) ||
                                        (note.description.toLowerCase() ==
                                            controller.text.toLowerCase())) {
                                      hasFound = true;
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AddNote(note: note),
                                        ),
                                      );
                                    }
                                  }
                                  if (hasFound == false) {
                                    Flushbar(
                                      margin: EdgeInsets.all(20),
                                      dismissDirection:
                                          FlushbarDismissDirection.HORIZONTAL,
                                      borderColor: Colors.red,
                                      borderRadius: 10,
                                      forwardAnimationCurve:
                                          Curves.fastLinearToSlowEaseIn,
                                      messageText:
                                          Text('Could not find relevant note'),
                                    ).show(context);
                                  }
                                });
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Icon(Icons.search),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.search),
                  ),
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
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: List.generate(
                      notes.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(
                            right: index.isEven ? 10 : 0, bottom: 10),
                        child: NoteCard(note: notes[index]),
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
