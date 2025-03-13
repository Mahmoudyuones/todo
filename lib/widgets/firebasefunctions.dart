import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/taps/tasks/task_model.dart';

class Firebasefunctions {
  static CollectionReference<TaskModel> getTasksCollections() {
    return FirebaseFirestore.instance.collection('tasks').withConverter(
          fromFirestore: (snapshot, _) => TaskModel.fromjson(snapshot.data()!),
          toFirestore: (taskModel, _) => taskModel.tojson(),
        );
  }

  static Future<void> addTaskToFireStore(TaskModel task) {
    CollectionReference<TaskModel> tasksCollections = getTasksCollections();
    DocumentReference<TaskModel> doc = tasksCollections.doc();
    task.id = doc.id;
    return doc.set(task);
  }

  static Future<List<TaskModel>> getAllTasksFromFirestore() async {
    CollectionReference<TaskModel> tasksCollections = getTasksCollections();
    QuerySnapshot<TaskModel> querySnapshot =
        await tasksCollections.orderBy('date', descending: true).get();
    return querySnapshot.docs
        .map((daocSnapshot) => daocSnapshot.data())
        .toList();
  }

  static Future<void> deleteTaskFromFirestore(String id) async {
    CollectionReference<TaskModel> tasksCollections = getTasksCollections();
    return tasksCollections.doc(id).delete();
  }
}
