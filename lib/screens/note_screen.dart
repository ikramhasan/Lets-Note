import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/blocs/note_bloc.dart';
import 'package:note_app/screens/screens.dart';
import 'package:note_app/widgets/note_card.dart';

class NoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final noteBloc = Get.put(NoteBloc());
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
            noteBloc.noteList.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\"If you give people nothingness, they can ponder what can be achieved from that nothingness\"',
                          style: TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Text(
                            '-Tadao Ando',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: GetBuilder<NoteBloc>(builder: (_) {
                      return GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        children: List.generate(
                          noteBloc.noteList.length,
                          (index) => Padding(
                            padding: EdgeInsets.only(
                                right: index.isEven ? 10 : 0, bottom: 10),
                            child: NoteCard(noteBloc.noteList[index]),
                          ),
                        ),
                      );
                    }),
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
