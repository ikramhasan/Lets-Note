import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/data/note_database.dart';

class ColorPicker extends StatelessWidget {
  final Note note;

  const ColorPicker({Key key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    buildTick(Note note, Color color) {
      if (note == null) {
        return Container();
      } else if (note.colorValue == color.value) {
        return Center(child: FaIcon(FontAwesomeIcons.check));
      }
    }

    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: colorList.length,
      itemBuilder: (context, index) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                color = colorList[index];
              },
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colorList[index],
                ),
                child: buildTick(note, colorList[index]),
              ),
            ),
            SizedBox(width: 10),
          ],
        );
      },
    );
  }
}
