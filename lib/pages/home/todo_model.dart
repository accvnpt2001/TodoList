
import 'package:todolist/database/db_helper.dart';

class TodoModel {
  final int? id;
  final String? title;
  final String? description;
  final String? due;
  final int? level;

  TodoModel({this.id, this.title, this.description, this.due, this.level});

  factory TodoModel.fromJson(Map<String,dynamic> json) => TodoModel(
      id: json[DBHelper.columnId],
      title: json[DBHelper.columnTitle],
      description: json[DBHelper.columnDescription],
      due:  json[DBHelper.columnDue],
      level: json[DBHelper.columnLevel]
  );

  Map<String, dynamic> toJson() => {
    DBHelper.columnId: id,
    DBHelper.columnTitle: title,
    DBHelper.columnDescription: description,
    DBHelper.columnDue: due,
    DBHelper.columnLevel: level
  };
}