import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/blocs/note_bloc.dart';
import 'package:note_app/screens/screens.dart';
import 'package:note_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class NoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final noteBloc = Provider.of<NoteBloc>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomAppbar(
                appbarType: AppbarType.NOTE_SCREEN,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.grey[900],
                      content: SearchScreen(noteBloc.database),
                    ),
                  );
                }),
            Expanded(
              child: StreamBuilder(
                stream: noteBloc.database.watchAllNotes(),
                builder: (context, snapshot) {
                  final notes = snapshot.data ?? List();
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Lottie.asset('assets/animations/loading.json'),
                    );
                  }
                  return snapshot.data.length > 0
                      ? StaggeredGridView.countBuilder(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          itemCount: notes.length,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: NoteCard(note: notes[index]),
                          ),
                          physics: BouncingScrollPhysics(),
                          staggeredTileBuilder: (index) =>
                              StaggeredTile.count(index % 3 == 0 ? 2 : 1, 1),
                        )
                      : NoNote();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AppButton(
          buttonType: ButtonType.ADD_BUTTON,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddNote(),
              ),
            );
          }),
    );
  }
}
