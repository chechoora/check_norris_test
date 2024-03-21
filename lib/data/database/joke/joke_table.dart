import 'package:drift/drift.dart';

class JokeTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get value => text().withLength(min: 3)();

  TextColumn get serverId => text()();

  @override
  Set<Column> get primaryKey => {id};
}
