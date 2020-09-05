import 'package:moor_flutter/moor_flutter.dart';

part 'note_database.g.dart';

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  IntColumn get colorValue => integer()();
  DateTimeColumn get createdAt => dateTime()();
}

@UseMoor(tables: [Notes])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));
  @override
  int get schemaVersion => 1;

  Future<List<Note>> getAllNotes() => select(notes).get();
  Stream<List<Note>> watchAllNotes() => select(notes).watch();

  Future insertNote(Note note) => into(notes).insert(note);
  Future updateNote(Note note) => update(notes).replace(note);
  Future deleteNote(Note note) => delete(notes).delete(note);
}
