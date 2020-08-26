import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  final colorList;

  ColorPicker({@required this.colorList});

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  bool hasClicked = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: showColors(widget.colorList),
      ),
    );
  }

  List<Widget> showColors(List colorList) {
    List<Widget> colorWidgets = [];

    Widget colorWidget(Color color) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              setState(() {
                hasClicked = !hasClicked;
              });
            },
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: hasClicked ? Icon(Icons.done) : Container(),
            ),
          ),
        );

    for (int i = 0; i < colorList.length; i++) {
      colorWidgets.add(colorWidget(colorList[i]));
    }
    return colorWidgets;
  }
}
