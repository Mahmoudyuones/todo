import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String id;
  String title;
  String description;
  bool isDone;
  DateTime date;

  TaskModel({
    this.id = '',
    required this.title,
    required this.description,
    required this.date,
    this.isDone = false,
  });

  TaskModel.fromjson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          title: json['title'],
          description: json['description'],
          date: (json['date'] as Timestamp).toDate(),
          isDone: json['isDone'],
        );

  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
      'date': Timestamp.fromDate(date),
    };
  }
}
