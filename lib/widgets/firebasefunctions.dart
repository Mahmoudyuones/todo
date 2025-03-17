import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/models/user_model.dart';
import 'package:todo/models/task_model.dart';

class Firebasefunctions {
  static CollectionReference<TaskModel> getTasksCollections() {
    return FirebaseFirestore.instance.collection('tasks').withConverter(
          fromFirestore: (snapshot, _) => TaskModel.fromjson(snapshot.data()!),
          toFirestore: (taskModel, _) => taskModel.tojson(),
        );
  }

  static CollectionReference<UserModel> getUsersCollections() {
    return FirebaseFirestore.instance.collection('Users').withConverter(
          fromFirestore: (snapshot, _) => UserModel.fromjson(snapshot.data()!),
          toFirestore: (userModel, _) => userModel.tojson(),
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

  static Future<UserModel> register(
      {required String name,
      required String email,
      required String password}) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    UserModel user =
        UserModel(name: name, email: email, id: credential.user!.uid);
    CollectionReference<UserModel> usersCollections = getUsersCollections();
    await usersCollections.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login(
      {required String email, required String password}) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    CollectionReference<UserModel> usersCollections = getUsersCollections();
    DocumentSnapshot<UserModel> docSnapshot =
        await usersCollections.doc(credential.user!.uid).get();
    return docSnapshot.data()!;
  }

  Future<void> signOut() => FirebaseAuth.instance.signOut();
}
