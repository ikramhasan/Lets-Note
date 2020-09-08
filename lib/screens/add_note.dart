import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:note_app/data/note_database.dart';
import 'package:note_app/widgets/buttons.dart';
import 'package:note_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class AddNote extends StatefulWidget {
  Note note;

  AddNote({this.note});

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);

    final colorList = [
      Color(0xFF82DEE9),
      Color(0xFFFEAA93),
      Color(0xFFFECB86),
      Color(0xFFE6EDA1),
      Color(0xFFCE95D6),
      Color(0xFFF38FB0),
      Color(0xFFC7D8C6),
      Color(0xFF8089B4),
      Color(0xFFCBB8CB),
      Color(0xFFC29BB8),
    ];

    Color color = colorList[0];

    if (widget.note != null) {
      _titleController.text = widget.note.title;
      _descriptionController.text = widget.note.description;
    }

    createNote() {
      Note note = Note(
        title: _titleController.text,
        description: _descriptionController.text,
        createdAt: DateTime.now(),
        colorValue: color.value,
      );
      database.insertNote(note);
    }

    updateNote() {
      widget.note.title = _titleController.text;
      widget.note.description = _descriptionController.text;
      widget.note.colorValue = color.value;
      database.updateNote(widget.note);
    }

    buildTick(Note note, Color color) {
      if (note == null) {
        return Container();
      } else if (note.colorValue == color.value) {
        return Center(child: FaIcon(FontAwesomeIcons.check));
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbar(
                appbarType: AppbarType.ADD_NOTE_SCREEN,
                onTap: () {
                  widget.note == null ? createNote() : updateNote();
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 25),
              LimitedBox(
                maxHeight: 50,
                child: ColorPicker(note: widget.note),
              ),
              TextField(
                controller: _titleController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: GoogleFonts.ubuntu(fontSize: 35),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: GoogleFonts.ubuntu(fontSize: 35),
                ),
              ),
              SizedBox(height: 20),
              widget.note != null
                  ? Text(
                      DateFormat.yMMMMd('en_US').format(widget.note.createdAt),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    )
                  : Container(),
              widget.note != null ? SizedBox(height: 20) : Container(),
              TextField(
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: GoogleFonts.ubuntu(fontSize: 22),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type Something...',
                  hintStyle: GoogleFonts.ubuntu(fontSize: 22),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: widget.note != null
          ? AppButton(
              buttonType: ButtonType.DELETE_BUTTON,
              onPressed: () {
                database.deleteNote(widget.note);
                Navigator.pop(context);
              })
          : Container(),
    );
  }
}
