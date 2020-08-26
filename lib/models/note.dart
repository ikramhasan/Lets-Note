import 'package:flutter/widgets.dart';

class Note {
  final String title;
  final String description;
  final DateTime date;
  final Color color;

  Note({
    @required this.title,
    @required this.description,
    @required this.date,
    @required this.color,
  });
}
