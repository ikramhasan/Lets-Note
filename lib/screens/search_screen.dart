import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/data/note_database.dart';
import 'package:note_app/screens/add_note.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    List<Note> notes = [];
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 100),
          TextField(
            controller: controller,
          ),
          InkWell(
            onTap: () {
              database.getAllNotes().then((value) {
                value.any((element) {
                  if ((element.title == controller.text) ||
                      (element.description == controller.text)) {
                    setState(() {
                      element != null ? notes.add(element) : notes = [];
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddNote(note: element),
                        ));
                    element != null ? print(notes[0].title) : notes = [];
                    return true;
                  } else {
                    return false;
                  }
                });
              });
            },
            child: FaIcon(FontAwesomeIcons.search),
          ),
        ],
      ),
    );
  }
}
