import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/data/note_database.dart';
import 'package:note_app/screens/add_note.dart';

final controller = TextEditingController();
bool hasFound = false;

class SearchScreen extends StatelessWidget {
  final AppDatabase database;

  const SearchScreen(this.database);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                      builder: (context) => AddNote(note: note),
                    ),
                  );
                }
              }
              if (hasFound == false) {
                Flushbar(
                  margin: EdgeInsets.all(20),
                  dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                  borderColor: Colors.red,
                  borderRadius: 10,
                  forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
                  messageText: Text('Could not find relevant note'),
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
              child: Center(child: FaIcon(FontAwesomeIcons.search)),
            ),
          ),
        ),
      ],
    );
  }
}
