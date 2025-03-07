class TaskModel {
  String id;
  String title;
  String description;
  bool isDone;
  DateTime date;
  TaskModel(
      {this.id = '',
      required this.title,
      required this.description,
      required this.date,
      this.isDone = false});
}
